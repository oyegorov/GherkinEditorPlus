Feature: Refresh Apple Vpp Account


@CleanDatabaseForVpp
Scenario: Refresh an Apple Vpp token
	Given  I am a user with name 'Administrator' and password '1'
	And I call Public API function AppleVolumePurchaseProgramService\AddAccount to create a VPP account with description 'autogenerate VPPAccountName.{guid}', identifier 'autogenerate VPPAccountID.{guid}' and VPP token from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\vppsim.vpptoken' 
	And Public API response is 'OK'
	When I call Public API function AppleVolumePurchaseProgramService\RefreshAccount to refresh a VPP account with identifier 'VPPAccountID.{guid}'
	Then Public API response is 'OK'
