Feature: AddDeviceRule creation
	In order to enroll a device
	As an administrator
	I want to create an AddDeviceRule

Scenario: Create iOS AddDeviceRule
Given I am a user with name 'Administrator' and password '1'
    And I uploaded an APNS certificate from 'file:\\storage\\qaShare\\BDD_IntegrationTests_Data\\iOS_Certificate.pfx ' with password '123456'
    And I have configured LDAP connection as follows:
    | Name                               | Server        | UserName  | Password   | Base DN                |
    | autogenerate {guid}.LdapConnection | corp.soti.net | testuser2 | Bonjour321 | DC=corp,DC=soti,DC=net |
When I make a call to public API to create a rule with request properties as follows:
    | Name                         | DeviceFamily | TargetGroups   | LdapConnection        | Priority |
    | autogenerate {guid}.RuleName | Ios          | \\\\My Company | {guid}.LdapConnection | Normal   |
Then The rule is created with properties as specified


Scenario: Create Android Plus AddDeviceRule with SkipSkipCreateGoogleAccount property set
Given I am a user with name 'Administrator' and password '1'
    And I created an AfW rule as follows:
	 | Name                         | DeviceFamily | TargetGroups   | LdapConnection | Priority | SkipCreateGoogleAccount |
	 | autogenerate {guid}.RuleName | AndroidPlus  | \\\\My Company | {null}         | Normal   | true                    |

When I call Public API function SendMessage using request with properties as follows:
         | DeviceIdentity.Id | DeviceIdentity.DevicePropertyIdType | Message |
         | autogenerate {guid}.DeviceId   | 0                      | Message |
Then Device receives ConfigMessage with following context:
         | SkipCreateGoogleAccount | DeviceIdentity.DevicePropertyIdType | Message |
         | true                    | 0                                   | Message |

  
Scenario: Create Android Plus AddDeviceRule with SkipSkipCreateGoogleAccount property clear
Given I am a user with name 'Administrator' and password '1'
    And I created an AfW rule as follows:
	 | Name                         | DeviceFamily | TargetGroups   | LdapConnection | Priority | SkipCreateGoogleAccount |
	 | autogenerate {guid}.RuleName | AndroidPlus  | \\\\My Company | {null}         | Normal   | false                   |

When I call Public API function SendMessage using request with properties as follows:
         | DeviceIdentity.Id | DeviceIdentity.DevicePropertyIdType | Message |
         | autogenerate {guid}.DeviceId   | 0                      | Message |
Then Device receives ConfigMessage with following context:
         | SkipCreateGoogleAccount | DeviceIdentity.DevicePropertyIdType | Message |
         | false                   | 0                                   | Message |
