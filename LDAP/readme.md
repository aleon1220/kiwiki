- [LDAP Implementations](#ldap-implementations)
- [Active Directory](#active-directory)
  - [Queries examples](#queries-examples)
    - [Search Properties to validate in Active directory Studio](#search-properties-to-validate-in-active-directory-studio)
      - [Get Users and Department](#get-users-and-department)
      - [Persons with mail and department that they belong to](#persons-with-mail-and-department-that-they-belong-to)
      - [userID, mail and department for people whame start with Alexander](#userid-mail-and-department-for-people-whame-start-with-alexander)
      - [emailID and department of 2 given users (can add more if needed) uses estrict matching](#emailid-and-department-of-2-given-users-can-add-more-if-needed-uses-estrict-matching)
      - [sAMAccountName, emailID and department of 2 given users (add more users if needed) uses OR `|` matching. It will bring an empty data column if it doesnt match](#samaccountname-emailid-and-department-of-2-given-users-add-more-users-if-needed-uses-or--matching-it-will-bring-an-empty-data-column-if-it-doesnt-match)

[Kiwiki Home](/../../)
# LDAP Implementations
Lightweight Directory Access Protocol. LDAP and micro$soft Active directory
# Active Directory
implementation of LDAP by the micro$soft greed.

## Queries examples
the queries were executed in Apache Directory Studio. It makes life easier to query LDAP servers.

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

[Back to top](#)

[Kiwiki Home](/../../)