@ProfileManagement
Feature: Setting profile assignments options

Background: 
    Given I am a system administrator
    Given  Package file is stored at '\\storage\qaShare\BDD_IntegrationTests_Data\AndroidPlusPackage.pcg'

@Package_via_profile
@[MC14401] 
@ignore
Scenario Outline:  Setting package installation schedule for a profile with package payload
    Given  System has packages with properties as follows: 
    | DeviceFamily | PackagePlatform | ReferenceId         | PackageName                |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus1.{guid} |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus2.{guid} |

    When I create a profile for a platfrom 'AndroidPlus' with package payloads as follows
    | PackageName   | Depends On    |
    | Aplus1.{guid} | Aplus2.{guid} |

    And I assign this profile to path '\\My Company\Warehouse Devices' with options as follows
    | OptionName           | OptionValue |
    | InstallationSchedule | <DateValue> |

    Then The resulting profile assignment response contains assignment options as follows:
    | OptionName           | OptionValue |
    | InstallationSchedule | <DateValue> |

    Examples: 
    | DateValue                   |
    | UTC,06 July 2015 7:32:47 AM |
    | 15 July 2015 7:32:47 AM     |
    |                             |

@ignore
Scenario Outline:  Setting network restriction for a profile with simple payload
    When I create a profile for a platfrom 'AndroidPlus' with wifi payload

    And I assign this profile to path '\\My Company\Warehouse Devices' with options as follows
    | OptionName         | OptionValue        |
    | NetworkRestriction | <RestrictionValue> |

    Then The resulting profile assignment response contains assignment options as follows:
    | OptionName         | OptionValue     |
    | NetworkRestriction | <ExpectedValue> |

    Examples: 
    | RestrictionValue | ExpectedValue |
    | AnyNetwork       | AnyNetwork    |
    | ActiveSync       | ActiveSync    |
    | LAN              | LAN           |
    | WiFi             | WiFi          |
    | Cellular         | Cellular      |
    | Roaming          | Roaming       |
    |                  | AnyNetwork    |

@Package_via_profile 
@[MC14399]
Scenario Outline:  Setting network restriction for a profile with package payload
    Given  System has packages with properties as follows: 
    | DeviceFamily | PackagePlatform | ReferenceId         | PackageName                |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus1.{guid} |

    When I create a profile for a platfrom 'AndroidPlus' with package payloads as follows
    | PackageName   | Depends On |
    | Aplus1.{guid} |            |

    And I assign this profile to path '\\My Company\Warehouse Devices' with options as follows
    | OptionName         | OptionValue        |
    | NetworkRestriction | <RestrictionValue> |            

    Then The resulting profile assignment response contains assignment options as follows:
    | OptionName         | OptionValue     |
    | NetworkRestriction | <ExpectedValue> |

    Examples: 
    | RestrictionValue | ExpectedValue |
    | AnyNetwork       | AnyNetwork    |
    | ActiveSync       | ActiveSync    |
    | LAN              | LAN           |
    | WiFi             | WiFi          |
    | Cellular         | Cellular      |
    | Roaming          | Roaming       |
    |                  | AnyNetwork    |

@Package_via_profile 
@[MC14404]
Scenario Outline:  Setting Force Reinstallation Option for a profile with package payload
    Given  System has packages with properties as follows: 
    | DeviceFamily | PackagePlatform | ReferenceId         | PackageName                |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus1.{guid} |

    When I create a profile for a platfrom 'AndroidPlus' with package payloads as follows
    | PackageName   | Depends On |
    | Aplus1.{guid} |            |

    And I assign this profile to path '\\My Company\Warehouse Devices' with options as follows
    | OptionName          | OptionValue |
    | ForceReinstallation | <SetValue>  |

    Then The resulting profile assignment response contains assignment options as follows:
    | OptionName          | OptionValue     |
    | ForceReinstallation | <ExpectedValue> |

    Examples: 
    | SetValue | ExpectedValue |
    | True     | True          |
    | False    | False         |

@Package_via_profile 
@[MC14402]
Scenario Outline:  Setting Package Persistence Option for a profile with package payload
    Given  System has packages with properties as follows: 
    | DeviceFamily | PackagePlatform | ReferenceId         | PackageName                |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus1.{guid} |

    When I create a profile for a platfrom 'AndroidPlus' with package payloads as follows
    | PackageName   | Depends On |
    | Aplus1.{guid} |            |

    And I assign this profile to path '\\My Company\Warehouse Devices' with options as follows
    | OptionName      | OptionValue |
    | PersistPackages | <SetValue>  |

    Then The resulting profile assignment response contains assignment options as follows:
    | OptionName      | OptionValue     |
    | PersistPackages | <ExpectedValue> |

    Examples: 
    | SetValue | ExpectedValue |
    | True     | True          |
    | False    | False         |

@Package_via_profile 
@[MC14403]
Scenario Outline:  Setting Package Uninstall Upon Revocation Option for a profile with package payload
    Given  System has packages with properties as follows: 
    | DeviceFamily | PackagePlatform | ReferenceId         | PackageName                |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus1.{guid} |

    When I create a profile for a platfrom 'AndroidPlus' with package payloads as follows
    | PackageName   | Depends On |
    | Aplus1.{guid} |            |

    And I assign this profile to path '\\My Company\Warehouse Devices' with options as follows
    | OptionName              | OptionValue |
    | UninstallUponRevocation | <SetValue>  |

    Then The resulting profile assignment response contains assignment options as follows:
    | OptionName              | OptionValue     |
    | UninstallUponRevocation | <ExpectedValue> |

    Examples: 
    | SetValue | ExpectedValue |
    | True     | True          |
    | False    | False         |

@Package_via_profile
@[MC14402]
@[MC14403]
Scenario Outline:  Configuring assigned profile and set Package Uninstall Upon Revocation Option
    Given  System has packages with properties as follows: 
    | DeviceFamily | PackagePlatform | ReferenceId         | PackageName                |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus1.{guid} |
    | AndroidPlus  | Android         | autogenerate {guid} | autogenerate Aplus2.{guid} |

    When I create a profile for a platfrom 'AndroidPlus' with package payloads as follows
    | PackageName   | Depends On |
    | Aplus1.{guid} |            |

    And I assign this profile to path '\\My Company\Warehouse Devices' with options as follows
    | OptionName      | OptionValue |
    | PersistPackages | <SetValue>  |

    Then The resulting profile assignment response contains assignment options as follows:
    | OptionName      | OptionValue     |
    | PersistPackages | <ExpectedValue> |

    When I configure this profile with package payloads as follows
    | PackageName   | Depends On |
    | Aplus2.{guid} |            |
    
    And I assign this profile to path '\\My Company\Warehouse Devices' with options as follows
    | OptionName              | OptionValue |
    | UninstallUponRevocation | <SetValue>  |

    Then The resulting profile assignment response contains assignment options as follows:
    | OptionName              | OptionValue     |
    | UninstallUponRevocation | <ExpectedValue> |

    Examples: 
    | SetValue | ExpectedValue |
    | True     | True          |
    | False    | False         |
