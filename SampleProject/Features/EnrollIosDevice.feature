Feature: Enrolling Ios Device

# We need to come up with a way to intercept requests to APNS server for device checkin
@ignore
Scenario: Enrolling iOS device with Ldap Authentication
Given I am a user with name 'Administrator' and password '1'
    And I uploaded an APNS certificate from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\iOS_Certificate.pfx ' with password '123456'
    And I have configured LDAP connection as follows:
    | Name                               | Server        | UserName  | Password   | Base DN                |
    | autogenerate {guid}.LdapConnection | corp.soti.net | testuser2 | Bonjour321 | DC=corp,DC=soti,DC=net |
    And I have created a rule as follows:
    | Name                         | DeviceFamily | TargetGroups | LdapConnection        | Priority |
    | autogenerate {guid}.RuleName | Ios          | \\My Company | {guid}.LdapConnection | Normal   |
	And Ios Device contains applications as follows:
		| Name                                | Identifier                | ShortVersion | Version | BundleSize | DynamicSize |
		| autogenerate {guid}.ApplicationName | autogenerate {guid}.AppId | 1.0          | 1.0.0   | 1024       | 2048        |
		| autogenerate {guid}.ApplicationName | autogenerate {guid}.AppId | 1.1          | 1.1.0   | 2048       | 4096        |
When I enroll an Ios Device with information as follows:
| DeviceName                                     | LdapUserName | LdapUserPassword |
| autogenerate iosSimulator.{buildnumber}.{guid} | testuser2    | Bonjour321       |
Then The device is succesfully enrolled to the rule target
	And The the statuses of the profiles returned from public API for the device are as follows:
	| ProfileName     | Status    |
	| Profile Catalog | Installed |
	| App Catalog     | Installed |

Scenario: Enrolling iOS device with Ldap Authentication compact
Given I am a user with name 'Administrator' and password '1'
And Ios Device contains applications as follows:
	| Name                                | Identifier                | ShortVersion | Version | BundleSize | DynamicSize |
	| autogenerate {guid}.ApplicationName | autogenerate {guid}.AppId | 1.0          | 1.0.0   | 1024       | 2048        |
	| autogenerate {guid}.ApplicationName | autogenerate {guid}.AppId | 1.1          | 1.1.0   | 2048       | 4096        |
	| autogenerate {guid}.ApplicationName | autogenerate {guid}.AppId | 1.2          | 1.2.0   | 4096       | 8192        |
	| autogenerate {guid}.ApplicationName | autogenerate {guid}.AppId | 1.3          | 1.3.0   | 8192       | 16384       |
	| autogenerate {guid}.ApplicationName | autogenerate {guid}.AppId | 1.4          | 1.4.0   | 16384      | 32768       |
	| autogenerate {guid}.ApplicationName | autogenerate {guid}.AppId | 1.5          | 1.5.0   | 32768      | 65536       |
And I enrolled Ios Device with properties as follows:
	| DeviceName                                             | RuleName           | LdapConnection | LdapUserName | LdapUserPassword | RuleName |
	| autogenerate iosSimulator_compact.{buildnumber}.{guid} | {iosrule_soti.net} | {soti.net}     | testuser2    | Bonjour321       | {iosrule_soti.net} |
