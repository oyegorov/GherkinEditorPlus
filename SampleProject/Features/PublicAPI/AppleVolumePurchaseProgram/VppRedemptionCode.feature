Feature: VPP Redemption Code

Background:
	Given  I am a user with name 'Administrator' and password '1'
	And    I have created an App Catalog rule with name 'autogenerate AppCatalogRuleName.{guid}' and using VPP redemption codes from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\RedemptionCodes\\VppRedemptionCodes_original.xls' for the following product:
			| ProductName | ProductIdentifier | BundleIdentifier      | Price |
			| Tetris      | 479943969         | com.ea.tetris2011.inc | 0.99  |
	And    I modify the database to set the first 3 redemption codes to Redeemed and the next 3 redemption codes to Pending Redemption

@CleanDatabaseForVppRedemptionCodes
Scenario Outline: Upload a redemption code spreadsheet with the same or more redeemed codes or more available codes (TC 47678)
	Given I upload VPP redemption codes from '<RedemptionCodeSpreadsheetLocation>' for the application with name 'Tetris' and bundle identifier 'com.ea.tetris2011.inc' in App Catalog rule named 'AppCatalogRuleName.{guid}'
	Then  The last upload of VPP redemption codes succeeded
	
Examples: 
| RedemptionCodeSpreadsheetLocation                                                                                           |
| file:\\\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\RedemptionCodes\\VppRedemptionCodes_3.xls |
| file:\\\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\RedemptionCodes\\VppRedemptionCodes_4.xls |
| file:\\\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\RedemptionCodes\\VppRedemptionCodes_6.xls |

@CleanDatabaseForVppRedemptionCodes
Scenario Outline: Upload a redemption code spreadsheet with fewer or different redeemed codes (TC 47678)
	Given I upload VPP redemption codes from '<RedemptionCodeSpreadsheetLocation>' for the application with name 'Tetris' and bundle identifier 'com.ea.tetris2011.inc' in App Catalog rule named 'AppCatalogRuleName.{guid}'
	Then  The last upload of VPP redemption codes failed because the spreadsheet is out of date
	When  I upload VPP redemption codes from '<RedemptionCodeSpreadsheetLocation>' for the application with name 'Tetris' and bundle identifier 'com.ea.tetris2011.inc' in App Catalog rule named 'AppCatalogRuleName.{guid}' and acknowledge the codes are out of date
	Then  The last upload of VPP redemption codes succeeded
	
Examples: 
| RedemptionCodeSpreadsheetLocation                                                                                   |
| file:\\\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\RedemptionCodes\\VppRedemptionCodes_2.xls |
| file:\\\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\RedemptionCodes\\VppRedemptionCodes_5.xls |

@CleanDatabaseForVppRedemptionCodes
Scenario: Upload a redemption code spreadsheet for a different application name (TC 47678)
	Given I upload VPP redemption codes from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\RedemptionCodes\\VppRedemptionCodes_7.xls' for the application with name 'Tetris' and bundle identifier 'com.ea.tetris2011.inc' in App Catalog rule named 'AppCatalogRuleName.{guid}'
	Then  The last upload of VPP redemption codes failed because the spreadsheet is for a different application
	When  I upload VPP redemption codes from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\RedemptionCodes\\VppRedemptionCodes_7.xls' for the application with name 'Tetris' and bundle identifier 'com.ea.tetris2011.inc' in App Catalog rule named 'AppCatalogRuleName.{guid}' and acknowledge the codes are for a different application
	Then  The last upload of VPP redemption codes succeeded

@CleanDatabaseForVppRedemptionCodes
Scenario: Upload a redemption code spreadsheet for a different application name with fewer redeemed codes (TC 47678)
	Given I upload VPP redemption codes from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\RedemptionCodes\\VppRedemptionCodes_1.xls' for the application with name 'Tetris' and bundle identifier 'com.ea.tetris2011.inc' in App Catalog rule named 'AppCatalogRuleName.{guid}'
	Then  The last upload of VPP redemption codes failed because the spreadsheet is for a different application
	When  I upload VPP redemption codes from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\RedemptionCodes\\VppRedemptionCodes_1.xls' for the application with name 'Tetris' and bundle identifier 'com.ea.tetris2011.inc' in App Catalog rule named 'AppCatalogRuleName.{guid}' and acknowledge the codes are for a different application
	Then  The last upload of VPP redemption codes failed because the spreadsheet is out of date
	When  I upload VPP redemption codes from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\AppleVolumePurchaseProgram\\RedemptionCodes\\VppRedemptionCodes_1.xls' for the application with name 'Tetris' and bundle identifier 'com.ea.tetris2011.inc' in App Catalog rule named 'AppCatalogRuleName.{guid}' and acknowledge the codes are out of date and for a different application
	Then  The last upload of VPP redemption codes succeeded