Feature: Update Apple Vpp Account


@CleanDatabaseForVpp
Scenario: Update a VPP account with a new description
	Given  I am a user with name 'Administrator' and password '1'
	And I call Public API function AppleVolumePurchaseProgramService\AddAccount to create a VPP account with description 'autogenerate VPPAccountName.{guid}', identifier 'autogenerate VPPAccountID.{guid}' and VPP token from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\vppsim.vpptoken' 
	And Public API response is 'OK'
	When I call Public API function AppleVolumePurchaseProgramService\UpdateAccount to modify a VPP account with description 'autogenerate VPPAccountName.{guid}', identifier 'VPPAccountID.{guid}'
	Then Public API response is 'OK'
	And I call Public API function AppleVolumePurchaseProgramService\GetAccountsSummary to retrieve all VPP accounts
	And Public API response is 'OK'
	And Last call to AppleVolumePurchaseProgramService\GetAccountsSummary has resulted in a VPP account with description 'VPPAccountName.{guid}' and identifier 'VPPAccountID.{guid}'

@CleanDatabaseForVpp
Scenario: Update a VPP account with an invalid token
	Given  I am a user with name 'Administrator' and password '1'
	And I call Public API function AppleVolumePurchaseProgramService\AddAccount to create a VPP account with description 'autogenerate VPPAccountName.{guid}', identifier 'autogenerate VPPAccountID.{guid}' and VPP token from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\vppsim.vpptoken' 
	And Public API response is 'OK'
	When I call Public API function AppleVolumePurchaseProgramService\UpdateAccount to modify a VPP account with VPP token from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\iosvpp@soti.net.vpptoken', description 'VPPAccountName.{guid}', identifier 'VPPAccountID.{guid}'
	Then Last call to AppleVolumePurchaseProgramService\UpdateAccount has resulted in a failure with error code '1328'
	And I call Public API function AppleVolumePurchaseProgramService\GetAccountsSummary to retrieve all VPP accounts
	And Public API response is 'OK'
	And Last call to AppleVolumePurchaseProgramService\GetAccountsSummary has resulted in a VPP account with description 'VPPAccountName.{guid}' and identifier 'VPPAccountID.{guid}'
