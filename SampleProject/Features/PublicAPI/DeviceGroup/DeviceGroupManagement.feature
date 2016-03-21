Feature: Device Group Management
	Operation related management of device groups

Background:
Given I am a client of Public API with name 'ApiClient' and secret 'ClientSecret'
	And I make calls to Public API on behalf of user 'Administrator' with password '1'

Scenario: Get All Device Groups	
	When I invoke GET on DeviceGroups with parameters as follows:
	| parentpath |
	| {null}     |
	Then Public API response is 'OK'

Scenario: Get All standard Device Groups
	When I invoke GET on DeviceGroups with parameters as follows:
	| parentpath |
	| {null}     |
	Then Public API response includes the following device groups:
	| Name               | Kind    | Icon   | Path                               |
	| My Company         | Regular | Yellow | \\\\My Company                     |
	| Management Devices | Regular | Yellow | \\\\My Company\\Management Devices |
	| Sales Devices      | Regular | Yellow | \\\\My Company\\Sales Devices      |
	| Warehouse Devices  | Regular | Yellow | \\\\My Company\\Warehouse Devices  |

Scenario: Creating a Group
When I invoke POST on DeviceGroups with properties as follows:
	| Name                             | Kind    | Icon   | Path                                |
	| autogenerate devicegroup1.{guid} | Regular | Yellow | \\\\My Company\\devicegroup1.{guid} |
Then Public API response includes the device group with properties as specified

Scenario: Getting a device group by path
Given I have created a device group with properties as follows:
	| Name                             | Kind    | Icon   | Path                                |
	| autogenerate devicegroup2.{guid} | Regular | Yellow | \\\\My Company\\devicegroup2.{guid} |
When I invoke GET on DeviceGroups with parameters as follows:
	| parentpath     |
	| \\\\My Company |
Then Public API response includes the following device groups:
	| Name                | Kind    | Icon   | Path                                |
	| devicegroup2.{guid} | Regular | Yellow | \\\\My Company\\devicegroup2.{guid} |

Scenario: Creating a New Root Group
When I invoke POST on DeviceGroups with properties as follows:
	| Name                             | Kind    | Icon   | Path                    |
	| autogenerate devicegroup3.{guid} | Regular | Yellow | \\\\devicegroup3.{guid} |
Then Public API response is 'OK'

Scenario: Getting a New root group created 
Given I have created a device group with properties as follows:
	| Name                             | Kind    | Icon | Path                    |
	| autogenerate devicegroup4.{guid} | Regular | Red  | \\\\devicegroup4.{guid} |
When I invoke GET on DeviceGroups with parameters as follows:
	| parentpath|
	| {null} |
Then Public API response includes the following device groups:
	| Name                | Kind    | Icon | Path                    |
	| devicegroup4.{guid} | Regular | Red  | \\\\devicegroup4.{guid} |

Scenario: Creating a new Subgroup Inside New root Group
Given I have created a device group with properties as follows:
	| Name                             | Kind    | Icon   | Path                    |
	| autogenerate devicegroup5.{guid} | Regular | Yellow | \\\\devicegroup5.{guid} |
When I invoke POST on DeviceGroups with properties as follows:
    | Name                                 | Kind   | Icon   | Path                                         |
    |  autogenerate devicegroup6.{time}    |Regular | Yellow | \\\\devicegroup5.{guid}\\devicegroup6.{time} |
Then Public API response is 'OK'

Scenario: Getting subgroup inside New Root group
Given I have created a device group with properties as follows:
	| Name                             | Kind    | Icon   | Path                    |
	| autogenerate devicegroup6.{guid} | Regular | Yellow | \\\\devicegroup6.{guid} |
And I have created a device group with properties as follows:
    | Name                            | Kind    | Icon      | Path                   |
    |autogenerate devicegroup7.{time} | Regular |  Yellow   | \\\\devicegroup6.{guid}\\devicegroup7.{time}|
When I invoke GET on DeviceGroups with parameters as follows:
    | parentpath               |
    |  \\\\devicegroup6.{guid} |
Then Public API response includes the following device groups:
    | Name                | Kind   | Icon    | Path                                         |
    |devicegroup7.{time}  | Regular|  Yellow | \\\\devicegroup6.{guid}\\devicegroup7.{time} |

Scenario: Creating a New Virtual Group
When I invoke POST on DeviceGroups with properties as follows:
	| Name                             | Kind    | Icon   | Path                                |
	| autogenerate devicegroup5.{guid} | Virtual | Yellow | \\\\My Company\\devicegroup5.{guid} |
Then Public API response is 'OK'

Scenario: Creating a Green color Device Group 
Given I have created a device group with properties as follows:
	| Name                             | Kind    | Icon   | Path                                |
	| autogenerate devicegroup8.{guid} | Regular | Green  | \\\\My Company\\devicegroup8.{guid} |
When I invoke GET on DeviceGroups with parameters as follows:
	| parentpath     |
	| \\\\My Company |
Then Public API response includes the following device groups:
	| Name                | Kind    | Icon   | Path                                |
	| devicegroup8.{guid} | Regular | Green  | \\\\My Company\\devicegroup8.{guid} |
And Public API response is 'OK'

Scenario: Creating a Group Inside Non existent Group
When I invoke POST on DeviceGroups with properties as follows:
	| Name                             | Kind    | Icon   | Path                                          |
	| autogenerate devicegroup9.{guid} | Regular | Yellow | \\\\No Path\\devicegroup9.{guid} |
Then Public API response is 'Unauthorized access'

Scenario: Creating device group with Special characters in Its name
When I invoke POST on DeviceGroups with properties as follows:
         | Name                             | Kind     | Icon    | Path                              |
         | autogenerate _device&%@9.{guid} |  Regular |  Yellow | \\\\My Company\\_device&%@9.{guid} |
Then Public API response is 'OK'

Scenario: Creating Root group with space in Name 
When I invoke POST on DeviceGroups with properties as follows:
         | Name                                | Kind   | Icon   | Path                      |
         | autogenerate device Group 10.{guid} | Regular| Yellow |\\\\device Group 10.{guid} |
 Then Public API response is 'OK'

 Scenario: Deleting Root Group
 Given I have created a device group with properties as follows:
	| Name                               | Kind    | Icon   | Path                      |
	| autogenerate devicegroup_12.{guid} | Regular | Green  | \\\\devicegroup_12.{guid} |
When I invoke DELETE on DeviceGroups with properties as follows:
   | Path                          |
   | \\\\devicegroup_12.{guid}     | 
Then Public API response is 'OK'

Scenario: Deleting root group that has rule Associated with it
Given I am a user with name 'Administrator' and password '1'
And I have created a device group with properties as follows:
	| Name                               | Kind    | Icon   | Path                      |
	| autogenerate devicegroup_13.{guid} | Regular | Green  | \\\\devicegroup_13.{guid} |
And I have created a rule as follows:
    | Name                         | DeviceFamily | TargetGroups           | LdapConnection | Priority |
    | autogenerate {guid}.RuleName |    Ios       | \\\\devicegroup_13.{guid}|  {sotiqa}     |  Normal  |
When I invoke DELETE on DeviceGroups with properties as follows:
         | Path                          |
         | \\\\devicegroup_13.{guid}     |
Then Public API response is 'errorCode: 1902'

Scenario: Deleting a Root group that has Subgroup
Given I have created a device group with properties as follows:
	| Name                               | Kind    | Icon   | Path                      |
	| autogenerate devicegroup_20.{guid} | Regular | Yellow | \\\\devicegroup_20.{guid} |
And I have created a device group with properties as follows:
    | Name                             | Kind    | Icon      | Path                                          |
    |autogenerate devicegroup1.{time}  | Regular |  Yellow   | \\\\devicegroup_20.{guid}\\devicegroup1.{time}|
When I invoke DELETE on DeviceGroups with properties as follows:
           | Path                                           |
           |\\\\devicegroup_20.{guid}\\devicegroup1.{time}  |
Then Public API response is 'OK'

Scenario: Renaming Group 
Given I have created a device group with properties as follows:
| Name                               | Kind    | Icon   | Path                      |
| autogenerate devicegroup_20.{guid} | Regular | Yellow | \\\\devicegroup_20.{guid} |
When I invoke PUT on DeviceGroups for group '\\devicegroup_20.{guid}' with properties as following:
| Name                               |
| autogenerate devicegroup_21.{guid} |
Then Public API response is 'OK'

Scenario: Creating a Group with name not being part of a path
When I invoke POST on DeviceGroups with properties as follows:
	| Name                | Kind    | Icon   | Path                        |
	| autogenerate {guid} | Regular | Yellow | \\\\My Company\\invalidname |
Then Public API response is 'errorCode: 1907'

Scenario: Creating a Group with path that already exists
When I invoke POST on DeviceGroups with properties as follows:
	| Name                               | Kind    | Icon   | Path                      |
	| autogenerate devicegroup_22.{guid} | Regular | Yellow | \\\\devicegroup_22.{guid} |
And I invoke POST on DeviceGroups with properties as follows:
	| Name                  | Kind    | Icon   | Path                      |
	| devicegroup_22.{guid} | Regular | Yellow | \\\\devicegroup_22.{guid} |
Then Public API response is 'errorCode: 1900'

Scenario: Creating a Group with a virtual parent group
Given I have added device group as follows:
		| Name                               | IsVirtual | Icon   |
		| autogenerate devicegroup_23.{guid} | true      | Yellow |
When I invoke POST on DeviceGroups with properties as follows:
	| Name                               | Kind    | Icon   | Path                                            |
	| autogenerate devicegroup_24.{time} | Regular | Yellow | \\\\devicegroup_23.{guid}\devicegroup_24.{time} |
Then Public API response is 'errorCode: 1901'

Scenario: Creating a Group with empty name
When I invoke POST on DeviceGroups with properties as follows:
	| Name   | Kind    | Icon   | Path                    |
	| {null} | Regular | Yellow | autogenerate \\\\{guid} |
Then Public API response is 'errorCode: 0'












