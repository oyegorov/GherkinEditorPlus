Feature: EnrollAfWDevice

@ignore
Scenario Outline: Enroll Android for Work device
Given I am a user with name 'Administrator' and password '1'
	And I created an AfW rule as follows:
	| Name                         | DeviceFamily | TargetGroups | Priority |
	| autogenerate {guid}.RuleName | AndroidPlus  | \\My Company | Normal   |
When I enroll an AfW device with configuration as follows:
# TODO: Review passing rule id vs.iOS (seems like it will end up creating a new rule at this step for iOS?)
| AddDeviceRuleName | DeviceId            | DeviceIp  | GoogleAccountIdentities | DeviceApi    |
| {guid}.RuleName   | autogenerate {guid} | 127.0.0.1 | soti.android@gmail.com  | <Device API> |
Then The AfW device is successfully enrolled to the rule target

Examples:
| Device API                |
| AndroidWorkManagedDevice  |
| AndroidWorkManagedProfile |