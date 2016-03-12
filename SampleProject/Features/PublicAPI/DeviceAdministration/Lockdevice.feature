Feature: LockDevice API
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
Scenario Outline: LockDevice api test
	Given I am a user with name 'Administrator' and password '1'
	And I have granted principal 'SSPUser' the permissions as follows:
		| SecurityRole | PermissionType | PermissionName | IsAllowed |
		| DeviceOwner  | Feature        | LoginSSP       | true      |
		| DeviceOwner  | Device         | Lock           | true      |
	When I am a user with name 'SSPUSer' and password 'Welcome1234' and role 'ssp'
	And I call Public API function LockDevice using request with properties as follows:
	| DeviceIdentity.Id  | DeviceIdentity.DevicePropertyIdType | PhoneNumber   | Message   |
	| <DeviceIdentifier> | <DeviceIdentityType>                | <PhoneNumber> | <Message> |
	Then Public API response is '<Result>'

Examples:
| DeviceIdentifier | DeviceIdentityType | PhoneNumber   | Message         | Result              |
| deviceId.{guid}  | DeviceId           | 9056249828    | Return if found | OK                  |
| deviceId.{guid}  | DeviceId           | 9056249828    | ☼♀♪♫☼►◄↕‼æÑ║«├  | OK                  |
| deviceId.{guid}  | DeviceId           | 9056249828    |                 | OK                  |
| deviceId.{guid}  | DeviceId           |               | Return if found | OK                  |
| deviceId.{guid}  | DeviceId           |               |                 | OK                  |
| deviceId.{guid}  | DeviceId           | Please Return | Return if found | OK                  |
| nonexistingid    | DeviceId           | 9056249828    | Return if found | Unauthorized access |
| {null}           | DeviceId           | 9056249828    | Return if found | errorCode:1         |
| mac.{guid}       | MacAddress         | 9056249828    | Return if found | OK                  |
| mac.{guid}       | MacAddress         | 9056249828    | ☼♀♪♫☼►◄↕‼æÑ║«├  | OK                  |
| mac.{guid}       | MacAddress         | 9056249828    |                 | OK                  |
| mac.{guid}       | MacAddress         |               | Return if found | OK                  |
| mac.{guid}       | MacAddress         |               |                 | OK                  |
| nonexistingid    | MacAddress         | 9056249828    | Return if found | Unauthorized access |
| {null}           | MacAddress         | 9056249828    | Return if found | errorCode:1         |
| imei.{guid}      | ImeiMeid           | 9056249828    | Return if found | OK                  |
| imei.{guid}      | ImeiMeid           | 9056249828    | ☼♀♪♫☼►◄↕‼æÑ║«├  | OK                  |
| imei.{guid}      | ImeiMeid           | 9056249828    |                 | OK                  |
| imei.{guid}      | ImeiMeid           |               | Return if found | OK                  |
| imei.{guid}      | ImeiMeid           |               |                 | OK                  |
| nonexistingid    | ImeiMeid           | 9056249828    | Return if found | Unauthorized access |
| {null}           | ImeiMeid           | 9056249828    | Return if found | errorCode:1         |