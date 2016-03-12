@ignore
Feature: WipeDeviceWithBypassFactoryResetProtection
    In order to avoid Google account and password input during Android device factory reset procedure
    As an Administrator
    I want to wipe device with bypass factory reset protection option

Background:
Given I am a user with the name 'Administrator' and password '1'
    And I have created an Android+ add device rule as follows:
    | Name                         | DeviceFamily | TargetGroups | Priority |                                                                       
    | autogenerate {guid}.RuleName | AndroidPlus  | \\My Company | Normal   |
    And I have enrolled an AfW device configured as follows:
    | AddDeviceRuleName | DeviceId                     |
    | {guid}.RuleName   | autogenerate {guid}.DeviceId |

@ignore
Scenario Outline: Send Wipe command to an AFW device with and without'Bypass Factory Reset Protection' option
Given I am a user with the name 'Administrator' and password '1'
When I send wipe device request
And I have wipe request as follows:
    |	Request.DeviceId	|	Request.BypassFactoryResetProtection	|	Request.WipeExternal	|
    |	{guid}.DeviceId		|	<BypassFactoryResetProtection>			|	<WipeExternal>			|
Then the reset script on device '{guid}.DeviceId' is as follows:
    | Script.Action | Script.parameters |
    | reset         | <Parameters>      |

Examples: 
| BypassFactoryResetProtection | WipeExternal | Parameters |
| True                         | True         | /e /p      |
| True                         | False        | /w /p      |
| False                        | True         | /e         |
| False                        | False        | /w         |
