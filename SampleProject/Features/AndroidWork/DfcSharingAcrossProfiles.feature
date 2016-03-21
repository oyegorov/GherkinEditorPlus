Feature: DfcSharingAcrossProfiles
	In order to control a user's ability to share content to apps across their Work and Personal profiles
	As an Adminstrator
	I want to install a profile containing a Sharing Across Profiles feature control payload

Background: 
Given I am a user with name 'Administrator' and password '1'
	And I have configured LDAP connection as follows:
    | Name                               | Server        | UserName  | Password   | Base DN                |
    | autogenerate {guid}.LdapConnection | corp.soti.net | testuser2 | Bonjour321 | DC=corp,DC=soti,DC=net |
	And I created an AfW rule as follows:
	| Name                         | DeviceFamily | TargetGroups | LdapConnection        | Priority |
    | autogenerate {guid}.RuleName | AndroidPlus  | \\My Company | {guid}.LdapConnection | Normal   |
	
	And I enroll an AfW device with configuration as follows:
	| AddDeviceRuleName	| DeviceId            | DeviceIp  | LdapUserName | LdapUserPassword |
	| {guid}.RuleName   | autogenerate {guid} | 127.0.0.1 | testuser2    | Bonjour321       |

@ignore
Scenario: Sharing Across Profiles - Enabled feature control payload
When I create a profile for a platfrom 'AndroidWork' with 'Feature Control' payloads as follows:
    | ProfileName					| DFCOption						| Value		|
    | Sharing Across Profiles Test	| Sharing Across Profiles		| Enabled   |
Then The profile is created with the properties as specified 
	And Users should be able to share to personal or work apps that support the Sharing feature

@ignore
Scenario: Sharing Across Profiles - Disabled from Personal to work feature control payload
When I create a profile for a platfrom 'AndroidWork' with 'Feature Control' payloads as follows:
    | ProfileName					| DFCOption						| Value									|
    | Sharing Across Profiles Test	| Sharing Across Profiles		| Disabled from Personal to Work Only   |
Then The profile is created with the properties as specified 
	And Users can share from Work to Work apps
	And Users can share from Work to Personal apps
	And Users cannot share from Personal to Work apps

@ignore
Scenario: Sharing Across Profiles - Disabled from Work to Personal Only feature control payload
When I create a profile for a platfrom 'AndroidWork' with 'Feature Control' payloads as follows:
    | ProfileName					| DFCOption						| Value									|
    | Sharing Across Profiles Test	| Sharing Across Profiles		| Disabled from Work to Personal Only   |
Then The profile is created with the properties as specified 
	And Users can share from Personal to Personal apps
	And Users can share from Personal to work apps
	And Users cannot share from Personal to Work apps

@ignore
Scenario: Sharing Across Profiles - Disabled feature control payload
When I create a profile for a platfrom 'AndroidWork' with 'Feature Control' payloads as follows:
    | ProfileName					| DFCOption						| Value		 |
    | Sharing Across Profiles Test	| Sharing Across Profiles		| Disabled   |
Then The profile is created with the properties as specified 
	And Users can only share from Personal to Personal or Work to Work
	And Users cannot share across profiles
