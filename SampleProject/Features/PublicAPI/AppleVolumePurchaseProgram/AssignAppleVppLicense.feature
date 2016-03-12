Feature: Assign Apple Vpp License


Background:
Given  I am a user with name 'Administrator' and password '1'
And I have enabled LDAP integration for LDAP connection '{sotiqa}'
And I have created principals as follows:
	| PrincipalType       | Name    | DisplayName | DomainName | LdapConnectionName | MemberOf                   |
	| ActiveDirectoryUser | Jon     | Jon         | SOTIQA     | {sotiqa}           | MobiControl Administrators |
And I enrolled Ios Device with properties as follows(execute once):
	| DeviceName                             | RuleName         | LdapConnection | LdapUserName | LdapUserPassword | DeviceId                     | IsITunesStoreAccountActive | ITunesStoreAccountHash     |
	| autogenerate IosSimulatorDevice.{guid} | {iosrule_sotiqa} | {sotiqa}       | Jon          | Welcome1234      | autogenerate deviceId.{guid} | True                       | autogenerate iTunes.{guid} |
And Using device simulator with ID 'deviceId.{guid}' as current
And I have reset VppSimulator database
When I call Public API function AppleVolumePurchaseProgramService\AddAccount to create a VPP account with description 'autogenerate VPPAccountName.{guid}', identifier 'autogenerate VPPAccountID.{guid}' and VPP token from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\vppsim.vpptoken' 
Then Public API response is 'OK'

@CleanDatabaseForVpp
@CarryOverScenarioContext
Scenario Outline: Assign then revoke an Apple VPP licensed app in an App Catalog rule 
	Given  There exist Apple VPP products with available licenses in the Apple VPP Account with identifier 'VPPAccountID.{guid}' with the following criteria:
			| ProductIdentifier     | IsDeviceAssignable |
			| UserAssignableProduct | true               |
	And    The current iOS device has the following Apple VPP product statuses:
			| ProductIdentifier     | IsInstalled |
			| UserAssignableProduct | false       |
	And    I have created an App Catalog rule with name 'autogenerate AppCatalogRuleName.{guid}' with the following Apple VPP products targeting the current device:
			| ProductIdentifier     | AssignmentType         |
			| UserAssignableProduct | <VppAppAssignmentType> |
	When   I request the current iOS device to check in to install the '<VppAppAssignmentType>' applications
	And    I call Public API function AppleVolumePurchaseProgramService\RefreshAccount to refresh a VPP account with identifier 'VPPAccountID.{guid}'
	And    The number of assigned licenses for the Apple VPP products has changed as follows:
			| ProductIdentifier       | ChangeInNumberAssignedLicenses |
			| UserAssignableProduct   | 1                              |
	And    The current iOS device has the following Apple VPP product statuses:
			| ProductIdentifier     | IsInstalled |
			| UserAssignableProduct | true        |
	And    I call Public API function AppleVolumePurchaseProgramService\Reconcile to revoke unused licenses and retire unused users for all VPP accounts
	And    I call Public API function AppleVolumePurchaseProgramService\RefreshAccount to refresh a VPP account with identifier 'VPPAccountID.{guid}'
	And    The number of assigned licenses for the Apple VPP products has changed as follows:
			| ProductIdentifier       | ChangeInNumberAssignedLicenses |
			| UserAssignableProduct   | 0                              |
    And    I delete the App Catalog rule named 'AppCatalogRuleName.{guid}' and targeting the current device
	And    I call Public API function AppleVolumePurchaseProgramService\Reconcile to revoke unused licenses and retire unused users for all VPP accounts
	And    I call Public API function AppleVolumePurchaseProgramService\RefreshAccount to refresh a VPP account with identifier 'VPPAccountID.{guid}'
	And    The number of assigned licenses for the Apple VPP products has changed as follows:
			| ProductIdentifier       | ChangeInNumberAssignedLicenses |
			| UserAssignableProduct   | -1                             |
	#And    The current iOS device fully checks in
	#And    The current iOS device has the following Apple VPP product statuses:
	#		| ProductIdentifier     | IsInstalled |
	#		| UserAssignableProduct | false       |

Examples: 
| VppAppAssignmentType |
| AppleIdBased         |
| DeviceBased          |



@CleanDatabaseForVpp
@CarryOverScenarioContext
Scenario: Assign then revoke Apple VPP user-based and device-based licensed apps in an App Catalog rule 
	Given  There exist Apple VPP products with available licenses in the Apple VPP Account with identifier 'VPPAccountID.{guid}' with the following criteria:
			| ProductIdentifier        | IsDeviceAssignable |
			| UserAssignableProduct    | true               |
			| DeviceAssignableProduct  | true               |
	And    The current iOS device has the following Apple VPP product statuses:
			| ProductIdentifier       | IsInstalled |
			| UserAssignableProduct   | false       |
			| DeviceAssignableProduct | false       |
	And    I have created an App Catalog rule with name 'autogenerate AppCatalogRuleName.{guid}' with the following Apple VPP products targeting the current device:
			| ProductIdentifier       | AssignmentType |
			| UserAssignableProduct   | AppleIdBased   |
			| DeviceAssignableProduct | DeviceBased    |
	When   The current iOS device fully checks in
	Then   I call Public API function AppleVolumePurchaseProgramService\RefreshAccount to refresh a VPP account with identifier 'VPPAccountID.{guid}'
	And    The number of assigned licenses for the Apple VPP products has changed as follows:
			| ProductIdentifier       | ChangeInNumberAssignedLicenses |
			| UserAssignableProduct   | 0                              |
			| DeviceAssignableProduct | 1                              |
	And    The current iOS device has the following Apple VPP product statuses:
			| ProductIdentifier       | IsInstalled |
			| UserAssignableProduct   | false       |
			| DeviceAssignableProduct | true        |
	Then   I associate all VPP users in the VPP simulator and update the iTunes ID hash for the following devices:
			| DeviceId        |
			| deviceId.{guid} |
	And    The current iOS device fully checks in
	And    I call Public API function AppleVolumePurchaseProgramService\RefreshAccount to refresh a VPP account with identifier 'VPPAccountID.{guid}'
	And    The number of assigned licenses for the Apple VPP products has changed as follows:
			| ProductIdentifier       | ChangeInNumberAssignedLicenses |
			| UserAssignableProduct   | 1                              |
			| DeviceAssignableProduct | 0                              |
	And    The current iOS device has the following Apple VPP product statuses:
			| ProductIdentifier       | IsInstalled |
			| UserAssignableProduct   | true        |
			| DeviceAssignableProduct | true        |
	And    I call Public API function AppleVolumePurchaseProgramService\Reconcile to revoke unused licenses and retire unused users for all VPP accounts
	And    I call Public API function AppleVolumePurchaseProgramService\RefreshAccount to refresh a VPP account with identifier 'VPPAccountID.{guid}'
	And    The number of assigned licenses for the Apple VPP products has changed as follows:
			| ProductIdentifier       | ChangeInNumberAssignedLicenses |
	 		| UserAssignableProduct   | 0                              |
			| DeviceAssignableProduct | 0                              |
	And    I delete the App Catalog rule named 'AppCatalogRuleName.{guid}' and targeting the current device
	And    I call Public API function AppleVolumePurchaseProgramService\Reconcile to revoke unused licenses and retire unused users for all VPP accounts
	And    I call Public API function AppleVolumePurchaseProgramService\RefreshAccount to refresh a VPP account with identifier 'VPPAccountID.{guid}'
	And    The number of assigned licenses for the Apple VPP products has changed as follows:
			| ProductIdentifier       | ChangeInNumberAssignedLicenses |
			| UserAssignableProduct   | -1                             |
			| DeviceAssignableProduct | -1                             |
	#And    The current iOS device fully checks in
	#And    The current iOS device has the following Apple VPP product statuses:
	#		| ProductIdentifier       | IsInstalled |
	#		| UserAssignableProduct   | false       |
	#		| DeviceAssignableProduct | false       |

@CleanDatabaseForVpp
@CarryOverScenarioContext
Scenario Outline: Convert an app in an App Catalog rule from one Apple VPP assignment type licensed app to another
	Given  There exist Apple VPP products with available licenses in the Apple VPP Account with identifier 'VPPAccountID.{guid}' with the following criteria:
			| ProductIdentifier              | IsDeviceAssignable |
			| UserAndDeviceAssignableProduct | true               |
	And    The current iOS device has the following Apple VPP product statuses:
			| ProductIdentifier              | IsInstalled |
			| UserAndDeviceAssignableProduct | false       |
	And    I have created an App Catalog rule with name 'autogenerate AppCatalogRuleName.{guid}' with the following Apple VPP products targeting the current device:
			| ProductIdentifier              | AssignmentType       |
			| UserAndDeviceAssignableProduct | <FromAssignmentType> |
	And    I request the current iOS device to check in to install the '<FromAssignmentType>' applications
	And    I call Public API function AppleVolumePurchaseProgramService\RefreshAccount to refresh a VPP account with identifier 'VPPAccountID.{guid}'
	And    The number of assigned licenses for the Apple VPP products has changed as follows:
			| ProductIdentifier                | ChangeInNumberAssignedLicenses |
			| UserAndDeviceAssignableProduct   | 1                              |
    And    The current iOS device has the following Apple VPP product statuses:
			| ProductIdentifier              | IsInstalled |
			| UserAndDeviceAssignableProduct | true        |
	When   I have modified the App Catalog rule named 'AppCatalogRuleName.{guid}' and targeting the current iOS device with the following Apple VPP products:
			| ProductIdentifier              | AssignmentType     |
			| UserAndDeviceAssignableProduct | <ToAssignmentType> |
	And    I request the current iOS device to check in to install the '<ToAssignmentType>' applications
	And    I call Public API function AppleVolumePurchaseProgramService\RefreshAccount to refresh a VPP account with identifier 'VPPAccountID.{guid}'
	Then    The number of assigned licenses for the Apple VPP products has changed as follows:
			| ProductIdentifier                | ChangeInNumberAssignedLicenses |
			| UserAndDeviceAssignableProduct   | 1                              |
	And    The current iOS device has the following Apple VPP product statuses:
			| ProductIdentifier              | IsInstalled |
			| UserAndDeviceAssignableProduct | true        |
	When   I call Public API function AppleVolumePurchaseProgramService\Reconcile to revoke unused licenses and retire unused users for all VPP accounts
	And    I call Public API function AppleVolumePurchaseProgramService\RefreshAccount to refresh a VPP account with identifier 'VPPAccountID.{guid}'
	Then   The number of assigned licenses for the Apple VPP products has changed as follows:
			| ProductIdentifier                | ChangeInNumberAssignedLicenses |
			| UserAndDeviceAssignableProduct   | -1                             |

Examples: 
| FromAssignmentType | ToAssignmentType |
| AppleIdBased       | DeviceBased      |
| DeviceBased        | AppleIdBased     |

@CleanDatabaseForVpp
@CarryOverScenarioContext
Scenario Outline: Convert an app in an App Catalog rule from a purchased app to an Apple VPP one
	Given  There exist Apple VPP products with available licenses in the Apple VPP Account with identifier 'VPPAccountID.{guid}' with the following criteria:
			| ProductIdentifier     | IsDeviceAssignable |
			| UserAssignableProduct | true               |
	And    The current iOS device has the following Apple VPP product statuses:
			| ProductIdentifier     | IsInstalled |
			| UserAssignableProduct | false       |
	And    I have created an App Catalog rule with name 'autogenerate AppCatalogRuleName.{guid}' with the following Apple VPP products targeting the current device:
			| ProductIdentifier     | AssignmentType |
			| UserAssignableProduct | {null}         |
	And    I request the current iOS device to check in to install the 'Purchased' applications
	And    I call Public API function AppleVolumePurchaseProgramService\RefreshAccount to refresh a VPP account with identifier 'VPPAccountID.{guid}'
	And    The number of assigned licenses for the Apple VPP products has changed as follows:
			| ProductIdentifier       | ChangeInNumberAssignedLicenses |
			| UserAssignableProduct   | 0                              |
    And    The current iOS device has the following Apple VPP product statuses:
			| ProductIdentifier     | IsInstalled |
			| UserAssignableProduct | true        |
	When   I have modified the App Catalog rule named 'AppCatalogRuleName.{guid}' and targeting the current iOS device with the following Apple VPP products:
			| ProductIdentifier     | AssignmentType         |
			| UserAssignableProduct | <VppAppAssignmentType> |
	And    I request the current iOS device to check in to install the '<VppAppAssignmentType>' applications
	And    I call Public API function AppleVolumePurchaseProgramService\RefreshAccount to refresh a VPP account with identifier 'VPPAccountID.{guid}'
	Then    The number of assigned licenses for the Apple VPP products has changed as follows:
			| ProductIdentifier       | ChangeInNumberAssignedLicenses |
			| UserAssignableProduct   | 1                              |
	And    The current iOS device has the following Apple VPP product statuses:
			| ProductIdentifier     | IsInstalled |
			| UserAssignableProduct | true        |

Examples: 
| VppAppAssignmentType |
| AppleIdBased         |
| DeviceBased          |

