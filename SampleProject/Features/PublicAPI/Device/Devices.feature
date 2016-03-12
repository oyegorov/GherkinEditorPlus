Feature: Devices 
	Operation related management of devices 

Background:
Given I am a client of Public API with name 'ApiClient' and secret 'ClientSecret'
	And I make calls to Public API on behalf of user 'Administrator' with password '1'

Scenario: Get all Devices 
Given I am a user with name 'Administrator' and password '1'
And I enrolled Ios Device with properties as follows:
	| DeviceName                     | RuleName           | LdapConnection | LdapUserName | LdapUserPassword | DeviceId          |
	| autogenerate deviceId01.{guid} | {iosrule_soti.net} | {soti.net}     | testuser2    | Bonjour321       | deviceId01.{guid} |

When I invoke GET on Devices with following properties:
| DeviceId   |
| {null}     |
Then Public API response includes the following devices:
 | Kind   | ComplianceStatus | DeviceId         |
 | iOS    | true             |deviceId01.{guid} |


Scenario: Return No devices when take is more than available devices 
Given I am a user with name 'Administrator' and password '1'
And I enrolled Ios Device with properties as follows:
	| DeviceName                     | RuleName | LdapConnection | LdapUserName | LdapUserPassword | DeviceId |
	| autogenerate deviceId02.{guid} |  {iosrule_soti.net}        | {soti.net}     | testuser2    | Bonjour321       | deviceId02.{guid} |
When I invoke GET on Devices with properties as follows:
    | path   | skip | take | order  | filter | userFilter |
    | {null} | 20   | 100  | {null} | {null} | {null} |
Then Public API response Contains No Devices


Scenario: Get devices by deviceId
Given I am a user with name 'Administrator' and password '1'
And I enrolled Ios Device with properties as follows:
	| DeviceName                     | RuleName           | LdapConnection | LdapUserName | LdapUserPassword | DeviceId          |
	| autogenerate deviceId03.{guid} | {iosrule_soti.net} | {soti.net}     | testuser2    | Bonjour321       | deviceId03.{guid} |
When I invoke GET on Devices with following properties:
         | DeviceId          |
         | deviceId03.{guid} |
Then Public API response contains the following device:
 | Kind   | ComplianceStatus | DeviceId         |
 | iOS    | true             |deviceId03.{guid} |

Scenario Outline: Get devices with legal filters
Given I am a user with name 'Administrator' and password '1'
And I have created a device group with properties as follows:
         | Name                                  | Kind    | Icon   | Path                         |
         | autogenerate devicegroup_empty.{guid} | Regular | Yellow | \\\\devicegroup_empty.{guid} |
When I invoke GET on Devices with properties as follows:
    | path   | skip   | take   | order   | filter   | userFilter   |
    | <path> | <skip> | <take> | <order> | <filter> | <userFilter> |
Then Public API response Contains No Devices
Examples:
    | path                         | skip | take | order  | filter                              | userFilter |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | AfwProfileDisabled:true             | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | AfwProvisionStage:NotApplicable     | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | KnoxAttestationStatus:Nonexisting   | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | KnoxCapability:NotSupported         | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | AvailableExternalStorage:0          | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | AvailableMemory:0                   | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | AvailableSDCardStorage:0            | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | AvailableStorage:0                  | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | TotalExternalStorage:0              | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | TotalMemory:0                       | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | TotalSDCardStorage:0                | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | TotalStorage:0                      | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | AgentVersion:Nonexisting            | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | BackupBatteryStatus:0               | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | BatteryStatus:0                     | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | BiosVersion:Nonexisting             | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | CanResetPassword:true               | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | DeviceId:Nonexisting                | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | DeviceName:Nonexisting              | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | ElmStatus:NotSupported              | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | EnrollmentTime:Nonexisting          | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | HardwareSerialNumber:Nonexisting    | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | HardwareVersion:Nonexisting         | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | HostName:Nonexisting                | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | InRoaming:true                      | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | InRoamingSIM2:true                  | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | Ipv6:Nonexisting                    | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | IsOnline:true                       | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | LastCheckInTime:Nonexisting         | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | LastAgentConnectTime:Nonexisting    | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | LastAgentDisconnectTime:Nonexisting | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | MACAddress:Nonexisting              | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | Manufacturer:Nonexisting            | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | Mode:Wiped                          | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | Model:Nonexisting                   | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | OEMVersion:Nonexisting              | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | OSVersion:Nonexisting               | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | PhoneNumber:Nonexisting             | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | PhoneNumberSIM2:Nonexisting         | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | Platform:Unknown                    | {null}     |

Scenario Outline: Get devices with incorrect filters
Given I am a user with name 'Administrator' and password '1'
And I have created a device group with properties as follows:
         | Name                                  | Kind    | Icon   | Path                         |
         | autogenerate devicegroup_empty.{guid} | Regular | Yellow | \\\\devicegroup_empty.{guid} |
When I invoke GET on Devices with properties as follows:
    | path   | skip   | take   | order   | filter   | userFilter   |
    | <path> | <skip> | <take> | <order> | <filter> | <userFilter> |
Then Public API response is 'errorCode: 2'

Examples:
    | path                         | skip | take | order  | filter                               | userFilter |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | AfwProfileDisabled:123               | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | AvailableExternalStorage:OneTwoThree | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | NonexistingProperty:0                | {null}     |

Scenario Outline: Get devices with legal user filters from empty device group
Given I am a user with name 'Administrator' and password '1'
And I have created a device group with properties as follows:
         | Name                                  | Kind    | Icon   | Path                         |
         | autogenerate devicegroup_empty.{guid} | Regular | Yellow | \\\\devicegroup_empty.{guid} |
When I invoke GET on Devices with properties as follows:
    | path   | skip   | take   | order   | filter   | userFilter   |
    | <path> | <skip> | <take> | <order> | <filter> | <userFilter> |
Then Public API response Contains No Devices

Examples:
    | path                         | skip | take | order  | filter | userFilter    |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | {null} | UserName:Name |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | {null} | UserId:Id     |

Scenario Outline: Get devices with incorrect user filters
Given I am a user with name 'Administrator' and password '1'
And I have created a device group with properties as follows:
         | Name                                  | Kind    | Icon   | Path                         |
         | autogenerate devicegroup_empty.{guid} | Regular | Yellow | \\\\devicegroup_empty.{guid} |
When I invoke GET on Devices with properties as follows:
    | path   | skip   | take   | order   | filter   | userFilter   |
    | <path> | <skip> | <take> | <order> | <filter> | <userFilter> |
Then Public API response is 'errorCode: 2'

Examples:
    | path                         | skip | take | order  | filter | userFilter             |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | {null} | Nonexisting:Dummy      |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | {null} | BadFilter:123          |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | {null} | {null} | DeviceName:Nonexisting |

Scenario Outline: Get devices with incorrect sort criteria
Given I am a user with name 'Administrator' and password '1'
And I have created a device group with properties as follows:
         | Name                                  | Kind    | Icon   | Path                         |
         | autogenerate devicegroup_empty.{guid} | Regular | Yellow | \\\\devicegroup_empty.{guid} |
When I invoke GET on Devices with properties as follows:
    | path   | skip   | take   | order   | filter   | userFilter   |
    | <path> | <skip> | <take> | <order> | <filter> | <userFilter> |
Then Public API response is 'errorCode: 2'

Examples:
    | path                         | skip | take | order   | filter | userFilter |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | Olshser | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | Yegoole | {null} | {null}     |
    

Scenario Outline: Get devices with legal sort criteria
Given I am a user with name 'Administrator' and password '1'
And I have created a device group with properties as follows:
         | Name                                  | Kind    | Icon   | Path                         |
         | autogenerate devicegroup_empty.{guid} | Regular | Yellow | \\\\devicegroup_empty.{guid} |
When I invoke GET on Devices with properties as follows:
    | path   | skip   | take   | order   | filter   | userFilter |
    | <path> | <skip> | <take> | <order> | <filter> | <filter>   |
Then Public API response Contains No Devices

Examples:
    | path                         | skip | take | order                          | filter | userFilter |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | AfwProfileDisabled             | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | AfwProvisionStage              | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | AntivirusDefinitionsVersion    | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | LastEmptyQuarantine            | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | LastVirusDefUpdate             | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | LastVirusScan                  | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | IntegrityServiceBaselineStatus | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | KnoxAttestationCapability      | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | KnoxAttestationStatus          | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | KnoxCapability                 | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | AvailableExternalStorage       | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | AvailableMemory                | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | AvailableSDCardStorage         | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | AvailableStorage               | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | TotalExternalStorage           | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | TotalMemory                    | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | TotalSDCardStorage             | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | TotalStorage                   | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | AgentVersion                   | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | BackupBatteryStatus            | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | BatteryStatus                  | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | BiosVersion                    | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | BluetoothMACAddress            | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | BuildVersion                   | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | CanResetPassword               | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | CarrierSettingsVersion         | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | CellularCarrier                | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | CellularSignalStrength         | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | CellularTechnology             | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | CpuId                          | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | CurrentMCC                     | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | CurrentMNC                     | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | DataRoamingEnabled             | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | DeviceId                       | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | DeviceName                     | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | ElmStatus                      | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | EnrollmentTime                 | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | HardwareEncryptionCaps         | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | HardwareSerialNumber           | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | HardwareVersion                | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | HostName                       | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | ICCID                          | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | InRoaming                      | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | InRoamingSIM2                  | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | Ipv6                           | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | IsDeviceLocatorServiceEnabled  | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | IsDoNotDisturbInEffect         | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | IsITunesStoreAccountActive     | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | IsOnline                       | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | IsPersonalHotspotEnabled       | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | IsSupervised                   | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | LastCheckInTime                | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | LastAgentConnectTime           | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | LastAgentDisconnectTime        | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | LastStatusUpdate               | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | MACAddress                     | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | Manufacturer                   | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | ManufacturerSerialNumber       | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | Mode                           | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | Model                          | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | ModemFirmwareVersion           | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | NetworkBSSID                   | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | NetworkSSID                    | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | OEMVersion                     | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | OSVersion                      | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | PersonalizedName               | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | PhoneNumber                    | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | PhoneNumberSIM2                | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | Platform                       | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | ProductName                    | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | RadioVersion                   | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | IsOSSecure                     | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | IMEI_MEID_ESN                  | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | IMEI_MEID_ESN_SIM2             | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | SIMCarrierNetwork              | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | SubscriberMCC                  | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | SubscriberMNC                  | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | SubscriberNumber               | {null} | {null}     |
    | \\\\devicegroup_empty.{guid} | 0    | 0    | SubscriberNumberSIM2           | {null} | {null}     |
	
Scenario: Move device to Another group
Given I am a user with name 'Administrator' and password '1'
And I enrolled Ios Device with properties as follows:
	| DeviceName                     | RuleName           | LdapConnection | LdapUserName | LdapUserPassword | DeviceId          |
	| autogenerate deviceId04.{guid} | {iosrule_soti.net} | {soti.net}     | testuser2    | Bonjour321       | deviceId04.{guid} |
And I have created a device group with properties as follows:
         | Name                              | Kind    | Icon   | Path                     |
         | autogenerate devicegroup_1.{guid} | Regular | Yellow | \\\\devicegroup_1.{guid} |
When I invoke PUT on device with deviceId 'deviceId04.{guid}' and properties as follows:
| NewPath                  |
| \\\\devicegroup_1.{guid} |
When I invoke GET on Devices with properties as follows:
| path                     | skip   | take   | order  | filter | userFilter |
| \\\\devicegroup_1.{guid} | {null} | {null} | {null} | {null} | {null}     |
Then Public API response includes the following devices:
 | Kind   | ComplianceStatus | DeviceId         |
 | iOS    | true             |deviceId04.{guid} |


Scenario: Collect data from device
Given I am a user with name 'Administrator' and password '1'
And I enrolled Ios Device with properties as follows:
	| DeviceName                     | RuleName           | LdapConnection | LdapUserName | LdapUserPassword | DeviceId          | OSVersion |
	| autogenerate deviceId05.{guid} | {iosrule_soti.net} | {soti.net}     | testuser2    | Bonjour321       | deviceId05.{guid} | 9.0       |
When I invoke GET on device with deviceId 'deviceId05.{guid}' and properties as follows:
| startDate  | endDate    | builtInDataType        |
| 2015-10-15 | 2040-10-15 | OperatingSystemVersion |
Then Public API response is 'OK'


Scenario Outline: Get devices with user name filter
Given I am a user with name 'Administrator' and password '1'
And I enrolled Ios Device with properties as follows:
	| DeviceName             | RuleName           | LdapConnection | LdapUserName | LdapUserPassword | DeviceId    |
	| autogenerate gg.{guid} | {iosrule_soti.net} | {soti.net}     | testuser2    | Bonjour321       | autogenerate d666.{guid} |
When I invoke GET on Devices with properties as follows:
    | path   | skip   | take   | order   | filter   | userFilter   |
    | <path> | <skip> | <take> | <order> | <filter> | <userFilter> |
Then Public API response includes the following devices:
 | Kind | ComplianceStatus | DeviceId    |
 | iOS  | true             | d666.{guid} |
Examples:
    | path   | skip | take | order  | filter | userFilter         |
    | {null} | 0    | 0    | {null} | {null} | UserName:testuser2 |

Scenario: Setting and resetting string custom attribute
Given I am a user with name 'Administrator' and password '1'
And I have the following custom attribute types:
 | Name        | Type    | EnumValues    |
 | StringType  | String  | {null}        |
 | NumericType | Numeric | {null}        |
 | BoolType    | Bool    | {null}        |
 | DateType    | Date    | {null}        |
 | EnumType    | Enum    | One,Two,Three |
And I enrolled Ios Device with properties as follows:
	| DeviceName             | RuleName           | LdapConnection | LdapUserName | LdapUserPassword | DeviceId    |
	| autogenerate gg.{guid} | {iosrule_soti.net} | {soti.net}     | testuser2    | Bonjour321       | autogenerate chudo.{guid} |
When I set the following custom attribute values for device 'chudo.{guid}' as follows:
	| Name        | Value  |
	| StringType  | MyStringValue |
When I get custom attributes for the device:
	| DeviceId    |
	| chudo.{guid} |
Then Response contains the following custom attribute values:
	| Name        | Value  |
	| StringType  | MyStringValue |
	| NumericType | {null} |
	| BoolType    | {null} |
	| DateType    | {null} |
	| EnumType    | {null} |
When I set the following custom attribute values for device 'chudo.{guid}' as follows:
	| Name        | Value  |
	| StringType  | UpdatedStringValue |
When I get custom attributes for the device:
	| DeviceId    |
	| chudo.{guid} |
Then Response contains the following custom attribute values:
	| Name        | Value  |
	| StringType  | UpdatedStringValue |
	| NumericType | {null} |
	| BoolType    | {null} |
	| DateType    | {null} |
	| EnumType    | {null} |
When I set the following custom attribute values for device 'chudo.{guid}' as follows:
	| Name        | Value  |
	| StringType  | {null} |
When I get custom attributes for the device:
	| DeviceId    |
	| chudo.{guid} |
Then Response contains the following custom attribute values:
	| Name        | Value  |
	| StringType  | {null} |
	| NumericType | {null} |
	| BoolType    | {null} |
	| DateType    | {null} |
	| EnumType    | {null} |

Scenario: Setting and resetting integer custom attribute
Given I am a user with name 'Administrator' and password '1'
And I have the following custom attribute types:
 | Name        | Type    | EnumValues    |
 | StringType  | String  | {null}        |
 | NumericType | Numeric | {null}        |
 | BoolType    | Bool    | {null}        |
 | DateType    | Date    | {null}        |
 | EnumType    | Enum    | One,Two,Three |
And I enrolled Ios Device with properties as follows:
	| DeviceName             | RuleName           | LdapConnection | LdapUserName | LdapUserPassword | DeviceId    |
	| autogenerate gg.{guid} | {iosrule_soti.net} | {soti.net}     | testuser2    | Bonjour321       | autogenerate chudo.{guid} |
When I set the following custom attribute values for device 'chudo.{guid}' as follows:
	| Name        | Value  |
	| NumericType  | 666 |
When I get custom attributes for the device:
	| DeviceId    |
	| chudo.{guid} |
Then Response contains the following custom attribute values:
	| Name        | Value  |
	| StringType  | {null} |
	| NumericType | 666    |
	| BoolType    | {null} |
	| DateType    | {null} |
	| EnumType    | {null} |
When I set the following custom attribute values for device 'chudo.{guid}' as follows:
	| Name        | Value |
	| NumericType | 777   |
When I get custom attributes for the device:
	| DeviceId     |
	| chudo.{guid} |
Then Response contains the following custom attribute values:
	| Name        | Value  |
	| StringType  | {null} |
	| NumericType | 777    |
	| BoolType    | {null} |
	| DateType    | {null} |
	| EnumType    | {null} |
When I set the following custom attribute values for device 'chudo.{guid}' as follows:
	| Name        | Value  |
	| NumericType  | {null} |
When I get custom attributes for the device:
	| DeviceId     |
	| chudo.{guid} |
Then Response contains the following custom attribute values:
	| Name        | Value  |
	| StringType  | {null} |
	| NumericType | {null} |
	| BoolType    | {null} |
	| DateType    | {null} |
	| EnumType    | {null} |
When I set the following custom attribute values for device 'chudo.{guid}' as follows:
	| Name        | Value         |
	| NumericType | invalid_value |
Then Public API response is 'errorCode: 2056'

Scenario: Setting and resetting boolean custom attribute
Given I am a user with name 'Administrator' and password '1'
And I have the following custom attribute types:
 | Name        | Type    | EnumValues    |
 | StringType  | String  | {null}        |
 | NumericType | Numeric | {null}        |
 | BoolType    | Bool    | {null}        |
 | DateType    | Date    | {null}        |
 | EnumType    | Enum    | One,Two,Three |
And I enrolled Ios Device with properties as follows:
	| DeviceName             | RuleName           | LdapConnection | LdapUserName | LdapUserPassword | DeviceId    |
	| autogenerate gg.{guid} | {iosrule_soti.net} | {soti.net}     | testuser2    | Bonjour321       | autogenerate chudo.{guid} |
When I set the following custom attribute values for device 'chudo.{guid}' as follows:
	| Name     | Value |
	| BoolType | true  |
When I get custom attributes for the device:
	| DeviceId    |
	| chudo.{guid} |
Then Response contains the following custom attribute values:
	| Name        | Value  |
	| StringType  | {null} |
	| NumericType | {null} |
	| BoolType    | true   |
	| DateType    | {null} |
	| EnumType    | {null} |
When I set the following custom attribute values for device 'chudo.{guid}' as follows:
	| Name     | Value |
	| BoolType | false |
When I get custom attributes for the device:
	| DeviceId     |
	| chudo.{guid} |
Then Response contains the following custom attribute values:
	| Name        | Value  |
	| StringType  | {null} |
	| NumericType | {null} |
	| BoolType    | false  |
	| DateType    | {null} |
	| EnumType    | {null} |
When I set the following custom attribute values for device 'chudo.{guid}' as follows:
	| Name     | Value  |
	| BoolType | {null} |
When I get custom attributes for the device:
	| DeviceId     |
	| chudo.{guid} |
Then Response contains the following custom attribute values:
	| Name        | Value  |
	| StringType  | {null} |
	| NumericType | {null} |
	| BoolType    | {null} |
	| DateType    | {null} |
	| EnumType    | {null} |
When I set the following custom attribute values for device 'chudo.{guid}' as follows:
	| Name        | Value         |
	| NumericType | invalid_value |
Then Public API response is 'errorCode: 2056'

Scenario: Setting and resetting date custom attribute
Given I am a user with name 'Administrator' and password '1'
And I have the following custom attribute types:
 | Name        | Type    | EnumValues    |
 | StringType  | String  | {null}        |
 | NumericType | Numeric | {null}        |
 | BoolType    | Bool    | {null}        |
 | DateType    | Date    | {null}        |
 | EnumType    | Enum    | One,Two,Three |
And I enrolled Ios Device with properties as follows:
	| DeviceName             | RuleName           | LdapConnection | LdapUserName | LdapUserPassword | DeviceId    |
	| autogenerate gg.{guid} | {iosrule_soti.net} | {soti.net}     | testuser2    | Bonjour321       | autogenerate chudo.{guid} |
When I set the following custom attribute values for device 'chudo.{guid}' as follows:
	| Name     | Value |
	| DateType | 2011-11-11  |
When I get custom attributes for the device:
	| DeviceId    |
	| chudo.{guid} |
Then Response contains the following custom attribute values:
	| Name        | Value      |
	| StringType  | {null}     |
	| NumericType | {null}     |
	| BoolType    | {null}     |
	| DateType    | 2011-11-11 |
	| EnumType    | {null}     |
When I set the following custom attribute values for device 'chudo.{guid}' as follows:
	| Name     | Value |
	| DateType | 2012-12-12 |
When I get custom attributes for the device:
	| DeviceId     |
	| chudo.{guid} |
Then Response contains the following custom attribute values:
	| Name        | Value      |
	| StringType  | {null}     |
	| NumericType | {null}     |
	| BoolType    | {null}     |
	| DateType    | 2012-12-12 |
	| EnumType    | {null}     |
When I set the following custom attribute values for device 'chudo.{guid}' as follows:
	| Name     | Value  |
	| DateType | {null} |
When I get custom attributes for the device:
	| DeviceId     |
	| chudo.{guid} |
Then Response contains the following custom attribute values:
	| Name        | Value  |
	| StringType  | {null} |
	| NumericType | {null} |
	| BoolType    | {null} |
	| DateType    | {null} |
	| EnumType    | {null} |
When I set the following custom attribute values for device 'chudo.{guid}' as follows:
	| Name        | Value         |
	| NumericType | invalid_value |
Then Public API response is 'errorCode: 2056'

Scenario: Setting and resetting enum custom attribute
Given I am a user with name 'Administrator' and password '1'
And I have the following custom attribute types:
 | Name        | Type    | EnumValues    |
 | StringType  | String  | {null}        |
 | NumericType | Numeric | {null}        |
 | BoolType    | Bool    | {null}        |
 | DateType    | Date    | {null}        |
 | EnumType    | Enum    | One,Two,Three |
And I enrolled Ios Device with properties as follows:
	| DeviceName             | RuleName           | LdapConnection | LdapUserName | LdapUserPassword | DeviceId    |
	| autogenerate gg.{guid} | {iosrule_soti.net} | {soti.net}     | testuser2    | Bonjour321       | autogenerate chudo.{guid} |
When I set the following custom attribute values for device 'chudo.{guid}' as follows:
	| Name     | Value |
	| EnumType | One |
When I get custom attributes for the device:
	| DeviceId    |
	| chudo.{guid} |
Then Response contains the following custom attribute values:
	| Name        | Value  |
	| StringType  | {null} |
	| NumericType | {null} |
	| BoolType    | {null} |
	| DateType    | {null} |
	| EnumType    | One    |
When I set the following custom attribute values for device 'chudo.{guid}' as follows:
	| Name     | Value |
	| EnumType | Two   |
When I get custom attributes for the device:
	| DeviceId     |
	| chudo.{guid} |
Then Response contains the following custom attribute values:
	| Name        | Value  |
	| StringType  | {null} |
	| NumericType | {null} |
	| BoolType    | {null} |
	| DateType    | {null} |
	| EnumType    | Two    |
When I set the following custom attribute values for device 'chudo.{guid}' as follows:
	| Name     | Value  |
	| EnumType | {null} |
When I get custom attributes for the device:
	| DeviceId     |
	| chudo.{guid} |
Then Response contains the following custom attribute values:
	| Name        | Value  |
	| StringType  | {null} |
	| NumericType | {null} |
	| BoolType    | {null} |
	| DateType    | {null} |
	| EnumType    | {null} |
When I set the following custom attribute values for device 'chudo.{guid}' as follows:
	| Name        | Value         |
	| NumericType | invalid_value |
Then Public API response is 'errorCode: 2056'

Scenario: Set nonexisting custom attribute
Given I am a user with name 'Administrator' and password '1'
And I enrolled Ios Device with properties as follows:
	| DeviceName             | RuleName           | LdapConnection | LdapUserName | LdapUserPassword | DeviceId    |
	| autogenerate gg.{guid} | {iosrule_soti.net} | {soti.net}     | testuser2    | Bonjour321       | autogenerate chudo.{guid} |
When I set the following custom attribute values for device 'chudo.{guid}' as follows:
	| Name       | Value |
	| NonexistingType | One   |
Then Public API response is 'errorCode: 2055'