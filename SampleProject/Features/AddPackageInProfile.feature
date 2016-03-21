@Package_via_profile
Feature: Create a profile with package
    Creating a profile with package via public API

Background: 
    Given I am a user with name 'Administrator' and password '1'
    Given  Package file is stored at '\\storage\\qaShare\\BDD_IntegrationTests_Data\\AndroidPlusPackage.pcg'

Scenario: Create profile with one package
    Given  System has packages with properties as follows: 
    | DeviceFamily | PackagePlatform | ReferenceId         | PackageName                |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus1.{guid} |

    When I create a profile for a platfrom 'AndroidPlus' with package payloads as follows
    | PackageName   | Depends On |
    | Aplus1.{guid} |            |
    Then The profile returned via public API with the properties as specified

Scenario: Create profile with a package that has dependency
    Given  System has packages with properties as follows: 
    | DeviceFamily | PackagePlatform | ReferenceId         | PackageName                |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus1.{guid} |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus2.{guid} |

    When I create a profile for a platfrom 'AndroidPlus' with package payloads as follows
    | PackageName   | Depends On    |
    | Aplus1.{guid} | Aplus2.{guid} |
    Then The profile returned via public API with the properties as specified

Scenario: Create profile with a package that has dependency on itself
    Given  System has packages with properties as follows: 
    | DeviceFamily | PackagePlatform | ReferenceId         | PackageName                |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus1.{guid} |

    When I create a profile for a platfrom 'AndroidPlus' with package payloads as follows
    | PackageName   | Depends On    |
    | Aplus1.{guid} | Aplus1.{guid} |
    Then The profile returned via public API must fail with error 140

Scenario: Create a profile with simple circular dependency between packages
    Given  System has packages with properties as follows: 
    | DeviceFamily | PackagePlatform | ReferenceId         | PackageName                |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus1.{guid} |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus2.{guid} |

    When I create a profile for a platfrom 'AndroidPlus' with package payloads as follows
    | PackageName   | Depends On    |
    | Aplus1.{guid} | Aplus2.{guid} |
    | Aplus2.{guid} | Aplus1.{guid} |
    Then The profile returned via public API must fail with error 139

Scenario: Creating a profile with package for a wrong platfrom
    Given  System has packages with properties as follows: 
    | DeviceFamily | PackagePlatform | ReferenceId         | PackageName                |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus1.{guid} |

    When I create a profile for a platfrom 'WindowsCE' with package payloads as follows
    | PackageName   | Depends On |
    | Aplus1.{guid} |            |
    Then The profile returned via public API must fail with error 141

Scenario: Creating a profile with package which depends of a package for a wrong platfrom
    Given  System has packages with properties as follows: 
    | DeviceFamily | PackagePlatform | ReferenceId         | PackageName                |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus1.{guid} |
    | WindowsCE    | WindowsCE       | autogenerate {guid} | autogenerate wince.{guid}  |

    When I create a profile for a platfrom 'AndroidPlus' with package payloads as follows
    | PackageName   | Depends On   |
    | Aplus1.{guid} | wince.{guid} |
    Then The profile returned via public API must fail with error 142

Scenario: Create a profile with circular dependency between packages
    Given  System has packages with properties as follows: 
    | DeviceFamily | PackagePlatform | ReferenceId         | PackageName                |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus1.{guid} |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus2.{guid} |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus3.{guid} |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus4.{guid} |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus5.{guid} |

    When I create a profile for a platfrom 'AndroidPlus' with package payloads as follows
    | PackageName   | Depends On    |
    | Aplus1.{guid} | Aplus2.{guid} |
    | Aplus2.{guid} | Aplus3.{guid} |
    | Aplus3.{guid} | Aplus4.{guid} |
    | Aplus4.{guid} | Aplus5.{guid} |
    | Aplus5.{guid} | Aplus1.{guid} |
    Then The profile returned via public API must fail with error 139

Scenario: Create a profile with packages in given order
    Given  System has packages with properties as follows: 
    | DeviceFamily | PackagePlatform | ReferenceId         | PackageName           |
    | WindowsCE    | WindowsCE       | autogenerate {guid} | autogenerate A.{guid} |
    | WindowsCE    | WindowsCE       | autogenerate {guid} | autogenerate B.{guid} |
    | WindowsCE    | WindowsCE       | autogenerate {guid} | autogenerate C.{guid} |
    | WindowsCE    | WindowsCE       | autogenerate {guid} | autogenerate D.{guid} |
    | WindowsCE    | WindowsCE       | autogenerate {guid} | autogenerate E.{guid} |

    When I create a profile for a platfrom 'WindowsCE' with package payloads as follows
    | PackageName | Depends On |
    | A.{guid}    | B.{guid}   |
    | B.{guid}    | C.{guid}   |
    | C.{guid}    | E.{guid}   |
    | D.{guid}    | E.{guid}   |
    | E.{guid}    |            |
    Then The profile returned via public API with the properties as specified
    And  Profile summary returned by public API contains packages in following order
    | PackageName |
    | A.{guid}    |
    | B.{guid}    |
    | C.{guid}    |
    | D.{guid}    |
    | E.{guid}    |
        
Scenario: Configure a profile with packages in given order
    Given  System has packages with properties as follows: 
    | DeviceFamily | PackagePlatform | ReferenceId         | PackageName           |
    | WindowsCE    | WindowsCE       | autogenerate {guid} | autogenerate A.{guid} |
    | WindowsCE    | WindowsCE       | autogenerate {guid} | autogenerate B.{guid} |
    | WindowsCE    | WindowsCE       | autogenerate {guid} | autogenerate C.{guid} |
    | WindowsCE    | WindowsCE       | autogenerate {guid} | autogenerate D.{guid} |
    | WindowsCE    | WindowsCE       | autogenerate {guid} | autogenerate E.{guid} |

    When I create a profile for a platfrom 'WindowsCE' with package payloads as follows
    | PackageName     | Depends On |
    And I configure this profile with package payloads as follows
    | PackageName | Depends On |
    | A.{guid}    | B.{guid}   |
    | B.{guid}    | C.{guid}   |
    | C.{guid}    | E.{guid}   |
    | D.{guid}    | E.{guid}   |
    | E.{guid}    |            |
    Then Profile summary returned by public API contains packages in following order
    | PackageName |
    | A.{guid}    |
    | B.{guid}    |
    | C.{guid}    |
    | D.{guid}    |
    | E.{guid}    |

Scenario: Create and assign profile with a package
    Given  System has packages with properties as follows: 
    | DeviceFamily | PackagePlatform | ReferenceId         | PackageName                |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus1.{guid} |

    When I create a profile for a platfrom 'AndroidPlus' with package payloads as follows and assign it with default options to path '\\My Company\Warehouse Devices'
    | PackageName   | Depends On    |
    | Aplus1.{guid} |  |
    Then The profile returned via public API with the properties as specified