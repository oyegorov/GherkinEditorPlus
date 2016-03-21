Feature: Add Apple VPP Account

@CleanDatabaseForVpp
Scenario: Upload a VPP token using Apple VPP services
	Given  I am a user with name 'Administrator' and password '1'
	And MobiControl is configured to use the Apple VPP services
	When I call Public API function AppleVolumePurchaseProgramService\VerifyAccount to upload a VPP token from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\iosvpp@soti.net.vpptoken' using identifier '{null}'
	Then Public API response is 'OK'
	And Last call to AppleVolumePurchaseProgramService\VerifyAccount has resulted in the successful upload of the VPP token

@CleanDatabaseForVpp
Scenario: Upload a VPP token using Apple VPP simulator
	Given  I am a user with name 'Administrator' and password '1'
	When I call Public API function AppleVolumePurchaseProgramService\VerifyAccount to upload a VPP token from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\vppsim.vpptoken' using identifier '{null}'
	Then Public API response is 'OK'
	And Last call to AppleVolumePurchaseProgramService\VerifyAccount has resulted in the successful upload of the VPP token

@CleanDatabaseForVpp
Scenario Outline: Upload an invalid VPP token
	Given  I am a user with name 'Administrator' and password '1'
	When I call Public API function AppleVolumePurchaseProgramService\VerifyAccount to upload a VPP token from '<VppTokenLocation>' using identifier '{null}'
	Then Last call to AppleVolumePurchaseProgramService\VerifyAccount has resulted in a failure with error code '<Result>'

Examples: 
| VppTokenLocation																							  | Result |
| file:\\\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\iosvpp@soti.net.vpptoken  | 1328   |
| file:\\\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\invalid.vpptoken          | 1327   |

@CleanDatabaseForVpp
Scenario: Add a VPP account
	Given  I am a user with name 'Administrator' and password '1'
	When I call Public API function AppleVolumePurchaseProgramService\AddAccount to create a VPP account with description 'autogenerate VPPAccountName.{guid}', identifier 'autogenerate VPPAccountID.{guid}' and VPP token from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\vppsim.vpptoken' 
	Then Public API response is 'OK'
	And Last call to AppleVolumePurchaseProgramService\AddAccount has resulted in a VPP account with description 'VPPAccountName.{guid}' and identifier 'VPPAccountID.{guid}'
	And I call Public API function AppleVolumePurchaseProgramService\GetAccountsSummary to retrieve all VPP accounts
	And Public API response is 'OK'
	And Last call to AppleVolumePurchaseProgramService\GetAccountsSummary has resulted in a VPP account with description 'VPPAccountName.{guid}' and identifier 'VPPAccountID.{guid}'

@CleanDatabaseForVpp
Scenario: Upload and add a VPP account
	Given  I am a user with name 'Administrator' and password '1'
	And I call Public API function AppleVolumePurchaseProgramService\VerifyAccount to upload a VPP token from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\vppsim.vpptoken' using identifier 'autogenerate VPPAccountID.{guid}'
	And Public API response is 'OK'
	And Last call to AppleVolumePurchaseProgramService\VerifyAccount has resulted in the successful upload of the VPP token with identifier 'VPPAccountID.{guid}'
	When I call Public API function AppleVolumePurchaseProgramService\AddAccount to create a VPP account with description 'autogenerate VPPAccountName.{guid}', identifier 'VPPAccountID.{guid}' and VPP token from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\vppsim.vpptoken' 
	Then Public API response is 'OK'
	And Last call to AppleVolumePurchaseProgramService\AddAccount has resulted in a VPP account with description 'VPPAccountName.{guid}' and identifier 'VPPAccountID.{guid}'
	And I call Public API function AppleVolumePurchaseProgramService\GetAccountsSummary to retrieve all VPP accounts
	And Public API response is 'OK'
	And Last call to AppleVolumePurchaseProgramService\GetAccountsSummary has resulted in a VPP account with description 'VPPAccountName.{guid}' and identifier 'VPPAccountID.{guid}'

@CleanDatabaseForVpp
Scenario: Add a VPP account with a duplicate VPP token
	Given  I am a user with name 'Administrator' and password '1'
	When I call Public API function AppleVolumePurchaseProgramService\AddAccount to create a VPP account with description 'autogenerate VPPAccountName1.{guid}', identifier 'autogenerate VPPAccountID.{guid}' and VPP token from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\vppsim.vpptoken' 
	And Public API response is 'OK'
	And I call Public API function AppleVolumePurchaseProgramService\AddAccount to create a VPP account with description 'autogenerate VPPAccountName2.{guid}', identifier '{null}' and VPP token from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\vppsim.vpptoken'
	Then Last call to AppleVolumePurchaseProgramService\AddAccount has resulted in an error code '1316'
	And I call Public API function AppleVolumePurchaseProgramService\GetAccountsSummary to retrieve all VPP accounts
	And Public API response is 'OK'
	And Last call to AppleVolumePurchaseProgramService\GetAccountsSummary has resulted in a VPP account with description 'VPPAccountName1.{guid}' and identifier 'VPPAccountID.{guid}'

@CleanDatabaseForVpp
Scenario: Add a VPP account with a duplicate description
	Given  I am a user with name 'Administrator' and password '1'
	When I call Public API function AppleVolumePurchaseProgramService\AddAccount to create a VPP account with description 'autogenerate VPPAccountName.{guid}', identifier 'autogenerate VPPAccountID.{guid}' and VPP token from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\vppsim.vpptoken' 
	And Public API response is 'OK'
	And I call Public API function AppleVolumePurchaseProgramService\AddAccount to create a VPP account with description 'VPPAccountName.{guid}', identifier '{null}' and VPP token from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\iosvpp@soti.net.vpptoken'
	Then Last call to AppleVolumePurchaseProgramService\AddAccount has resulted in an error code '1308'
	And I call Public API function AppleVolumePurchaseProgramService\GetAccountsSummary to retrieve all VPP accounts
	And Public API response is 'OK'
	And Last call to AppleVolumePurchaseProgramService\GetAccountsSummary has resulted in a VPP account with description 'VPPAccountName.{guid}' and identifier 'VPPAccountID.{guid}'