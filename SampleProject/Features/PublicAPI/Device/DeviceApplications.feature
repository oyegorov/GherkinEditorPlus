Feature: DeviceApplications
In order to verify installed applications as an administrator 
I want to enroll and checkin an ios device and compare with list of installed applications 

@ignore
Scenario: Verify installed applications
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
	| DeviceName                                             | RuleName           | LdapConnection | LdapUserName | LdapUserPassword | OSVersion |
	| autogenerate iosSimulator_compact.{buildnumber}.{guid} | {iosrule_soti.net} | {soti.net}     | testuser2    | Bonjour321       | 8.0       |
When I make a call to public API to get installed applications for the device
Then The list of installed apps returned should match the one on server
