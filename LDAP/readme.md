- [LDAP Implementations](#ldap-implementations)
  - [Active Directory](#active-directory)
  - [Queries examples](#queries-examples)
    - [Search Properties to validate in Active directory Studio](#search-properties-to-validate-in-active-directory-studio)
      - [Get Users and Department](#get-users-and-department)
      - [Persons with mail and department that they belong to](#persons-with-mail-and-department-that-they-belong-to)
      - [userID, mail and department for people whame start with Alexander](#userid-mail-and-department-for-people-whame-start-with-alexander)
      - [emailID and department of 2 given users (can add more if needed) uses estrict matching](#emailid-and-department-of-2-given-users-can-add-more-if-needed-uses-estrict-matching)
      - [sAMAccountName, emailID and department of 2 given users (add more users if needed) uses OR `|` matching. It will bring an empty data column if it doesnt match](#samaccountname-emailid-and-department-of-2-given-users-add-more-users-if-needed-uses-or--matching-it-will-bring-an-empty-data-column-if-it-doesnt-match)
      - [All objects](#all-objects)
      - [All user objects designated as a “person”](#all-user-objects-designated-as-a-person)
      - [Distribution Lists only](#distribution-lists-only)
      - [Public Folders only](#public-folders-only)
      - [All user objects except for ones with primary email addresses that begin with test](#all-user-objects-except-for-ones-with-primary-email-addresses-that-begin-with-test)
      - [All user objects except for ones with primary email addresses that end with test](#all-user-objects-except-for-ones-with-primary-email-addresses-that-end-with-test)
      - [All user objects except for ones with primary email addresses that contain the word “test”](#all-user-objects-except-for-ones-with-primary-email-addresses-that-contain-the-word-test)
      - [All user objects (users and aliases) that are designated as a “person” and all group objects (distribution lists)](#all-user-objects-users-and-aliases-that-are-designated-as-a-person-and-all-group-objects-distribution-lists)
      - [All user objects that are designated as a “person”, all group objects and all contacts, except those with any value defined for extensionAttribute9](#all-user-objects-that-are-designated-as-a-person-all-group-objects-and-all-contacts-except-those-with-any-value-defined-for-extensionattribute9)
      - [All users, but exclude disabled users](#all-users-but-exclude-disabled-users)
    - [Active Directory LDAP](#active-directory-ldap)
      - [All users](#all-users)
      - [All email users (alternate)](#all-email-users-alternate)
    - [OpenLDAP](#openldap)
      - [All users](#all-users-1)
    - [Lotus Domino LDAP](#lotus-domino-ldap)
      - [All users](#all-users-2)
      - [All objects with a mail address defined that are designated as a “person “or “group”:](#all-objects-with-a-mail-address-defined-that-are-designated-as-a-person-or-group)
- [LDAP Tools and Browsers](#ldap-tools-and-browsers)
  - [Softerra LDAP Administrator](#softerra-ldap-administrator)
  - [JXplorer](#jxplorer)
- [LDAP Resources \& References](#ldap-resources--references)

[Kiwiki Home](/../../)
# LDAP Implementations
Lightweight Directory Access Protocol
## Active Directory
implementation of LDAP by micro$soft

## Queries examples
the queries were executed in [Apache Directory Studio](https://directory.apache.org/apacheds/), makes life easier to query LDAP servers

1. set the connection first > open the connection
1. go to search or CTRL + H
1. Set search parameters as indicated in the table below to search in the whole tree

| Property                 | Value                            | Description                                                        |
|--------------------------|----------------------------------|--------------------------------------------------------------------|
| Search name              | user defined                     | My suggestion is<br>YYYY-MM-DD_HH-mm-Name                          |
| Connection               | user defined                     | preferably use a <br>Service user with no<br>password expiration   |
| search base              |`OU=MAIN,DC=EXAMPLE,DC=ORG,DC=INT`| a random domain <br>example.org.int                                |
| Filter                   | user defined                     | the queries below will include simple 2<br>row tables with queries |
| Returning <br>attributes | user defined                     | in Apache directory it returns DN + attributes                     |
| Controls                 | Unamrked all 3                   | ManageDsalT<br>subentries<br>Paged search                          |
| Scope                    | subtree                          | todo add reference to docs                                         |
| Aliases Dereferencing    | Finding Base DN<br>Search        | todo                                                               |
| Limits                   | Count Limit 1000<br>Time limit 0 | todo                                                               |
| Referrals Handling       | Follow referrals manually        | todo                                                               |


### Search Properties to validate in Active directory Studio

#### Get Users and Department

|                         |               |
|-------------------------|---------------|
| Filter                  | (objectClass=person) |
| Returning<br>Attributes | **department** |


**Returns**
|     DN                  |    Department           |
|-------------------------|---------------|
| `"CN=User name,OU=Users,OU=Chicago,OU=USA,OU=AMERICAS,OU=MAIN,DC=EXAMPLE,DC=ORG,DC=INT"` | `"Human Resources"`|

#### Persons with mail and department that they belong to
|                         |               |
|-------------------------|---------------|
| Filter                  |  (objectClass=person)    |
| Returning<br>Attributes | **mailNickname, department** |

#### userID, mail and department for people whame start with Alexander
|                         |               |
|-------------------------|---------------|
| Filter                  | `(\|(sAMAccountName=Alexander.*))`  |
| Returning<br>Attributes | **sAMAccountName, mailNickname, department** |

#### emailID and department of 2 given users (can add more if needed) uses estrict matching
|                         | 2 attributes  |
|-------------------------|---------------|
| Filter                  | `(\&(objectClass=person)(mailNickname="john.doe", "another.user"))` |
| Returning<br>Attributes | **mailNickname, department** |

#### sAMAccountName, emailID and department of 2 given users (add more users if needed) uses OR `|` matching. It will bring an empty data column if it doesnt match
|     Filter              | get 3 attributes |
|-------------------------|---------------|
| Filter                  | `(\|(objectClass=person)(mailNickname="john.doe", "another.user"))` |
| Returning<br>Attributes | **sAMAccountName, mailNickname, department** |

#### All objects
_(this may cause load problems)_
```ldap
objectclass=*.
```

#### All user objects designated as a “person”
```ldap
(&(objectclass=user)(objectcategory=person))
```

#### Distribution Lists only
```ldap
(objectcategory=group)
```

#### Public Folders only
```ldap
(objectcategory=publicfolder)
```
#### All user objects except for ones with primary email addresses that begin with test
```ldap
(&(&(objectclass=user)(objectcategory=person))(!(mail=test*)))
```

#### All user objects except for ones with primary email addresses that end with test
```ldap
(&(&(objectclass=user)(objectcategory=person))(!(mail=*test)))
```

#### All user objects except for ones with primary email addresses that contain the word “test”
```ldap
(&(&(objectclass=user)(objectcategory=person))(!(mail=*test*)))
```

#### All user objects (users and aliases) that are designated as a “person” and all group objects (distribution lists)
```ldap
(|(&(objectclass=user)(objectcategory=person))(objectcategory=group))
```
#### All user objects that are designated as a “person”, all group objects and all contacts, except those with any value defined for extensionAttribute9
```ldap
(&(|(|(&(objectclass=user)(objectcategory=person))(objectcategory=group))(objectclass=contact))(!(extensionAttribute9=*)))
```
#### All users, but exclude disabled users
```ldap
(&(&(objectclass=user)(objectcategory=person))(!(userAccountControl=514)))
```
### Active Directory LDAP

#### All users
```ldap
(objectClass=person)
```
#### All email users (alternate)
```ldap
(&(objectclass=user)(objectcategory=person))
```
### OpenLDAP
#### All users
```ldap
(objectClass=inetOrgPerson)
```

### Lotus Domino LDAP
#### All users
```ldap
(objectClass=dominoPerson)
```

#### All objects with a mail address defined that are designated as a “person “or “group”:
```ldap
(&(|(objectclass=dominoPerson)(objectclass=dominoGroup)(objectclass=dominoServerMailInDatabase))(mail=*))
```

# LDAP Tools and Browsers
Most LDAP directory servers don't provide a native way to view or modify LDAP structure directly. Therefore, consider downloading an LDAP browser. To collect information about your LDAP structure, download and install an LDAP browser. Two such browsers are listed below.

## Softerra LDAP Administrator
To download Softerra LDAP Administrator, [click here](http://www.ldapbrowser.com).

## JXplorer
To download the JXplorer Java Ldap Browser, [click here](http://www.jxplorer.org).

# LDAP Resources & References

- [Google Enterprise Support](http://www.google.com/support/enterprise/static/postini/docs/admin/en/dss_admin/prep_ldap.html)
- [LDAP Man - Intro to LDAP](http://www.ldapman.org/articles/intro_to_ldap.html)
- [InformIT Article](http://www.informit.com/articles/article.aspx?p=101405&seqNum=7)
- [O'Reilly Archive - 10 minute LDAP tutorial](http://archive.oreilly.com/pub/a/perl/excerpts/system-admin-with-perl/ten-minute-ldap-utorial.html)
- [MSDN Library](https://msdn.microsoft.com/en-us/library/windows/desktop/ms677604(v=vs.85).aspx)
- [BeginLinux - Basics of LDAP](https://beginlinux.com/server_training/server-managment-topics/1015-basics-of-ldap)

[Back to top](#)

[Kiwiki Home](/../../)