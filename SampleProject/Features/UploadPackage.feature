Feature: Uploading package
    Uploading package via public API

Background: 
	Given I am a system administrator

@package
Scenario Outline: Upload package with basic information
	When I upload a package file from '\\storage\\qaShare\\BDD_IntegrationTests_Data\\AndroidPlusPackage.pcg' with properties as follows:
    | PackagePlatform   | packname            |
    | <PackagePlatform> | autogenerate {guid} |
    And I add a new package version via public API using the file uploaded with properties as follows:
    | DeviceFamily   | ReferenceId         |
    | <DeviceFamily> | autogenerate {guid} |
	Then The package summary returned via public API with the properties as specified

    Examples: 
    | PackagePlatform         | DeviceFamily   |
    | Android                 | AndroidPlus    |
    | WindowsCE               | WindowsCE      |
    | AllWindowsMobile        | WindowsCE      |
    | WindowsMobile           | WindowsCE      |
    | WindowsMobileSmartPhone | WindowsCE      |
    | WindowsDesktop          | WindowsDesktop |
    | Printer                 | Printer        |
    
@package
Scenario Outline: Upload package with device family mismatch
	When I upload a package file from '\\storage\\qaShare\\BDD_IntegrationTests_Data\\AndroidPlusPackage.pcg' with properties as follows:
    | PackagePlatform   | packname            |
    | <PackagePlatform> | autogenerate {guid} |
    And I add a new package version via public API using the file uploaded with properties as follows:
    | DeviceFamily   | ReferenceId         |
    | <DeviceFamily> | autogenerate {guid} |
	Then Public API returns error # '1601'
	
	Examples: 
    | PackagePlatform | DeviceFamily   |
    | Printer         | AndroidPlus    |
    | Android         | WindowsCE      |
    | WindowsCE       | WindowsDesktop |
    | WindowsDesktop  | Printer        |

@package
Scenario Outline: Upload package with invalid Device Family values
	When I upload a package file from '\\storage\\qaShare\\BDD_IntegrationTests_Data\\AndroidPlusPackage.pcg' with properties as follows:
    | DeviceFamily   | packname            |
    | Android        | autogenerate {guid} |
    | Printer        | autogenerate {guid} |
    | WindowsCE      | autogenerate {guid} |
    | WindowsDesktop | autogenerate {guid} |
    And I add a new package version via public API using the file uploaded with properties as follows:
    | DeviceFamily   | ReferenceId         |
    | <DeviceFamily> | autogenerate {guid} |
	Then Public API returns error # '2'

    Examples: 
    | DeviceFamily |
    | All          |
    | NotSpecified |

@package
Scenario Outline: Upload the package with a same Name and Version twice
    When I upload a package file from '\\storage\\qaShare\\BDD_IntegrationTests_Data\\AndroidPlusPackage.pcg' with properties as follows:
    | PackagePlatform   | packname            |
    | <PackagePlatform> | autogenerate {guid} |
    And I add a new package version via public API using the file uploaded with properties as follows:
    | DeviceFamily   | ReferenceId         |
    | <DeviceFamily> | autogenerate {guid} |
    And I add the same package version via public API

    Then Public API returns error # '1600'
       
    Examples: 
    | PackagePlatform | DeviceFamily   |
    | Printer         | Printer        |
    | Android         | Android        |
    | WindowsCE       | WindowsCE      |
    | WindowsDesktop  | WindowsDesktop |

@package
Scenario Outline: Upload different versions of a package
    When I upload a package file from '\\storage\\qaShare\\BDD_IntegrationTests_Data\\AndroidPlusPackage.pcg' with properties as follows:
    | PackagePlatform   | packname                   | BuildVersion | Version |
    | <PackagePlatform> | autogenerate Package{guid} | 1            | 1.0     |
    And I add a new package version via public API using the file uploaded with properties as follows:
    | DeviceFamily   | ReferenceId         |
    | <DeviceFamily> | autogenerate {guid} |
    When I upload a package file from '\\storage\\qaShare\\BDD_IntegrationTests_Data\\AndroidPlusPackage.pcg' with properties as follows:
    | PackagePlatform   | packname      | BuildVersion | Version |
    | <PackagePlatform> | Package{guid} | 2            | 2.0     |
    And I add a new package version via public API using the file uploaded with properties as follows:
    | DeviceFamily   | 
    | <DeviceFamily> |

	Then The package summary returned via public API with the properties as specified
       
    Examples: 
    | PackagePlatform | DeviceFamily   |
    | Printer         | Printer        |
    | Android         | Android        |
    | WindowsCE       | WindowsCE      |
    | WindowsDesktop  | WindowsDesktop |

@package
Scenario Outline: Upload package with invalid format
	When I upload file from '\\storage\\qaShare\\BDD_IntegrationTests_Data\\InvalidPackage.pcg'
    And I add a new package version via public API using the file uploaded with properties as follows:
    | DeviceFamily   | ReferenceId         |
    | <DeviceFamily> | autogenerate {guid} |
	Then Public API returns error # '1603'

    Examples: 
    | DeviceFamily   |
    | AndroidPlus    |
    | WindowsCE      |
    | WindowsDesktop |
    | Printer        |
