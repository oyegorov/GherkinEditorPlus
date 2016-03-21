Feature: DeletePackageFromCatalog
	Deleteing Package from API


	Background: 
    Given I am a system administrator
    Given  Package file is stored at '\\storage\\qaShare\\BDD_IntegrationTests_Data\\AndroidPlusPackage.pcg'
    And  System has packages with properties as follows: 
    | DeviceFamily  | PackagePlatform         | ReferenceId                      | PackageName                     | Version |
    | AndroidPlus   | Android                 | autogenerate refId1.{guid}       | autogenerate Aplus1.{guid}      | 1.0     |
    | AndroidPlus   | Android                 | refId1.{guid}                    | Aplus1.{guid}                   | 2.0     |
    | AndroidPlus   | All                     | autogenerate refId2.{guid}       | autogenerate Aplus2.{guid}      | 3.0     |
	| WindowsDesktop| WindowsCE               | autogenerate windowsref1.{guid}  | autogenerate windows.{guid}     | 1.0     |
	| Printer       | Printer                 | autogenerate PrinterRef1.{guid}  | autogenerate Printer.{guid}     | 1.0     |
	| WindowsCE     | WindowsMobileSmartPhone | autogenerate MobileRef1.{guid}   | autogenerate Mobile.{guid}      | 1.0     |


Scenario Outline: Delete Selected Packages
When I Delete Package with following properties 
 | ReferenceId       |Version    |
 | <ReferenceId>     | <Version> |
 
Then Public API response is 'OK'

Examples: 
| ReferenceId       |Version  |
| refId1.{guid}     | 1.0     |
| PrinterRef1.{guid}| 1.0     |
| MobileRef1.{guid} | 1.0     |
 

Scenario: Deleting a Pacakage associated with Profile returns error
Given I created a profile for a platfrom 'AndroidPlus' with package payloads as follows
    | PackageName   | Depends On |
    | Aplus1.{guid} |            |
	When I Delete Package with following properties 
    | ReferenceId     | Version |
    | refId1.{guid}   | 1.0     |
	Then Public API response is 'errorCode:1605'


Scenario: Deleting only one version of Package
Given I Delete Package with following properties
	| ReferenceId      | Version |
	| refId1.{guid}    | 1.0     |
	When I make a call to public API to get package summary for a package with reference ID refId1.{guid}
	Then Resulting response contains information as follows:
	| Name            | TotalVersions   |
	| Aplus1.{guid}   | 1               |
