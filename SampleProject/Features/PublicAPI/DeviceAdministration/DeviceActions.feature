Feature: Device actions API
Background:
Given I am a user with name 'Administrator' and password '1'
And I have enabled LDAP integration for LDAP connection '{sotiqa}'
And I have created principals as follows:
	| PrincipalType       | Name     | DisplayName | DomainName | LdapConnectionName | MemberOf                   |
	| ActiveDirectoryUser | SSPUser  | SSP1        | SOTIQA     | {sotiqa}           | MobiControl Administrators |
And I enrolled Ios Device with properties as follows(execute once):
	| DeviceName                             | RuleName         | LdapUserName | LdapUserPassword | DeviceId                     | MacAddress              | Imei                     |
	| autogenerate IosSimulatorDevice.{guid} | {iosrule_sotiqa} | SSPUser      | Welcome1234      | autogenerate deviceId.{guid} | autogenerate mac.{guid} | autogenerate imei.{guid} |
And I am a client of Public API with name 'ApiClient' and secret 'ClientSecret'
	And I make calls to Public API on behalf of user 'SSPUser' with password 'Welcome1234'

@CarryOverScenarioContext
Scenario Outline: Send script API test
	Given I have granted principal 'SSPUser' the old permissions as follows:
		| TargetGroups   | AccessRight   |
		| \\\\My Company | <AccessRight> |
	When I execute a device action with options as follows:
		| DeviceId           | ActionInfo   | Message   |
		| <DeviceIdentifier> | <Action>		| <Script>  |
	Then Public API response is '<Result>'

Examples:
| AccessRight      | DeviceIdentifier | Action     | Script                            | Result                                                                                      |
| SendDeviceScript | deviceId.{guid}  | SendScript | This is a script                  | message: Send Script Failed. The specified device does not support the send script command. |
| SendDeviceScript | deviceId.{guid}  | SendScript | Script with unicode ☼~ç►wrteqr♫↕♪ | message: Send Script Failed. The specified device does not support the send script command. |
| SendDeviceScript | nonexistingid    | SendScript | This is a script                  | Unauthorized access                                                                         |
| SendDeviceScript | {null}           | SendScript | This is a script                  | errorCode: 0                                                                                |
| None             | deviceId.{guid}  | SendScript | This is a script                  | message: Send Script Failed. The specified device does not support the send script command. |