@ignore
Feature: DfcLocationAccuracy
    In order to better manage my ability to locate a desired device in the future
    As an administrator
    I want to install a profile containing a Location Accuracy feature control payload

Background:
Given I am a user with name 'Administrator' and password '1'
     And I have created an Android+ add device rule as follows:
    | Name                         | DeviceFamily | TargetGroups | Priority |
    | autogenerate {guid}.RuleName | AndroidPlus  | \\My Company | Normal   |
    And I have enrolled an AfW device configured as follows:
    | AddDeviceRuleName | DeviceId                     |
    | {guid}.RuleName   | autogenerate {guid}.DeviceId |

#Scenarios for each of the individual values
@ignore
Scenario Outline: Create and assign a profile containing a feature control payload with Location Accuracy set to <'Location Accuracy Value'>
Given I have created profiles with the DFC payload as follows:
| Platform    | ProfileType | ProfileName                     | RestrictionName    | RestrictionValue         |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName | LocationAccuracy   | <Location Accuracy Value>|
When I assign the profiles as follows:
| ProfileName        | TargetDevice    | TargetGroup |
| {guid}.ProfileName | {guid}.DeviceId |             |
Then The statuses of the profiles are as follows:
| ProfileName        | DeviceId        | ProfileStatus |
| {guid}.ProfileName | {guid}.DeviceId | Installed     |
    And The values of the DFC restrictions are as follows:
    | DeviceId        | RestrictionName    | RestrictionValue         |
    | {guid}.DeviceId | LocationAccuracy   | <Location Accuracy Value>|


Examples: 
| Location Accuracy Value |
| NotImposed              |
| Disabled                |
| HighAccuracy            |
| GPSOnly                 |
| BatterySaving           |

#Scenarios for various merge cases
@ignore
Scenario: Create and assign 5 conflicting profiles containing all different Location Accuracy values
Given I have created profiles with the DFC payload as follows:
| Platform    | ProfileType | ProfileName                      | RestrictionName  | RestrictionValue | 
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName1 | LocationAccuracy | NotImposed       |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName2 | LocationAccuracy | Disabled         |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName3 | LocationAccuracy | HighAccuracy     |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName4 | LocationAccuracy | GPSOnly          |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName5 | LocationAccuracy | BatterySaving    |
When I assign the profiles as follows:
| ProfileName         | TargetDevice    | TargetGroup |
| {guid}.ProfileName1 | {guid}.DeviceId |             |
| {guid}.ProfileName2 | {guid}.DeviceId |             |
| {guid}.ProfileName3 | {guid}.DeviceId |             |
| {guid}.ProfileName4 | {guid}.DeviceId |             |
| {guid}.ProfileName5 | {guid}.DeviceId |             |
Then The statuses of the profiles are as follows:
| ProfileName         | DeviceId        | ProfileStatus |
| {guid}.ProfileName1 | {guid}.DeviceId | Installed     |
| {guid}.ProfileName2 | {guid}.DeviceId | Installed     |
| {guid}.ProfileName3 | {guid}.DeviceId | Installed     |
| {guid}.ProfileName4 | {guid}.DeviceId | Installed     |
| {guid}.ProfileName5 | {guid}.DeviceId | Installed     |
    And The values of the DFC restrictions are as follows:
    | DeviceId        | RestrictionName    | RestrictionValue |
    | {guid}.DeviceId | LocationAccuracy   | Disabled         |

@ignore
Scenario: Create and assign 4 conflicting profiles containing all different Location Accuracy values
Given I have created profiles with the DFC payload as follows:
| Platform    | ProfileType | ProfileName                      | RestrictionName  | RestrictionValue | 
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName1 | LocationAccuracy | NotImposed       |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName2 | LocationAccuracy | HighAccuracy     |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName3 | LocationAccuracy | GPSOnly          |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName4 | LocationAccuracy | BatterySaving    |
When I assign the profiles as follows:
| ProfileName         | TargetDevice    | TargetGroup |
| {guid}.ProfileName1 | {guid}.DeviceId |             |
| {guid}.ProfileName2 | {guid}.DeviceId |             |
| {guid}.ProfileName3 | {guid}.DeviceId |             |
Then The statuses of the profiles are as follows:
| ProfileName         | DeviceId        | ProfileStatus |
| {guid}.ProfileName1 | {guid}.DeviceId | Installed     |
| {guid}.ProfileName2 | {guid}.DeviceId | Installed     |
| {guid}.ProfileName3 | {guid}.DeviceId | Installed     |
    And The values of the DFC restrictions are as follows:
    | DeviceId        | RestrictionName    | RestrictionValue |
    | {guid}.DeviceId | LocationAccuracy   | HighAccuracy     |

@ignore
Scenario: Create and assign 3 conflicting profiles containing all different Location Accuracy values
Given I have created profiles with the DFC payload as follows:
| Platform    | ProfileType | ProfileName                      | RestrictionName  | RestrictionValue | 
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName1 | LocationAccuracy | NotImposed       |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName2 | LocationAccuracy | GPSOnly          |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName3 | LocationAccuracy | BatterySaving    |
When I assign the profiles as follows:
| ProfileName         | TargetDevice    | TargetGroup |
| {guid}.ProfileName1 | {guid}.DeviceId |             |
| {guid}.ProfileName2 | {guid}.DeviceId |             |
Then The statuses of the profiles are as follows:
| ProfileName         | DeviceId        | ProfileStatus |
| {guid}.ProfileName1 | {guid}.DeviceId | Installed     |
| {guid}.ProfileName2 | {guid}.DeviceId | Installed     |
    And The values of the DFC restrictions are as follows:
    | DeviceId        | RestrictionName    | RestrictionValue |
    | {guid}.DeviceId | LocationAccuracy   | GPSOnly          |

@ignore
Scenario: Create and assign 2 conflicting profiles containing all different Location Accuracy values
Given I have created profiles with the DFC payload as follows:
| Platform    | ProfileType | ProfileName                      | RestrictionName  | RestrictionValue | 
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName1 | LocationAccuracy | NotImposed       |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName2 | LocationAccuracy | BatterySaving    |
When I assign the profiles as follows:
| ProfileName         | TargetDevice    | TargetGroup |
| {guid}.ProfileName1 | {guid}.DeviceId |             |
| {guid}.ProfileName2 | {guid}.DeviceId |             |
Then The statuses of the profiles are as follows:
| ProfileName         | DeviceId        | ProfileStatus |
| {guid}.ProfileName1 | {guid}.DeviceId | Installed     |
| {guid}.ProfileName2 | {guid}.DeviceId | Installed     |
    And The values of the DFC restrictions are as follows:
    | DeviceId        | RestrictionName    | RestrictionValue |
    | {guid}.DeviceId | LocationAccuracy   | BatterySaving    |