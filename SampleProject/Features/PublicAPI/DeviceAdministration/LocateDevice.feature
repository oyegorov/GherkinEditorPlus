Feature: LocateDevice API

Background:
Given I am a user with name 'Administrator' and password '1'
And I have enabled LDAP integration for LDAP connection '{sotiqa}'
And I have created principals as follows:
	| PrincipalType       | Name    | DisplayName | DomainName | LdapConnectionName | MemberOf                   |
	| ActiveDirectoryUser | SSPUser | SSP1        | SOTIQA     | {sotiqa}           | MobiControl Administrators |
And I enrolled Ios Device with properties as follows(execute once):
	| DeviceName                       | RuleName         | LdapConnection | LdapUserName | LdapUserPassword | DeviceId                     | MacAddress              | Imei                     |
	| autogenerate IosSimulator.{guid} | {iosrule_sotiqa} | {sotiqa}       | SSPUser      | Welcome1234      | autogenerate deviceId.{guid} | autogenerate mac.{guid} | autogenerate imei.{guid} |

@CarryOverScenarioContext
Scenario Outline: LocateDevice api test
	Given I am a user with name 'Administrator' and password '1'
	And I have granted principal 'SSPUser' the permissions as follows:
		| SecurityRole | PermissionType | PermissionName | IsAllowed |
		| DeviceOwner  | Feature        | LoginSSP       | true      |
		| DeviceOwner  | Device         | Locate         | true      |
	When I am a user with name 'SSPUser' and password 'Welcome1234' and role 'ssp'
	And I call Public API function LocateDevice using request with properties as follows:
	| DeviceIdentity.Id  | DeviceIdentity.DevicePropertyIdType |
	| <DeviceIdentifier> | <DeviceIdentityType>                |
	Then Public API response is '<Result>'
	 
Examples:
 | DeviceIdentifier | DeviceIdentityType | Result              |
 | deviceId.{guid}  | DeviceId           | OK               |
 | mac.{guid}       | MacAddress         | OK                  |
 | imei.{guid}      | ImeiMeid           | OK                  |
 | nonexistingid    | DeviceId           | Unauthorized access |
 | nonexistingid    | MacAddress         | Unauthorized access |
 | nonexistingid    | ImeiMeid           | Unauthorized access |
 | {null}           | ImeiMeid           | errorCode:1         |
 | {null}           | MacAddress         | errorCode:1         |
 | {null}           | DeviceId           | errorCode:1         |
 