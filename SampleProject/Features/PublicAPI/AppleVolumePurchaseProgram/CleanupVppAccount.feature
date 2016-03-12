Feature: Cleanup VPP account

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
Scenario Outline: Cleanup managed Apple VPP licenses in VPP account
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
	And    I call Public API function AppleVolumePurchaseProgramService\CleanupAccount to reclaim all not used licenses for a VPP account with identifier 'VPPAccountID.{guid}'
	And    I call Public API function AppleVolumePurchaseProgramService\RefreshAccount to refresh a VPP account with identifier 'VPPAccountID.{guid}'
	And    The number of assigned licenses for the Apple VPP products has changed as follows:
			| ProductIdentifier       | ChangeInNumberAssignedLicenses |
			| UserAssignableProduct   | 0                              |
    And    I delete the App Catalog rule named 'AppCatalogRuleName.{guid}' and targeting the current device
	And    I call Public API function AppleVolumePurchaseProgramService\CleanupAccount to reclaim all not used licenses for a VPP account with identifier 'VPPAccountID.{guid}'
	And    I call Public API function AppleVolumePurchaseProgramService\RefreshAccount to refresh a VPP account with identifier 'VPPAccountID.{guid}'
	And    The number of assigned licenses for the Apple VPP products has changed as follows:
			| ProductIdentifier       | ChangeInNumberAssignedLicenses |
			| UserAssignableProduct   | -1                             |

Examples: 
| VppAppAssignmentType |
| AppleIdBased         |
| DeviceBased          |

Examples: 
| VppAppAssignmentType |
| AppleIdBased         |
| DeviceBased          |

@CleanDatabaseForVpp
@CarryOverScenarioContext
Scenario: Cleanup unmanaged Apple VPP user-based licenses in VPP account
	Given  There exist Apple VPP products with available licenses in the Apple VPP Account with identifier 'VPPAccountID.{guid}' with the following criteria:
			| ProductIdentifier     | IsDeviceAssignable |
			| UserAssignableProduct | true               |
	And    The current iOS device has the following Apple VPP product statuses:
			| ProductIdentifier     | IsInstalled |
			| UserAssignableProduct | false       |
	And    I have created an App Catalog rule with name 'autogenerate AppCatalogRuleName.{guid}' with the following Apple VPP products targeting the current device:
			| ProductIdentifier     | AssignmentType         |
			| UserAssignableProduct | AppleIdBased |
	When   I request the current iOS device to check in to install the 'AppleIdBased' applications
	And    I call Public API function AppleVolumePurchaseProgramService\RefreshAccount to refresh a VPP account with identifier 'VPPAccountID.{guid}'
	And    The number of assigned licenses for the Apple VPP products has changed as follows:
			| ProductIdentifier       | ChangeInNumberAssignedLicenses |
			| UserAssignableProduct   | 1                              |	
	And    I call Public API function AppleVolumePurchaseProgramService\CleanupAccount to reclaim all not used licenses for a VPP account with identifier 'VPPAccountID.{guid}'
	And    I call Public API function AppleVolumePurchaseProgramService\RefreshAccount to refresh a VPP account with identifier 'VPPAccountID.{guid}'
	And    The number of assigned licenses for the Apple VPP products has changed as follows:
			| ProductIdentifier       | ChangeInNumberAssignedLicenses |
			| UserAssignableProduct   | 0                              |
    And    I delete the App Catalog rule named 'AppCatalogRuleName.{guid}' and targeting the current device
	And    I hacked Database for change vppUser from managed to unmanaged
	And    I call Public API function AppleVolumePurchaseProgramService\CleanupAccount to reclaim all not used licenses for a VPP account with identifier 'VPPAccountID.{guid}'
	And    I call Public API function AppleVolumePurchaseProgramService\RefreshAccount to refresh a VPP account with identifier 'VPPAccountID.{guid}'
	And    The number of assigned licenses for the Apple VPP products has changed as follows:
			| ProductIdentifier       | ChangeInNumberAssignedLicenses |
			| UserAssignableProduct   | -1                             |
