Feature: DeviceProfiles
	Operation related to retrieving the list of profiles that
	are currently assigned to a given device.

Background:
	Given I am a client of Public API with name 'ApiClient' and secret 'ClientSecret'
	And I make calls to Public API on behalf of user 'Administrator' with password '1'

Scenario: Assigned profile appears as a device profile
	Given I am a user with name 'Administrator' and password '1'
	Given I have created a device group with properties as follows:
		| Name                             | Kind    | Icon   | Path                                |
		| autogenerate devicegroup1.{guid} | Regular | Yellow | \\\\My Company\\devicegroup1.{guid} |
	And I have created a rule as follows:
		| Name                          | DeviceFamily | TargetGroups                        | LdapConnection |
		| autogenerate {guid}.RuleName1 | Ios          | \\\\My Company\\devicegroup1.{guid} | {soti.net}     |
	And I have enrolled Ios Devices with properties as follows:
		| DeviceName                     | RuleName         | LdapUserName | LdapUserPassword | DeviceId          | OSVersion |
		| autogenerate deviceId01.{guid} | {guid}.RuleName1 | testuser2    | Bonjour321       | deviceId01.{guid} | 9.0       |
	When I create a profile for iOS with wifi payload and identifier as follows
		| ReferenceId                     |
		| autogenerate profileId01.{guid} |
	And I assign this profile to path '\\My Company\devicegroup1.{guid}' with options as follows
         | OptionName         | OptionValue |
         | NetworkRestriction | AnyNetwork  |
	Then The identifier for the profile assosciated to the device with deviceId of 'deviceId01.{guid}' should be 'profileId01.{guid}'
	
Scenario: Getting newly assigned device profile status
	Given I am a user with name 'Administrator' and password '1'
	Given I have created a device group with properties as follows:
		| Name                             | Kind    | Icon   | Path                                |
		| autogenerate devicegroup2.{guid} | Regular | Yellow | \\\\My Company\\devicegroup2.{guid} |
	And I have created a rule as follows:
		| Name                         | DeviceFamily | TargetGroups                        | LdapConnection |
		| autogenerate {guid}.RuleName2 | Ios          | \\\\My Company\\devicegroup2.{guid} | {soti.net}     |
	And I have enrolled Ios Devices with properties as follows:
		| DeviceName                     | RuleName         | LdapConnection | LdapUserName | LdapUserPassword | DeviceId          | OSVersion |
		| autogenerate deviceId02.{guid} | {guid}.RuleName2 | {soti.net}     | testuser2    | Bonjour321       | deviceId02.{guid} | 9.0       |
	When I create a profile for iOS with wifi payload and identifier as follows
         | ReferenceId                     |
         | autogenerate profileId02.{guid} |
	And I assign this profile to path '\\My Company\devicegroup2.{guid}' with options as follows
         | OptionName		  | OptionValue |
         | NetworkRestriction | AnyNetwork	|
	Then Device profile statuses should be as follows:
		| Status       | DeviceId          | ProfileId          |
		| NotInstalled | deviceId02.{guid} | profileId02.{guid} |

Scenario: Getting revoked device profile returns not administratively revoked status
	Given I am a user with name 'Administrator' and password '1'
	Given I have created a device group with properties as follows:
		| Name                             | Kind    | Icon   | Path                                |
		| autogenerate devicegroup3.{guid} | Regular | Yellow | \\\\My Company\\devicegroup3.{guid} |
	And I have created a rule as follows:
		| Name                          | DeviceFamily | TargetGroups                        | LdapConnection |
		| autogenerate {guid}.RuleName3 | Ios          | \\\\My Company\\devicegroup3.{guid} | {soti.net}     |
	And I have enrolled Ios Devices with properties as follows:
		| DeviceName                     | RuleName        | LdapConnection | LdapUserName | LdapUserPassword | DeviceId          | OSVersion |
		| autogenerate deviceId03.{guid} | {guid}.RuleName3 | {soti.net}     | testuser2    | Bonjour321       | deviceId03.{guid} | 9.0       |
	When I create a profile for iOS with wifi payload and identifier as follows
         | ReferenceId                     |
         | autogenerate profileId03.{guid} |
	And I assign this profile to path '\\My Company\devicegroup3.{guid}' with options as follows
         | OptionName         | OptionValue |
         | NetworkRestriction | AnyNetwork  |
	Then Device profile statuses should be as follows:
		| Status       | DeviceId          | ProfileId          |
		| NotInstalled | deviceId03.{guid} | profileId03.{guid} |
	When I execute a device profile action with options as follows:
		 | Action | DeviceId          | ProfileId          |
		 | Revoke | deviceId03.{guid} | profileId03.{guid} |
	Then Device profile statuses should be as follows:
		| Status                  | DeviceId          | ProfileId          |
		| AdministrativelyRemoved | deviceId03.{guid} | profileId03.{guid} |

Scenario Outline: Test actions properly administered
	Given I am a user with name 'Administrator' and password '1'
	Given I have created a device group with properties as follows:
		| Name                             | Kind    | Icon   | Path                                |
		| autogenerate devicegroup4.{guid} | Regular | Yellow | \\\\My Company\\devicegroup4.{guid} |
	And I have created a rule as follows:
		| Name                          | DeviceFamily | TargetGroups                        | LdapConnection |
		| autogenerate {guid}.RuleName4 | Ios          | \\\\My Company\\devicegroup4.{guid} | {soti.net}     |
	And I have enrolled Ios Devices with properties as follows:
		| DeviceName                     | RuleName        | LdapConnection | LdapUserName | LdapUserPassword | DeviceId          | OSVersion |
		| autogenerate deviceId05.{guid} | {guid}.RuleName4 | {soti.net}     | testuser2    | Bonjour321       | deviceId05.{guid} | 9.0       |
	When I create a profile for iOS with wifi payload and identifier as follows
         | ReferenceId               |
         | autogenerate <ProfileId1> |
	And I assign this profile to path '\\My Company\devicegroup4.{guid}' with options as follows
         | OptionName		  | OptionValue |
         | NetworkRestriction | AnyNetwork	|
	And I create a profile for iOS with wifi payload and identifier as follows
		| ReferenceId               |
		| autogenerate <ProfileId2> |
	And I assign this profile to path '\\My Company\devicegroup4.{guid}' with options as follows
         | OptionName		  | OptionValue |
         | NetworkRestriction | AnyNetwork	|
	When I execute a device profile action with options as follows:
		 | Action    | DeviceId          | ProfileId    |
		 | <Action1> | deviceId05.{guid} | <ProfileId1> |
		 | <Action2> | deviceId05.{guid} | <ProfileId2> |
	Then Device profile statuses should be as follows:
		| Status    | DeviceId   | ProfileId    |
		| <Status1> | <DeviceId> | <ProfileId1> |
		| <Status2> | <DeviceId> | <ProfileId2> |

	Examples: 
		| Status1                 | Status2                 | DeviceId          | ProfileId1         | ProfileId2         | Action1 | Action2 |
		| InstallPending          | AdministrativelyRemoved | deviceId05.{guid} | profileId04.{guid} | rofileId05.{guid}  | Install | Revoke  |
		| InstallPending          | InstallPending          | deviceId05.{guid} | profileId04.{guid} | profileId05.{guid} | Install | Install |
		| AdministrativelyRemoved | AdministrativelyRemoved | deviceId05.{guid} | profileId04.{guid} | profileId05.{guid} | Revoke  | Revoke  |