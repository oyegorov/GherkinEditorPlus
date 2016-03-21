Feature: API Security Permissions
	Making sure that specific permissions work
	with their corresponding APIs

Background:
	Given I am a user with name 'Administrator' and password '1'
	And Execute once per feature STARTED
	And I have enabled LDAP integration for LDAP connection '{sotiqa}'
	And I have created principals as follows:
		| PrincipalType       | Name    | DisplayName | DomainName | LdapConnectionName | MemberOf                   |
		| ActiveDirectoryUser | SSPUser | SSP1        | SOTIQA     | {sotiqa}           | MobiControl Administrators |
	And I have enrolled Ios Devices with properties as follows (execute once):
		| DeviceName                       | RuleName         | LdapConnection | LdapUserName | LdapUserPassword | DeviceId                     |
		| autogenerate IosSimulator.{guid} | {iosrule_sotiqa} | {sotiqa}       | SSPUser      | Welcome1234      | autogenerate deviceId.{guid} |
	And Execute once per feature ENDED


@CarryOverScenarioContext
Scenario Outline: LockDevice permission
	Given I am a user with name 'Administrator' and password '1'
	And I have granted principal '<PermissionTo>' the permissions as follows:
		| SecurityRole | PermissionType | PermissionName | IsAllowed   |
		| DeviceOwner  | Feature        | LoginSSP       | true        |
		| DeviceOwner  | Device         | Lock           | <IsAllowed> |
	When I am a user with name '<LoginUser>' and password '<LoginPwd>' and role '<LoginRole>'
	And  I call Public API function LockDevice using request with properties as follows:
		| DeviceIdentity.Id | DeviceIdentity.DevicePropertyIdType | PhoneNumber | Message      |
		| deviceId.{guid}   | DeviceId                            | 34523415435 | Hello World! |
	Then Public API response is '<Result>'

Examples:
	| PermissionTo  | IsAllowed | LoginUser     | LoginPwd    | LoginRole | Result              |
	| SSPUser       | true      | SSPUser       | Welcome1234 | ssp       | OK                  |
	| SSPUser       | false     | SSPUser       | Welcome1234 | ssp       | Unauthorized access |

@CarryOverScenarioContext
Scenario Outline: WipeDevice permission
	Given I am a user with name 'Administrator' and password '1'
	And I have granted principal '<PermissionTo>' the permissions as follows:
		| SecurityRole | PermissionType | PermissionName | IsAllowed   |
		| DeviceOwner  | Feature        | LoginSSP       | true        |
		| DeviceOwner  | Device         | Wipe           | <IsAllowed> |
	When I am a user with name '<LoginUser>' and password '<LoginPwd>' and role '<LoginRole>'
	And  I call Public API function WipeDevice using request with properties as follows:
		| DeviceIdentity.Id | DeviceIdentity.DevicePropertyIdType | 
		| deviceId.{guid}   | DeviceId                            | 
	Then Public API response is '<Result>'

Examples:
	| PermissionTo  | IsAllowed | LoginUser     | LoginPwd    | LoginRole | Result              |
	| SSPUser       | true      | SSPUser       | Welcome1234 | ssp       | OK                  |
	| SSPUser       | false     | SSPUser       | Welcome1234 | ssp       | Unauthorized access |

@CarryOverScenarioContext
Scenario Outline: UnenrollDevice permission
	Given I am a user with name 'Administrator' and password '1'
	And I have granted principal '<PermissionTo>' the permissions as follows:
		| SecurityRole | PermissionType | PermissionName | IsAllowed   |
		| DeviceOwner  | Feature        | LoginSSP       | true        |
		| DeviceOwner  | Device         | Unenroll       | <IsAllowed> |
	When I am a user with name '<LoginUser>' and password '<LoginPwd>' and role '<LoginRole>'
	And  I call Public API function UnenrollDevice using request with properties as follows:
		| DeviceIdentity.Id | DeviceIdentity.DevicePropertyIdType | 
		| deviceId.{guid}   | DeviceId                            | 
	Then Public API response is '<Result>'

Examples:
	| PermissionTo  | IsAllowed | LoginUser     | LoginPwd    | LoginRole | Result              |
	| SSPUser       | true      | SSPUser       | Welcome1234 | ssp       | OK                  |
	| SSPUser       | false     | SSPUser       | Welcome1234 | ssp       | Unauthorized access |

@CarryOverScenarioContext
Scenario Outline: SendMessage permission
	Given I am a user with name 'Administrator' and password '1'
	And I have granted principal '<PermissionTo>' the permissions as follows:
		| SecurityRole | PermissionType | PermissionName | IsAllowed   |
		| DeviceOwner  | Feature        | LoginSSP       | true        |
		| DeviceOwner  | Device         | SendMessage       | <IsAllowed> |
	When I am a user with name '<LoginUser>' and password '<LoginPwd>' and role '<LoginRole>'
	And  I call Public API function SendMessage using request with properties as follows:
		| DeviceIdentity.Id | DeviceIdentity.DevicePropertyIdType | Message      |
		| deviceId.{guid}   | DeviceId                            | Hello World! |
	Then Public API response is '<Result>'

Examples:
	| PermissionTo  | IsAllowed | LoginUser     | LoginPwd    | LoginRole | Result              |
	| SSPUser       | true      | SSPUser       | Welcome1234 | ssp       | OK                  |
	| SSPUser       | false     | SSPUser       | Welcome1234 | ssp       | Unauthorized access |

@CarryOverScenarioContext
Scenario Outline: LocateDevice permission
	Given I am a user with name 'Administrator' and password '1'
	And I have granted principal '<PermissionTo>' the permissions as follows:
		| SecurityRole | PermissionType | PermissionName | IsAllowed   |
		| DeviceOwner  | Feature        | LoginSSP       | true        |
		| DeviceOwner  | Device         | Locate         | <IsAllowed> |
	When I am a user with name '<LoginUser>' and password '<LoginPwd>' and role '<LoginRole>'
	And I call Public API function LocateDevice using request with properties as follows:
		| DeviceIdentity.Id | DeviceIdentity.DevicePropertyIdType |
		| deviceId.{guid}   | DeviceId                            |
	Then Public API response is '<Result>'

Examples:
	| PermissionTo  | IsAllowed | LoginUser     | LoginPwd    | LoginRole | Result              |
	| SSPUser       | true      | SSPUser       | Welcome1234 | ssp       | OK                  |
	| SSPUser       | false     | SSPUser       | Welcome1234 | ssp       | Unauthorized access |

@CarryOverScenarioContext
Scenario Outline: SetPasscode permission
	Given I am a user with name 'Administrator' and password '1'
	And I have granted principal '<PermissionTo>' the permissions as follows:
		| SecurityRole | PermissionType | PermissionName | IsAllowed   |
		| DeviceOwner  | Feature        | LoginSSP       | true        |
		| DeviceOwner  | Device         | SetPasscode    | <IsAllowed> |
	When I am a user with name '<LoginUser>' and password '<LoginPwd>' and role '<LoginRole>'
	And I call Public API function SetPasscode using request with properties as follows:
		| DeviceIdentity.Id | DeviceIdentity.DevicePropertyIdType |
		| deviceId.{guid}   | DeviceId                            |
	Then Public API response is '<Result>'

Examples:
	| PermissionTo  | IsAllowed | LoginUser     | LoginPwd    | LoginRole | Result              |
	| SSPUser       | true      | SSPUser       | Welcome1234 | ssp       | OK                  |
	| SSPUser       | false     | SSPUser       | Welcome1234 | ssp       | Unauthorized access |

@CarryOverScenarioContext
Scenario Outline: CheckInDevice permission
	Given I am a user with name 'Administrator' and password '1'
	And I have granted principal '<PermissionTo>' the permissions as follows:
		| SecurityRole | PermissionType | PermissionName | IsAllowed   |
		| DeviceOwner  | Feature        | LoginSSP       | true        |
		| DeviceOwner  | Device         | CheckIn        | <IsAllowed> |
	When I am a user with name '<LoginUser>' and password '<LoginPwd>' and role '<LoginRole>'
	And I call Public API function CheckInDevice using request with properties as follows:
		| DeviceIdentity.Id | DeviceIdentity.DevicePropertyIdType |
		| deviceId.{guid}   | DeviceId                            |
	Then Public API response is '<Result>'

Examples:
	| PermissionTo  | IsAllowed | LoginUser     | LoginPwd    | LoginRole | Result              |
	| SSPUser       | true      | SSPUser       | Welcome1234 | ssp       | OK                  |
	| SSPUser       | false     | SSPUser       | Welcome1234 | ssp       | Unauthorized access |