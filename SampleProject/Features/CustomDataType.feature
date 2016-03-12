Feature: CustomDataTypeFeature
	In order to set custom data on device
	As an administrator
	I want to create custom data type

Scenario: Add custom data type
Given I am a user with name 'Administrator' and password '1'
When I make a call to public API to create a custom data type with request properties as follows:
    | DataType.Name                       | DataType.DeviceFamily | DataType.PhysicalType | DataType.Expression                      | DataType.Description |
    | autogenerate CustomTypeName1.{guid} | AndroidPlus           | String                | INI://Test 1.txt?SC=Section 1&NM=Value 1 | Description 1        |

Then The custom data type is created with properties as specified

@ignore
Scenario: Update custom data type
Given I am a user with name 'Administrator' and password '1'
And I have created custom data type with properties as follows:
    | DataType.Name                       | DataType.DeviceFamily | DataType.PhysicalType | DataType.Expression                      | DataType.Description |
    | autogenerate CustomTypeName2.{guid} | AndroidPlus           | String                | INI://Test 1.txt?SC=Section 1&NM=Value 1 | Description 1        |
When I make a call to pulic API to update a custom data type with request properties as follows:
    | DataType.Name          | DataType.DeviceFamily | DeviceFamily | DataType.PhysicalType | DataType.Expression                      | DataType.Description |
    | CustomTypeName2.{guid} | AndroidPlus           | AndroidPlus  | String                | INI://Test 2.txt?SC=Section 1&NM=Value 2 | Description 2        |
Then The custom data type is updated with properties as specified
