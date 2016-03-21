@CleanDevices
Feature: GetDeviceList

Background:
	Given I am a user with name 'Administrator' and password '1'
	And Execute once per feature STARTED
	And I have added device groups as follows:
		| GroupPath                         |
		| autogenerate \\\\devGroup1.{guid} |
		| autogenerate \\\\devGroup2.{guid} |
		#| autogenerate \\\\devGroup2.{guid}\\\\devGroup4.{time} |
	And I have enabled LDAP integration for LDAP connection '{sotiqa}'
	And I have created principals as follows:
		| PrincipalType       | Name    | DisplayName | DomainName | LdapConnectionName | MemberOf                   |
		| ActiveDirectoryUser | SSPUser | SSP1        | SOTIQA     | {sotiqa}           | MobiControl Administrators |
	And I have enrolled Ios Devices with properties as follows (execute once):
		| DeviceName                         | RuleName                 | LdapConnection | LdapUserName | LdapUserPassword | TargetGroup          | DeviceId                       |
		| autogenerate IosSimulator01.{guid} | autogenerate Rule1{guid} | {sotiqa}       | SSPUser      | Welcome1234      | \\\\devGroup1.{guid} | autogenerate deviceId01.{guid} |
		| autogenerate IosSimulator02.{guid} | Rule1{guid}              | {sotiqa}       | SSPUser      | Welcome1234      | \\\\devGroup1.{guid} | autogenerate deviceId02.{guid} |
		| autogenerate IosSimulator03.{guid} | Rule1{guid}              | {sotiqa}       | SSPUser      | Welcome1234      | \\\\devGroup1.{guid} | autogenerate deviceId03.{guid} |
		| autogenerate IosSimulator04.{guid} | Rule1{guid}              | {sotiqa}       | SSPUser      | Welcome1234      | \\\\devGroup1.{guid} | autogenerate deviceId04.{guid} |
		| autogenerate IosSimulator05.{guid} | Rule1{guid}              | {sotiqa}       | SSPUser      | Welcome1234      | \\\\devGroup1.{guid} | autogenerate deviceId05.{guid} |
		| autogenerate IosSimulator06.{guid} | autogenerate Rule2{guid} | {soti.net}     | testuser2    | Bonjour321       | \\\\devGroup2.{guid} | autogenerate deviceId06.{guid} |
		| autogenerate IosSimulator07.{guid} | Rule2{guid}              | {soti.net}     | testuser2    | Bonjour321       | \\\\devGroup2.{guid} | autogenerate deviceId07.{guid} |
		| autogenerate IosSimulator08.{guid} | Rule2{guid}              | {soti.net}     | testuser2    | Bonjour321       | \\\\devGroup2.{guid} | autogenerate deviceId08.{guid} |
		| autogenerate IosSimulator09.{guid} | Rule2{guid}              | {soti.net}     | testuser2    | Bonjour321       | \\\\devGroup2.{guid} | autogenerate deviceId09.{guid} |
		| autogenerate IosSimulator10.{guid} | Rule2{guid}              | {soti.net}     | testuser2    | Bonjour321       | \\\\devGroup2.{guid} | autogenerate deviceId10.{guid} |
  And Execute once per feature ENDED 

@CarryOverScenarioContext
Scenario: Calling WC version for device group - get all devices from this group
	Given  I am a user with name 'Administrator' and password '1'
	When I call Public API function DeviceInformation/GetDeviceList using request with properties as follows:
	| Path                 | PaginationArgs.Start | PaginationArgs.Limit | FilterInfo | OrderInfos                                                               |
	| \\\\devGroup1.{guid} | 1                    | 10                   | {null}     | [{"By": "DeviceName", "Descending": false, "PropertyType": "Property" }] |
	Then Public API response is 'OK'
	And Last call to DeviceInformation/GetDeviceList has resulted in the following list of devices:
	| ClassTypeName | DeviceName            |
	| DeviceIos     | IosSimulator01.{guid} |
	| DeviceIos     | IosSimulator02.{guid} |
	| DeviceIos     | IosSimulator03.{guid} |
	| DeviceIos     | IosSimulator04.{guid} |
	| DeviceIos     | IosSimulator05.{guid} |

@CarryOverScenarioContext
Scenario: Calling WC version for another device group - get all devices from this group
	Given  I am a user with name 'Administrator' and password '1'
	When I call Public API function DeviceInformation/GetDeviceList using request with properties as follows:
	| Path                 | PaginationArgs.Start | PaginationArgs.Limit | FilterInfo | OrderInfos                                                               |
	| \\\\devGroup2.{guid} | 1                    | 10                   | {null}     | [{"By": "DeviceName", "Descending": false, "PropertyType": "Property" }] |
	Then Public API response is 'OK'
	And Last call to DeviceInformation/GetDeviceList has resulted in the following list of devices:
	| ClassTypeName | DeviceName            |
	| DeviceIos     | IosSimulator06.{guid} |
	| DeviceIos     | IosSimulator07.{guid} |
	| DeviceIos     | IosSimulator08.{guid} |
	| DeviceIos     | IosSimulator09.{guid} |
	| DeviceIos     | IosSimulator10.{guid} |

@ignore
@CarryOverScenarioContext
Scenario: Calling WC version for child group inside Root group - get all devices from this group
	Given  I am a user with name 'Administrator' and password '1'
	When I call Public API function DeviceInformation/GetDeviceList using request with properties as follows:
	| Path                                     | PaginationArgs.Start | PaginationArgs.Limit | FilterInfo | OrderInfos                                                               |
	| \\\\devGroup2.{guid}\\\\devGroup4.{time} | 1                    | 10                   | {null}     | [{"By": "DeviceName", "Descending": false, "PropertyType": "Property" }] |
	Then Public API response is 'OK'
	And Last call to DeviceInformation/GetDeviceList has resulted in the following list of devices:
	| ClassTypeName | DeviceName            |
	| DeviceIos     | IosSimulator11.{guid} |
	

@ignore
@CarryOverScenarioContext
Scenario: Calling WC version with no group - get all devices from all group with view permission
	Given  I am a user with name 'Administrator' and password '1'
	When I call Public API function DeviceInformation/GetDeviceList using request with properties as follows:
	| Path               | PaginationArgs.Start | PaginationArgs.Limit | FilterInfo | OrderInfos                                                               |
	| null               | 1                    | 10                   | {null}     | [{"By": "DeviceName", "Descending": false, "PropertyType": "Property" }] |
	Then Public API response is 'OK'
	And Last call to DeviceInformation/GetDeviceList has resulted in the following list of devices:
	| ClassTypeName | DeviceName            |
	| DeviceIos     | IosSimulator01.{guid} |
	| DeviceIos     | IosSimulator02.{guid} |
	| DeviceIos     | IosSimulator03.{guid} |
	| DeviceIos     | IosSimulator04.{guid} |
	| DeviceIos     | IosSimulator05.{guid} |
    | DeviceIos     | IosSimulator06.{guid} |
	| DeviceIos     | IosSimulator07.{guid} |
	| DeviceIos     | IosSimulator08.{guid} |
	| DeviceIos     | IosSimulator09.{guid} |
	| DeviceIos     | IosSimulator10.{guid} |

@CarryOverScenarioContext
Scenario: Calling WC version for device group with paging - only devices for current page returned
	Given  I am a user with name 'Administrator' and password '1'
	When I call Public API function DeviceInformation/GetDeviceList using request with properties as follows:
	| Path                 | PaginationArgs.Start | PaginationArgs.Limit | FilterInfo | OrderInfos                                                               |
	| \\\\devGroup1.{guid} | 1                    | 2                    | {null}     | [{"By": "DeviceName", "Descending": false, "PropertyType": "Property" }] |
	Then Public API response is 'OK'
	And Last call to DeviceInformation/GetDeviceList has resulted in the following list of devices:
	| ClassTypeName | DeviceName            |
	| DeviceIos     | IosSimulator01.{guid} |
	| DeviceIos     | IosSimulator02.{guid} |

@CarryOverScenarioContext
Scenario: Calling WC version for device group with paging 2 - only devices for current page returned
	Given  I am a user with name 'Administrator' and password '1'
	When I call Public API function DeviceInformation/GetDeviceList using request with properties as follows:
	| Path                 | PaginationArgs.Start | PaginationArgs.Limit | FilterInfo | OrderInfos                                                               |
	| \\\\devGroup1.{guid} | 2                    | 2                    |            | [{"By": "DeviceName", "Descending": false, "PropertyType": "Property" }] |
	Then Public API response is 'OK'
	And Last call to DeviceInformation/GetDeviceList has resulted in the following list of devices:
	| ClassTypeName | DeviceName            |
	| DeviceIos     | IosSimulator03.{guid} |
	| DeviceIos     | IosSimulator04.{guid} |

@CarryOverScenarioContext
Scenario: Calling SSP version as Administrator - unauthorized
	Given  I am a user with name 'Administrator' and password '1'
	When I call Public API function DeviceInformation/GetDeviceListSSP using request with properties as follows:
	| OrderInfos                                                               |
	| [{"By": "DeviceName", "Descending": false, "PropertyType": "Property" }] |
	Then Public API response is 'Unauthorized access'

@CarryOverScenarioContext
Scenario: Calling SSP version as SSPUser with permission - all user devices returned
	Given I am a user with name 'Administrator' and password '1'
	And I have granted principal 'SSPUser' the permissions as follows:
		| SecurityRole | PermissionType | PermissionName   | IsAllowed   |
		| DeviceOwner  | Feature        | LoginSSP         | true        |
	And I am a user with name 'SSPUser' and password 'Welcome1234' and role 'ssp'
	When I call Public API function DeviceInformation/GetDeviceListSSP using request with properties as follows:
	| OrderInfos                                                               |
	| [{"By": "DeviceName", "Descending": false, "PropertyType": "Property" }] |
	Then Public API response is 'OK'
	And Last call to DeviceInformation/GetDeviceList has resulted in the following list of devices:
	| ClassTypeName | DeviceName            |
	| DeviceIos     | IosSimulator01.{guid} |
	| DeviceIos     | IosSimulator02.{guid} |
	| DeviceIos     | IosSimulator03.{guid} |
	| DeviceIos     | IosSimulator04.{guid} |
	| DeviceIos     | IosSimulator05.{guid} |

@CarryOverScenarioContext
Scenario: Calling SSP version as SSP user and PropertyType as label - all user devices returned
	Given I am a user with name 'Administrator' and password '1'
	And I have granted principal 'SSPUser' the permissions as follows:
		| SecurityRole | PermissionType | PermissionName   | IsAllowed   |
		| DeviceOwner  | Feature        | LoginSSP         | true        |
	And I am a user with name 'SSPUser' and password 'Welcome1234' and role 'ssp'
	When I call Public API function DeviceInformation/GetDeviceListSSP using request with properties as follows:
	| OrderInfos                                                            |
	| [{"By": "DeviceName", "Descending": false, "PropertyType": "Label" }] |
	Then Public API response is 'OK'
	And Last call to DeviceInformation/GetDeviceList has resulted in the following list of devices:
	| ClassTypeName | DeviceName            |
	| DeviceIos     | IosSimulator01.{guid} |
	| DeviceIos     | IosSimulator02.{guid} |
	| DeviceIos     | IosSimulator03.{guid} |
	| DeviceIos     | IosSimulator04.{guid} |
	| DeviceIos     | IosSimulator05.{guid} |

@CarryOverScenarioContext
Scenario: Filter Device results with Mac address 
	Given I have enrolled Ios Devices with properties as follows:
	| DeviceName                               | RuleName    | LdapConnection | LdapUserName | LdapUserPassword | TargetGroup          | DeviceId                       | MacAddress                |
	| autogenerate IosSimulatorDevice_1.{guid} | Rule1{guid} | {sotiqa}       | SSPUser      | Welcome1234      | \\\\devGroup1.{guid} | autogenerate deviceId_1.{guid} | autogenerate mac_1.{guid} |
	| autogenerate IosSimulatorDevice_2.{guid} | Rule1{guid} | {sotiqa}       | SSPUser      | Welcome1234      | \\\\devGroup1.{guid} | autogenerate deviceId_2.{guid} | autogenerate mac_2.{guid} |
	And I am a user with name 'SSPUser' and password 'Welcome1234' and role 'ssp'
	When I call Public API function DeviceInformation/GetDeviceListSSP using request with properties as follows:
	| FilterInfo                                                 |
	| [{"Property":{"key":"MACAddress","Value":"mac_1.{guid}"}}] |
	Then Public API response is 'OK'
	And Last call to DeviceInformation/GetDeviceList has resulted in the following list of devices:
	| ClassTypeName | DeviceName                  |
	| DeviceIos     | IosSimulatorDevice_1.{guid} |

	
@CarryOverScenarioContext
Scenario: Filter Device results with DeviceId 
	Given I have enrolled Ios Devices with properties as follows:
	| DeviceName                               | RuleName    | LdapConnection | LdapUserName | LdapUserPassword | TargetGroup        | DeviceId                       | MacAddress                |
	| autogenerate IosSimulatorDevice_1.{guid} | Rule1{guid} | {sotiqa}       | SSPUser      | Welcome1234      | \\\\devGroup1.{guid} | autogenerate deviceId_1.{guid} | autogenerate mac_1.{guid} |
	| autogenerate IosSimulatorDevice_2.{guid} | Rule1{guid} | {sotiqa}       | SSPUser      | Welcome1234      | \\\\devGroup1.{guid} | autogenerate deviceId_2.{guid} | autogenerate mac_2.{guid} |
	And I am a user with name 'SSPUser' and password 'Welcome1234' and role 'ssp'
	When I call Public API function DeviceInformation/GetDeviceListSSP using request with properties as follows:
	| FilterInfo                                                    |
	| [{"Property":{"key":"DeviceId","Value":"deviceId_1.{guid}"}}] |
	Then Public API response is 'OK'
	And Last call to DeviceInformation/GetDeviceList has resulted in the following list of devices:
	| ClassTypeName | DeviceName                  |
	| DeviceIos     | IosSimulatorDevice_1.{guid} |

@ignore
@CarryOverScenarioContext
Scenario: Filter Device results with multiple mac address
	Given I have enrolled Ios Devices with properties as follows:
	| DeviceName                               | RuleName    | LdapConnection | LdapUserName | LdapUserPassword | TargetGroup        | DeviceId                       | MacAddress                |
	| autogenerate IosSimulatorDevice_1.{guid} | Rule1{guid} | {sotiqa}       | SSPUser      | Welcome1234      | \\\\devGroup1.{guid} | autogenerate deviceId_1.{guid} | autogenerate mac_1.{guid} |
	| autogenerate IosSimulatorDevice_2.{guid} | Rule1{guid} | {sotiqa}       | SSPUser      | Welcome1234      | \\\\devGroup1.{guid} | autogenerate deviceId_2.{guid} | autogenerate mac_2.{time} |
	And I am a user with name 'SSPUser' and password 'Welcome1234' and role 'ssp'
	When I call Public API function DeviceInformation/GetDeviceListSSP using request with properties as follows:
	| FilterInfo                                                                                                         |
	| [{"Property":{"key":"MACAddress","Value":"mac_1.{guid}"}},{"Property":{"key":"MACAddress","Value":"mac2.{time}"}}] |
	Then Public API response is 'OK'
	And Last call to DeviceInformation/GetDeviceList has resulted in the following list of devices:
	| ClassTypeName | DeviceName                  |
	| DeviceIos     | IosSimulatorDevice_1.{guid} |
	| DeviceIos     | IosSimulatorDevice_2.{guid} |

@ignore
@CarryOverScenarioContext
Scenario: Filter Device results with either device id or Macaddress
	Given I have enrolled Ios Devices with properties as follows:
	| DeviceName                               | RuleName    | LdapConnection | LdapUserName | LdapUserPassword | TargetGroup        | DeviceId                       | MacAddress               |
	| autogenerate IosSimulatorDevice_1.{guid} | Rule1{guid} | {sotiqa}       | SSPUser      | Welcome1234      | \\\\devGroup1.{guid} | autogenerate deviceId_1.{guid} | autogenerate mac1.{time} |
	| autogenerate IosSimulatorDevice_2.{guid} | Rule1{guid} | {sotiqa}       | SSPUser      | Welcome1234      | \\\\devGroup1.{guid} | autogenerate deviceId_2.{guid} | autogenerate mac2.{guid} |
	
	And I am a user with name 'SSPUser' and password 'Welcome1234' and role 'ssp'
	When I call Public API function DeviceInformation/GetDeviceListSSP using request with properties as follows:
	| FilterInfo                                                                                                            |
	| [{"Property":{"key":"DeviceId","Value":"deviceId_1.{guid}"}},{"Property":{"key":"MACAddress","Value":"mac2.{time}"}}] |
	Then Public API response is 'OK'
	And Last call to DeviceInformation/GetDeviceList has resulted in the following list of devices:
	| ClassTypeName | DeviceName                  |
	| DeviceIos     | IosSimulatorDevice_1.{guid} |
	| DeviceIos     | IosSimulatorDevice_2.{guid} |