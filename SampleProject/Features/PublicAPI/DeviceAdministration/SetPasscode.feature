Feature: SetPasscode API
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
Scenario Outline: SetPasscode api test
	Given I am a user with name 'Administrator' and password '1'
	And I have granted principal 'SSPUser' the permissions as follows:
		| SecurityRole | PermissionType | PermissionName   | IsAllowed   |
		| DeviceOwner  | Feature        | LoginSSP         | true        |
		| DeviceOwner  | Device         | SetPasscode      | true |
	When I am a user with name 'SSPUser' and password 'Welcome1234' and role 'ssp'
	And I call Public API function SetPasscode using request with properties as follows:
	| DeviceIdentity.Id  | DeviceIdentity.DevicePropertyIdType | password   |
	| <DeviceIdentifier> | <DeviceIdentityType>                | <password> |
	Then Public API response is '<Result>'

Examples:
| DeviceIdentifier | DeviceIdentityType | password | Result              |
| deviceId.{guid}  | DeviceId           | 1111     | OK                  |
| deviceId.{guid}  | DeviceId           | abcd     | OK                  |
| deviceId.{guid}  | DeviceId           | SoT1@!   | OK                  |
| deviceId.{guid}  | DeviceId           |          | OK                  |
| nonexistingid    | DeviceId           | 1234     | Unauthorized access |
| {null}           | DeviceId           | qwerty1@ | errorCode: 1		 |
| mac.{guid}       | MacAddress         | 1111     | OK                  |
| mac.{guid}       | MacAddress         | abcd     | OK                  |
| mac.{guid}       | MacAddress         | SoT1@!   | OK                  |
| mac.{guid}       | MacAddress         |          | OK                  |
| nonexistingid    | MacAddress         | 1234     | Unauthorized access |
| {null}           | MacAddress         | qwerty1@ | errorCode: 1        |
| imei.{guid}      | ImeiMeid           | 1111     | OK                  |
| imei.{guid}      | ImeiMeid           | abcd     | OK                  |
| imei.{guid}      | ImeiMeid           | SoT1@!   | OK                  |
| imei.{guid}      | ImeiMeid           |          | OK                  |
| nonexistingid    | ImeiMeid           | 1234     | Unauthorized access |
| {null}           | ImeiMeid           | qwerty1@ | errorCode: 1        |
