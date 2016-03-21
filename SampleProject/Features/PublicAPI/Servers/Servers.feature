Feature: Server
	REST API for GET-ting servers

Background:
Given  I am a user with name 'Administrator' and password '1'
	And I have enabled LDAP integration for LDAP connection '{sotiqa}'
	And I have created principals as follows:
	| PrincipalType       | Name    | DisplayName | DomainName | LdapConnectionName | MemberOf                   |
	| ActiveDirectoryUser | SSPUser | SSP1        | SOTIQA     | {sotiqa}           | MobiControl Administrators |

@CarryOverScenarioContext
Scenario: Get All Servers
	Given I am a client of Public API with name 'ApiClient' and secret 'ClientSecret'
	And I make calls to Public API on behalf of user 'Administrator' with password '1'
	When I invoke GET on Servers without parameters.
	Then Public API response includes DS servers.
	Then Public API response includes MS servers.
	Then Public API response is 'OK'

@ignore
@CarryOverScenarioContext
Scenario: Multiple Users
Given I am a client of Public API with name 'ApiClient' and secret 'ClientSecret'
	#And I am a user with name 'SSPUser' and password 'Welcome1234'
	And I am a system administrator
	And I make calls to Public API on behalf of user 'Administrator' with password '1'
	When I invoke GET on Servers without parameters.
	Then MS Server in response includes '1' total console users.