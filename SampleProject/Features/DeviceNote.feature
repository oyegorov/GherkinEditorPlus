Feature: Device Note management

Background: 
Given I am a system administrator

Scenario: Add Note to a Device
 Given I enrolled Ios Device with properties as follows:
		| DeviceName                      | RuleName           | LdapConnection | LdapUserName | LdapUserPassword | DeviceId                      |
		| autogenerate device.name.{guid} | {iosrule_soti.net} | {soti.net}     | testuser2    | Bonjour321       | autogenerate device.id.{guid} |
  When I make a call to public API to add device note with request properties as follows:
		| DeviceId         | Icon | Subject | Description              |
		| device.id.{guid} | Red  | Issue   | Device issue description |
  Then Public API response is 'OK'
  When I make a call to retrieve last added device note
  Then Last retrieved device note has properties as follows:
		| Icon | Subject | Description              |
		| Red  | Issue   | Device issue description |

Scenario: Add Note to a Device Group
  When I call Public API function DeviceGroup/Add using request with properties as follows:
        | Name                                  |
        | autogenerate device.group.name.{guid} |
  Then Public API response is 'OK'
  When I make a call to public API to add device group note to the last added device group with request properties as follows:
		| Icon | Subject | Description              |
		| Red  | Issue   | Device issue description |
  Then Public API response is 'OK'
  When I make a call to retrieve last added device note
  Then Last retrieved device note has properties as follows:
		 | Icon  | Subject | Description             |
		 | Red  | Issue   | Device issue description |

Scenario: Edit Device Note
 Given I enrolled Ios Device with properties as follows:
		| DeviceName                      | RuleName           | LdapConnection | LdapUserName | LdapUserPassword | DeviceId                      |
		| autogenerate device.name.{guid} | {iosrule_soti.net} | {soti.net}     | testuser2    | Bonjour321       | autogenerate device.id.{guid} |
 Given I have created device note with properties as follows:
		| DeviceId         | Icon | Subject | Description              |
		| device.id.{guid} | Red  | Issue   | Device issue description |
  When I make a call to public API to edit last added device note with request properties as follows:
		| Icon  | Subject | Description             |
		| Green | Note    | Device note description |
  Then Public API response is 'OK'
  When I make a call to retrieve last added device note
  Then Last retrieved device note has properties as follows:
		| Icon  | Subject | Description             |
		| Green | Note    | Device note description |

Scenario: Delete Device Note
 Given I enrolled Ios Device with properties as follows:
		| DeviceName                      | RuleName           | LdapConnection | LdapUserName | LdapUserPassword | DeviceId                      |
		| autogenerate device.name.{guid} | {iosrule_soti.net} | {soti.net}     | testuser2    | Bonjour321       | autogenerate device.id.{guid} |
 Given I have created device note with properties as follows:
		| DeviceId         | Icon | Subject | Description              |
		| device.id.{guid} | Red  | Issue   | Device issue description |
  When I make a call to public API to delete last added device note
  Then Public API response is 'OK'
  When I make a call to retrieve last added device note
  Then Public API response is 'httpCode:404'