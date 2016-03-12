Feature: Retrieving package summary/details

Background: 
    Given I am a system administrator
    Given  Package file is stored at '\\storage\\qaShare\\BDD_IntegrationTests_Data\\AndroidPlusPackage.pcg'
    And  System has packages with properties as follows: 
    | DeviceFamily | PackagePlatform | ReferenceId                | PackageName                | Version |
    | AndroidPlus  | Android         | autogenerate refId1.{guid} | autogenerate Aplus1.{guid} | 1.0     |
    | AndroidPlus  | Android         | refId1.{guid}              | Aplus1.{guid}              | 2.0     |
    | AndroidPlus  | All             | autogenerate refId2.{guid} | autogenerate Aplus2.{guid} | 3.0     |

Scenario Outline: Get package summary for a given package
	When I make a call to public API to get package summary for a package with reference ID <ReferenceId>
	Then Resulting response contains information as follows:
	| Name          | TotalVersions   |
	| <PackageName> | <TotalVersions> |

Examples:
	| ReferenceId   | PackageName   | TotalVersions |
	| refId1.{guid} | Aplus1.{guid} | 2             |
	| refId2.{guid} | Aplus2.{guid} | 1             |

Scenario Outline: Get package summary for non-existent package
	When I make a call to public API to get package summary for a package with reference ID <ReferenceId>
	Then Resulting package summary response is empty
Examples:
	| ReferenceId         |
	| WrongReferenceId    |
	| autogenerate {guid} |

Scenario: Get package summary with wrong request parameter
	When I make a call to public API to get package summary for a package with null reference ID
	Then Server reports BusinessLogicException with error code '2'


Scenario Outline: Get details for a given version of a package
	When I make a call to public API to get package version details for following package versions:
	| ReferenceId   | Version   |
	| <ReferenceId> | <Version> |
	Then Resulting package version details response contains infromation as follows:
	| Name          | Version   |
	| <PackageName> | <Version> |
Examples:
	| ReferenceId   | PackageName   | Version |
	| refId1.{guid} | Aplus1.{guid} | 2.0     |
	| refId2.{guid} | Aplus2.{guid} | 3.0     |

Scenario Outline: Get details for non-existent package or package version
	When I make a call to public API to get package version details for following package versions:
	| ReferenceId   | Version   |
	| <ReferenceId> | <Version> |
	Then Resulting package version details response is empty

Examples:
	| ReferenceId         | Version |
	| WrongReferenceId    | 2.0     |
	| refId2.{guid}       | 1.0     |
	| autogenerate {guid} | 7       |