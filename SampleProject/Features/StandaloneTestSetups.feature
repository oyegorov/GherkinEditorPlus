@ignore
Feature: A set of quick setups for different testing purposes

Scenario Outline: Enroll a bunch of iOS devices for SSPUser, grant SSPUser a LoginSSP permission
	Given I am a user with name 'Administrator' and password '1'
	And I have added device groups as follows:
		| GroupPath                       |
		| autogenerate <TargetDeviceGroupPath> |
	And I have enabled LDAP integration for LDAP connection '{sotiqa}'
	And I have created principals as follows:
		| PrincipalType       | Name    | DisplayName | DomainName | LdapConnectionName | MemberOf                   |
		| ActiveDirectoryUser | SSPUser | SSP1        | SOTIQA     | {sotiqa}           | MobiControl Administrators |
	And I have granted principal 'SSPUser' the permissions as follows:
		| SecurityRole | PermissionType | PermissionName   | IsAllowed   |
		| DeviceOwner  | Feature        | LoginSSP         | true        |
	And I have enrolled Ios Devices with properties as follows (execute once):
		| DeviceName                         | LdapConnection | LdapUserName | LdapUserPassword | TargetGroup             | DeviceId                       |
		| autogenerate IosSimulator01.{guid} | {sotiqa}       | SSPUser      | Welcome1234      | <TargetDeviceGroupPath> | autogenerate deviceId01.{guid} |
		| autogenerate IosSimulator02.{guid} | {sotiqa}       | SSPUser      | Welcome1234      | <TargetDeviceGroupPath> | autogenerate deviceId02.{guid} |
		| autogenerate IosSimulator03.{guid} | {sotiqa}       | SSPUser      | Welcome1234      | <TargetDeviceGroupPath> | autogenerate deviceId03.{guid} |
		| autogenerate IosSimulator04.{guid} | {sotiqa}       | SSPUser      | Welcome1234      | <TargetDeviceGroupPath> | autogenerate deviceId04.{guid} |
		| autogenerate IosSimulator05.{guid} | {sotiqa}       | SSPUser      | Welcome1234      | <TargetDeviceGroupPath> | autogenerate deviceId05.{guid} |
	
Examples: 
	| TargetDeviceGroupPath |
	| \\MyTestGroup.{time}  |
