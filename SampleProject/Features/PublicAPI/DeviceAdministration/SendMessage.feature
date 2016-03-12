Feature: SendMessage API
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
Scenario Outline: SendMessage api test
	Given I am a user with name 'Administrator' and password '1'
	And I have granted principal 'SSPUser' the permissions as follows:
		| SecurityRole | PermissionType | PermissionName   | IsAllowed   |
		| DeviceOwner  | Feature        | LoginSSP         | true        |
		| DeviceOwner  | Device         | SendMessage      | true |
	When I am a user with name 'SSPUser' and password 'Welcome1234' and role 'ssp'
	And I call Public API function SendMessage using request with properties as follows: 
	| DeviceIdentity.Id  | DeviceIdentity.DevicePropertyIdType | Message   |
	| <DeviceIdentifier> | <DeviceIdentityType>                | <Message> |
	Then Public API response is '<Result>'

Examples:
| DeviceIdentifier | DeviceIdentityType | Message                                     | Result              |
| deviceId.{guid}  | DeviceId           | The quick brown fox jumps over the lazy dog | OK                  |
| deviceId.{guid}  | DeviceId           | ♀  N∞v╪│ñ╣~☼►♀♫♪♀☼◄↕‼♂♀▬!BΦ                 | OK                  |
| nonexistingid    | DeviceId           | Hello World!                                | Unauthorized access |
| {null}           | DeviceId           | Hello World!                                | errorCode: 1        |
| mac.{guid}       | MacAddress         | The quick brown fox jumps over the lazy dog | OK                  |
| mac.{guid}       | MacAddress         | ♀  N∞v╪│ñ╣~☼►♀♫♪♀☼◄↕‼♂♀▬!BΦ                 | OK                  |
| nonexistingid    | MacAddress         | Hello World!                                | Unauthorized access |
| {null}           | MacAddress         | Hello World!                                | errorCode: 1        |
| imei.{guid}      | ImeiMeid           | The quick brown fox jumps over the lazy dog | OK                  |
| imei.{guid}      | ImeiMeid           | ♀  N∞v╪│ñ╣~☼►♀♫♪♀☼◄↕‼♂♀▬!BΦ                 | OK                  |
| nonexistingid    | ImeiMeid           | Hello World!                                | Unauthorized access |
| {null}           | ImeiMeid           | Hello World!                                | errorCode: 1        |
