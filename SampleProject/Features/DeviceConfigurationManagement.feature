Feature: Device Configuration Management

Background: 
 Given I am a system administrator

Scenario: Adding configuration to a device group
  When I call Public API function DeviceGroup/Add using request with properties as follows:
		| Name                                  |
		| autogenerate device.group.name.{guid} |
  Then Public API response is 'OK'
  When I make a call to Public API GroupService/GetAll
   And I call Public API to apply iOS Update Schedule configuration to device group '\\device.group.name.{guid}' with request properties as follows:
		| DateTime            | Period   |
		| 2016/01/01 10:00:00 | 02:00:00 |
  Then Public API response is 'OK'
  When I call Public API to get iOS Update Schedule configuration applied to device group '\\device.group.name.{guid}'
  Then Public API response is 'OK'
   And iOS Update Schedule configuration has properties as follows:
		| DateTime            | Period   |
		| 2016/01/01 10:00:00 | 02:00:00 |

Scenario: Adding configuration to a device
 Given I enrolled Ios Device with properties as follows:
		| DeviceName                      | RuleName           | LdapConnection | LdapUserName | LdapUserPassword | DeviceId                      |
		| autogenerate device.name.{guid} | {iosrule_soti.net} | {soti.net}     | testuser2    | Bonjour321       | autogenerate device.id.{guid} |
  When I call Public API to apply iOS Update Schedule configuration to device with id 'device.id.{guid}' with request properties as follows:
		| DateTime            | Period   |
		| 2016/01/01 10:00:00 | 02:00:00 |
  Then Public API response is 'OK'
  When I call Public API to get iOS Update Schedule configuration applied to device with id 'device.id.{guid}'
  Then Public API response is 'OK'
   And iOS Update Schedule configuration has properties as follows:
		| DateTime            | Period   |
		| 2016/01/01 10:00:00 | 02:00:00 |

Scenario: Modifying device group configuration
  When I call Public API function DeviceGroup/Add using request with properties as follows:
        | Name                                  |
        | autogenerate device.group.name.{guid} |
  Then Public API response is 'OK'
  When I make a call to Public API GroupService/GetAll
   And I call Public API to apply iOS Update Schedule configuration to device group '\\device.group.name.{guid}' with request properties as follows:
		| DateTime            | Period   |
		| 2016/01/01 10:00:00 | 02:00:00 |
  Then Public API response is 'OK'
  When I call Public API to apply iOS Update Schedule configuration to device group '\\device.group.name.{guid}' with request properties as follows:
		| DateTime            | Period   |
		| 2016/01/01 12:00:00 | 01:00:00 |
  Then Public API response is 'OK'
  When I call Public API to get iOS Update Schedule configuration applied to device group '\\device.group.name.{guid}'
  Then Public API response is 'OK'
   And iOS Update Schedule configuration has properties as follows:
		| DateTime            | Period   |
		| 2016/01/01 12:00:00 | 01:00:00 |

Scenario: Deleting device group configuration
 Given I call Public API function DeviceGroup/Add using request with properties as follows:
        | Name                                    |
        | autogenerate device.group.parent.{guid} |
   And I have added device groups as follows:
		| GroupPath                          |
		| \\device.group.parent.{guid}\child |
  When I make a call to Public API GroupService/GetAll
   And I call Public API to apply iOS Update Schedule configuration to device group '\\device.group.parent.{guid}' with request properties as follows:
		| DateTime            | Period   |
		| 2016/01/01 10:00:00 | 02:00:00 |
  Then Public API response is 'OK'
  When I call Public API to get iOS Update Schedule configuration applied to device group '\\device.group.parent.{guid}\child'
  Then Public API response is 'OK'
   And iOS Update Schedule configuration has properties as follows:
		| DateTime            | Period   |
		| 2016/01/01 10:00:00 | 02:00:00 |
  When I call Public API to apply iOS Update Schedule configuration to device group '\\device.group.parent.{guid}\child' with request properties as follows:
		| DateTime            | Period   |
		| 2016/01/01 12:00:00 | 01:00:00 |
  Then Public API response is 'OK'
  When I call Public API to get iOS Update Schedule configuration applied to device group '\\device.group.parent.{guid}\child'
  Then Public API response is 'OK'
   And iOS Update Schedule configuration has properties as follows:
		| DateTime            | Period   |
		| 2016/01/01 12:00:00 | 01:00:00 |
  When I call Public API to delete iOS Update Schedule configuration applied to device group '\\device.group.parent.{guid}\child'
  Then Public API response is 'OK'
  When I call Public API to get iOS Update Schedule configuration applied to device group '\\device.group.parent.{guid}\child'
  Then Public API response is 'OK'
   And iOS Update Schedule configuration has properties as follows:
		| DateTime            | Period   |
		| 2016/01/01 10:00:00 | 02:00:00 |
