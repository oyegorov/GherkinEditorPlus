Feature: Adding Ldap Connection
	In order to integrate with LDAP
	Administrator wants to configure LDAP parameters

Scenario: Creating new LDAP connection
Given I am a user with name 'Administrator' and password '1'
When I make a call to public API to create an ldap connection with request properties as follows:
| Name                               | Server        | UserName  | Password   | Base DN                |
| autogenerate {guid}.LdapConnection | corp.soti.net | testuser2 | Bonjour321 | DC=corp,DC=soti,DC=net |
Then Ldap connection is successfully created with the properties as specified
