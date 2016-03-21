Feature: Assign Apple Vpp License to Multiple Devices

Background:
Given  I am a user with name 'Administrator' and password '1'
And I have enabled LDAP integration for LDAP connection '{sotiqa}'
And I have created principals as follows:
	| PrincipalType       | Name    | DisplayName | DomainName | LdapConnectionName | MemberOf                   |
	| ActiveDirectoryUser | Jon     | Jon         | SOTIQA     | {sotiqa}           | MobiControl Administrators |
And I have enrolled Ios Devices with properties as follows:
	| DeviceName                             | RuleName         | LdapConnection | LdapUserName | LdapUserPassword | DeviceId                     | IsITunesStoreAccountActive | ITunesStoreAccountHash     |
	| autogenerate IosSimulatorDevice.{guid} | {iosrule_sotiqa} | {sotiqa}       | Jon          | Welcome1234      | autogenerate deviceId1.{guid} | True                       | autogenerate iTunes.{guid} |
	| autogenerate IosSimulatorDevice.{guid} | {iosrule_sotiqa} | {sotiqa}       | Jon          | Welcome1234      | autogenerate deviceId2.{guid} | True                       | iTunes.{guid} |
And I have reset VppSimulator database
When I call Public API function AppleVolumePurchaseProgramService\AddAccount to create a VPP account with description 'autogenerate VPPAccountName.{guid}', identifier 'autogenerate VPPAccountID.{guid}' and VPP token from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\vppsim.vpptoken' 
Then Public API response is 'OK'
	
@CleanDatabaseForVpp
@CarryOverScenarioContext
Scenario Outline: Assign Apple VPP user-based and device-based licensed apps in an App Catalog rule to multiple devices and then revoke by reconciling licenses (TC 75039, TC 75580)
	Given  There exist Apple VPP products with available licenses in the Apple VPP Account with identifier 'VPPAccountID.{guid}' with the following criteria:
			| ProductIdentifier        | IsDeviceAssignable |
			| UserAssignableProduct    | true               |
			| DeviceAssignableProduct  | true               |
	And    Using device simulator with ID 'deviceId1.{guid}' as current
	And    The current iOS device has the following Apple VPP product statuses:
			| ProductIdentifier       | IsInstalled |
			| UserAssignableProduct   | false       |
			| DeviceAssignableProduct | false       |
	And    I have created an App Catalog rule with name 'autogenerate AppCatalogRuleName1.{guid}' with the following Apple VPP products targeting the current device:
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
	And    A device level log has been created to indicate a 'DeviceBased' VPP license for the product 'DeviceAssignableProduct' was assigned to the device 'deviceId1.{guid}' from VPP account 'VPPAccountName.{guid}'
	And    A 'Deployment' server level log has been created to indicate a 'DeviceBased' VPP license for the product 'DeviceAssignableProduct' was assigned to the device 'deviceId1.{guid}' from VPP account 'VPPAccountName.{guid}'
	And    A device level log has been created to indicate a VPP program invitation for VPP account 'VPPAccountName.{guid}' was sent to the device 'deviceId1.{guid}'
	Then   I associate all VPP users in the VPP simulator and update the iTunes ID hash for the following devices:
			| DeviceId         |
			| deviceId1.{guid} |
			| deviceId2.{guid} |
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
	And    A device level log has been created to indicate a VPP program invitation for VPP account 'VPPAccountName.{guid}' was accepted by the device 'deviceId1.{guid}'
	And    A device level log has been created to indicate a 'AppleIdBased' VPP license for the product 'UserAssignableProduct' was assigned to the device 'deviceId1.{guid}' from VPP account 'VPPAccountName.{guid}'
	And    A 'Deployment' server level log has been created to indicate a 'AppleIdBased' VPP license for the product 'UserAssignableProduct' was assigned to the device 'deviceId1.{guid}' from VPP account 'VPPAccountName.{guid}'
	Given  Using device simulator with ID 'deviceId2.{guid}' as current
	And    The current iOS device has the following Apple VPP product statuses:
			| ProductIdentifier       | IsInstalled |
			| UserAssignableProduct   | false       |
			| DeviceAssignableProduct | false       |
	And    I have created an App Catalog rule with name 'autogenerate AppCatalogRuleName2.{guid}' with the following Apple VPP products targeting the current device:
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
			| UserAssignableProduct   | true        |
			| DeviceAssignableProduct | true        |
	And    A device level log has been created to indicate a 'DeviceBased' VPP license for the product 'DeviceAssignableProduct' was assigned to the device 'deviceId2.{guid}' from VPP account 'VPPAccountName.{guid}'
	And    A 'Deployment' server level log has been created to indicate a 'DeviceBased' VPP license for the product 'DeviceAssignableProduct' was assigned to the device 'deviceId2.{guid}' from VPP account 'VPPAccountName.{guid}'
	And    A device level log has been created to indicate a AppleIdBased VPP license for the product 'UserAssignableProduct' was already assigned to the device 'deviceId2.{guid}' from VPP account 'VPPAccountName.{guid}'
	And    I call Public API function AppleVolumePurchaseProgramService\Reconcile to revoke unused licenses and retire unused users for all VPP accounts
	And    I call Public API function AppleVolumePurchaseProgramService\RefreshAccount to refresh a VPP account with identifier 'VPPAccountID.{guid}'
	And    The number of assigned licenses for the Apple VPP products has changed as follows:
			| ProductIdentifier       | ChangeInNumberAssignedLicenses |
	 		| UserAssignableProduct   | 0                              |
			| DeviceAssignableProduct | 0                              |
	When   I execute the step '<FirstStep>'
	And    I call Public API function AppleVolumePurchaseProgramService\Reconcile to revoke unused licenses and retire unused users for all VPP accounts
	And    I call Public API function AppleVolumePurchaseProgramService\RefreshAccount to refresh a VPP account with identifier 'VPPAccountID.{guid}'
	Then   The number of assigned licenses for the Apple VPP products has changed as follows:
			| ProductIdentifier       | ChangeInNumberAssignedLicenses |
			| UserAssignableProduct   | 0                              |
			| DeviceAssignableProduct | -1                             |
	And    A device level log has been created to indicate a 'DeviceBased' VPP license for the product 'DeviceAssignableProduct' was revoked from the device 'deviceId1.{guid}' from VPP account 'VPPAccountName.{guid}'
	And    A 'ManagementService' server level log has been created to indicate a 'DeviceBased' VPP license for the product 'DeviceAssignableProduct' was revoked from the device 'deviceId1.{guid}' from VPP account 'VPPAccountName.{guid}'
	When   I execute the step '<SecondStep>'
	And    I call Public API function AppleVolumePurchaseProgramService\Reconcile to revoke unused licenses and retire unused users for all VPP accounts
	And    I call Public API function AppleVolumePurchaseProgramService\RefreshAccount to refresh a VPP account with identifier 'VPPAccountID.{guid}'
	Then   The number of assigned licenses for the Apple VPP products has changed as follows:
			| ProductIdentifier       | ChangeInNumberAssignedLicenses |
			| UserAssignableProduct   | -1                             |
			| DeviceAssignableProduct | -1                             |
	And    A device level log has been created to indicate a 'DeviceBased' VPP license for the product 'DeviceAssignableProduct' was revoked from the device 'deviceId2.{guid}' from VPP account 'VPPAccountName.{guid}'
	And    A 'ManagementService' server level log has been created to indicate a 'DeviceBased' VPP license for the product 'DeviceAssignableProduct' was revoked from the device 'deviceId2.{guid}' from VPP account 'VPPAccountName.{guid}'
	And    A device level log has been created to indicate a 'AppleIdBased' VPP license for the product 'UserAssignableProduct' was revoked from the device 'deviceId2.{guid}' from VPP account 'VPPAccountName.{guid}'
	And    A device level log has been created to indicate a 'AppleIdBased' VPP license for the product 'UserAssignableProduct' was revoked from the device 'deviceId1.{guid}' from VPP account 'VPPAccountName.{guid}'
	And    A 'ManagementService' server level log has been created to indicate a 'AppleIdBased' VPP license for the product 'UserAssignableProduct' was revoked from the device 'deviceId2.{guid}' from VPP account 'VPPAccountName.{guid}'

Examples:
| FirstStep                                                                                                            | SecondStep                                                                                                           |
| I unenroll the iOS device with ID 'deviceId1.{guid}'                                                                 | I unenroll the iOS device with ID 'deviceId2.{guid}'                                                                 |
| I delete the App Catalog rule named 'AppCatalogRuleName1.{guid}' and targeting the device with ID 'deviceId1.{guid}' | I delete the App Catalog rule named 'AppCatalogRuleName2.{guid}' and targeting the device with ID 'deviceId2.{guid}' |
