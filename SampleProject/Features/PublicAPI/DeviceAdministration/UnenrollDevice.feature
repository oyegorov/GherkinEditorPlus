Feature: UnenrollDevice API
Background:
Given I am a user with name 'Administrator' and password '1'
And I have enabled LDAP integration for LDAP connection '{sotiqa}'
And I have created principals as follows:
	| PrincipalType       | Name    | DisplayName | DomainName | LdapConnectionName | MemberOf                   |
	| ActiveDirectoryUser | SSPUser | SSP1        | SOTIQA     | {sotiqa}           | MobiControl Administrators |
And I enrolled Ios Device with properties as follows(execute once):
	| DeviceName                             | RuleName         | LdapConnection | LdapUserName | LdapUserPassword | DeviceId                     | MacAddress              | Imei                     |
	| autogenerate IosSimulatorDevice.{guid} | {iosrule_sotiqa} | {sotiqa}       | SSPUser      | Welcome1234      | autogenerate deviceId.{guid} | autogenerate mac.{guid} | autogenerate imei.{guid} |

@CarryOverScenarioContext
Scenario Outline: UnenrollDevice api test
	Given I am a user with name 'Administrator' and password '1'
	And I have granted principal 'SSPUser' the permissions as follows:
		| SecurityRole | PermissionType | PermissionName | IsAllowed   |
		| DeviceOwner  | Feature        | LoginSSP       | true        |
		| DeviceOwner  | Device         | Unenroll       | true        |
	When I am a user with name 'SSPUser' and password 'Welcome1234' and role 'ssp'
    And I call Public API function UnenrollDevice using request with properties as follows:
         | DeviceIdentity.Id | DeviceIdentity.DevicePropertyIdType |
         | <DeviceIdentifier> | <DeviceIdentityType>                |
	Then Public API response is '<Result>'

Examples:
| DeviceIdentifier | DeviceIdentityType | Result              |
| deviceId.{guid}  | DeviceId           | OK                  |
| nonexistingid    | DeviceId           | Unauthorized access |
| {null}           | DeviceId           | errorCode: 1        |
| mac.{guid}       | MacAddress         | OK                  |
| nonexistingid    | MacAddress         | Unauthorized access |
| {null}           | MacAddress         | errorCode: 1        |
| imei.{guid}      | ImeiMeid           | OK                  |
| nonexistingid    | ImeiMeid           | Unauthorized access |
| {null}           | ImeiMeid           | errorCode: 1        |