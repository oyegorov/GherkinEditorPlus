@ignore
Feature: Android for Work: Ternary state device feature control payloads
    In order to control the end user's ability to use a particular device feature,
    as an Administrator I want to install one or more profiles containing respective device feature control (DFC) payloads.
    The purpose of this test is to ensure that the Deployment Server sends the correct data to the AfW Agent.

Background: 
Given I am a user with the name 'Administrator' and password '1'
    And I have created an Android+ add device rule as follows:
    | Name                         | DeviceFamily | TargetGroups | Priority |                                                                       
    | autogenerate {guid}.RuleName | AndroidPlus  | \\My Company | Normal   |
    And I have enrolled an AfW device configured as follows:
    | AddDeviceRuleName | DeviceId                     |
    | {guid}.RuleName   | autogenerate {guid}.DeviceId |

# Single DFC profile cases
@ignore
Scenario Outline: Create and assign one profile containing a specified DFC payload with the value 'Enabled'
Given I started creation of a profile with properties:
| Platform    | Type        | Name                            |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName |
	And I added DFC payload configured as follow
	| RestrictionName    | RestrictionValue |
	| <Restrictions> | Enabled          |
	And I saved the profile
When I assign the profiles as follows:
         | ProfileName        | TargetDevice   | TargetGroup |
         | {guid}.ProfileName | {guid}.DeviceI |             |
Then The statuses of the profiles are as follows:
| ProfileName        | DeviceId        | ProfileStatus |
| {guid}.ProfileName | {guid}.DeviceId | Installed     |
    And The values of the DFC restrictions are as follows:
    | DeviceId        | RestrictionName    | RestrictionValue |
    | {guid}.DeviceId | <Restriction Name> | Enabled          |
Examples:
| Restriction Name       |
| StayAwakeWhileCharging |
| DisableUsbDebugging    |
| BluetoothState         |
| WifiState              |
| DataRoamingState       |

@ignore
Scenario Outline: Create and assign one profile containing a specified DFC payload with the value 'Disabled'
Given I started creation of a profile with properties:
| Platform    | Type        | Name                            |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName |
	And I added DFC payload configured as follow
	| RestrictionName    | RestrictionValue |
	| <Restriction Name> | Disabled         |
	And I saved the profile
When I assign the profiles as follows:
         | ProfileName        | TargetDevice   | TargetGroup |
         | {guid}.ProfileName | {guid}.DeviceI |             |
Then The statuses of the profiles are as follows:
| ProfileName        | DeviceId        | ProfileStatus |
| {guid}.ProfileName | {guid}.DeviceId | Installed     |
    And The values of the DFC restrictions are as follows:
    | DeviceId        | RestrictionName    | RestrictionValue |
    | {guid}.DeviceId | <Restriction Name> | Disabled         |
Examples:
| Restriction Name       |
| StayAwakeWhileCharging |
| DisableUsbDebugging    |
| BluetoothState         |
| WifiState              |
| DataRoamingState       |

@ignore
Scenario Outline: Create and assign one profile containing a specified DFC payload with the value 'Allow User to Configure'(NotImposed)
Given I started creation of a profile with properties:
| Platform    | Type        | Name                            |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName |
	And I added DFC payload configured as follow
	| RestrictionName    | RestrictionValue |
	| <Restriction Name> | NotImposed       |
	And I saved the profile
When I assign the profiles as follows:
         | ProfileName        | TargetDevice   | TargetGroup |
         | {guid}.ProfileName | {guid}.DeviceI |             |
Then The statuses of the profiles are as follows:
| ProfileName        | DeviceId        | ProfileStatus |
| {guid}.ProfileName | {guid}.DeviceId | Installed     |
    And The values of the DFC restrictions are as follows:
    | DeviceId        | RestrictionName    | RestrictionValue |
    | {guid}.DeviceId | <Restriction Name> | NotImposed       |
Examples:
| Restriction Name       |
| StayAwakeWhileCharging |
| DisableUsbDebugging    |
| BluetoothState         |
| WifiState              |
| DataRoamingState       |


# Multiple conflicting DFC profile cases
@ignore
Scenario Outline: Create and assign two conflicting profiles containing a specified DFC payload with the values 'Disabled' and 'Enabled' and 'Allow User to Configure' (NotImposed)
Given I started creation of a profile with properties:
| Platform    | Type        | Name                             |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName1 |
	And I added DFC payload configured as follow
	| RestrictionName    | RestrictionValue |
	| <Restriction Name> | Disabled         |
	And I saved the profile
	# Create second profile
	And I started creation of a profile with properties:
	| Platform    | Type        | Name                             |
	| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName2 |
	And I added DFC payload configured as follow
	| RestrictionName    | RestrictionValue |
	| <Restriction Name> | Enabled          |
	And I saved the profile
	# Create last profile
	And I started creation of a profile with properties:
	| Platform    | Type        | Name                             |
	| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName3 |
	And I added DFC payload configured as follow
	| RestrictionName    | RestrictionValue |
	| <Restriction Name> | NotImposed       |
	And I saved the profile
When I assign the profiles as follow:
| ProfileName         | DeviceId        |
| {guid}.ProfileName1 | {guid}.DeviceId |
| {guid}.ProfileName2 | {guid}.DeviceId |
| {guid}.ProfileName3 | {guid}.DeviceId |
Then The statuses of the profiles are as follows:
| ProfileName         | DeviceId        | ProfileStatus |
| {guid}.ProfileName1 | {guid}.DeviceId | Installed     |
| {guid}.ProfileName2 | {guid}.DeviceId | Installed     |
| {guid}.ProfileName3 | {guid}.DeviceId | Installed     |
    And The values of the DFC restrictions are as follows:
    | DeviceId        | RestrictionName    | RestrictionValue |
    | {guid}.DeviceId | <Restriction Name> | Disabled         |
Examples:
| Restriction Name       |
| StayAwakeWhileCharging |
| DisableUsbDebugging    |
| BluetoothState         |
| WifiState              |
| DataRoamingState       |

@ignore
Scenario Outline: Create and assign two conflicting profiles containing a specified DFC payload with the values 'Enabled' and 'Allow User to Configure'  (NotImposed)
Given I started creation of a profile with properties:
| Platform    | Type        | Name                             |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName1 |
	And I added DFC payload configured as follow
	| RestrictionName    | RestrictionValue |
	| <Restriction Name> | Enabled         |
	And I saved the profile
	# Create last profile
	And I started creation of a profile with properties:
	| Platform    | Type        | Name                             |
	| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName2 |
	And I added DFC payload configured as follow
	| RestrictionName    | RestrictionValue |
	| <Restriction Name> | NotImposed       |
	And I saved the profile
When I assign the profiles as follow:
| ProfileName         | DeviceId        |
| {guid}.ProfileName1 | {guid}.DeviceId |
| {guid}.ProfileName2 | {guid}.DeviceId |
Then The statuses of the profiles are as follows:
| ProfileName         | DeviceId        | ProfileStatus |
| {guid}.ProfileName1 | {guid}.DeviceId | Installed     |
| {guid}.ProfileName2 | {guid}.DeviceId | Installed     |
    And The values of the DFC restrictions are as follows:
    | DeviceId        | RestrictionName    | RestrictionValue |
    | {guid}.DeviceId | <Restriction Name> | Enabled          |
Examples:
| Restriction Name       |
| StayAwakeWhileCharging |
| DisableUsbDebugging    |
| BluetoothState         |
| WifiState              |
| DataRoamingState       |

@ignore
Scenario Outline: Create and assign two conflicting profiles containing a specified DFC payload with the values 'Enabled' and 'Disabled'
Given I started creation of a profile with properties:
| Platform    | Type        | Name                             |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName1 |
	And I added DFC payload configured as follow
	| RestrictionName    | RestrictionValue |
	| <Restriction Name> | Enabled         |
	And I saved the profile
	# Create last profile
	And I started creation of a profile with properties:
	| Platform    | Type        | Name                             |
	| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName2 |
	And I added DFC payload configured as follow
	| RestrictionName    | RestrictionValue |
	| <Restriction Name> | Disabled         |
	And I saved the profile
When I assign the profiles as follow:
| ProfileName         | DeviceId        |
| {guid}.ProfileName1 | {guid}.DeviceId |
| {guid}.ProfileName2 | {guid}.DeviceId |
Then The statuses of the profiles are as follows:
| ProfileName         | DeviceId        | ProfileStatus |
| {guid}.ProfileName1 | {guid}.DeviceId | Installed     |
| {guid}.ProfileName2 | {guid}.DeviceId | Installed     |
    And The values of the DFC restrictions are as follows:
    | DeviceId        | RestrictionName    | RestrictionValue |
    | {guid}.DeviceId | <Restriction Name> | Disabled         |
Examples:
| Restriction Name       |
| StayAwakeWhileCharging |
| DisableUsbDebugging    |
| BluetoothState         |
| WifiState              |
| DataRoamingState       |