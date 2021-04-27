# LDAP Implementations
Lightweight Directory Access Protocol

details about LDAP and micro$soft Active directory. 


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=3 orderedList=false} -->

<!-- code_chunk_output --


<!-- /code_chunk_output -->

# Active Directory
implementation of LDAP by the micro$soft greed.

## Queries examples
the queries were executed in Apache Directory Studio. It makes life easier to query LDAP servers.

1. set the connection first > open the connection
1. go to search or CTRL + H
1. Set search parameters as indicated below to search in the whole tree

### Search Properties to validate in Active directory Studio

- todo. create table here with the generic values

#### Get users and department
Search base = OU=MAIN,DC=EXAMPLE,DC=ORG,DC=INT
filter = (objectClass=person)
returning attributes = department
Scope = Subtree
`Apply and Close`

#### - todo create other searches just with the search parameters

**Returns**
`"CN=User name,OU=Users,OU=Chicago,OU=USA,OU=AMERICAS,OU=MAIN,DC=EXAMPLE,DC=ORG,DC=INT"	"Human Resources"`
