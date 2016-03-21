Feature: Profile Management
	Managing profiles using public API

Background: 
    Given I am a system administrator
    And Package file is stored at '\\storage\\qaShare\\BDD_IntegrationTests_Data\\AndroidPlusPackage.pcg'
	And  System has packages with properties as follows: 
    | DeviceFamily | PackagePlatform | ReferenceId         | PackageName                |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus1.{guid} |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus2.{guid} |
    And I created a profile for a platfrom 'AndroidPlus' with package payloads as follows
    | PackageName   | Depends On    |
    | Aplus1.{guid} | Aplus2.{guid} |

Scenario: Clone profile which is not assigned yet, keeping packages
	When I call public API to clone profile with options as follows:
    | OptionName | OptionValue |
    | Packages   | true        |
    Then Profile summary returned by public API contains packages in following order
    | PackageName   |
    | Aplus1.{guid} |

Scenario: Clone profile which is not assigned yet, without packages
	When I call public API to clone profile with options as follows:
    | OptionName | OptionValue |
    | Packages   | false       |
    Then Profile summary returned by public API contains no packages