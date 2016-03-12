@ignore
Feature: Android for Work: Boolean device feature control payloads
    In order to control the end user's ability to use a particular device feature,
    as an Administrator I want to install one or more profiles containing respective device feature control (DFC) payloads.
    The purpose of this test is to ensure that the Deployment Server sends the correct data to the Android for Work agent.

Background: 
Given I am a user with the name 'Administrator' and password '1'
    And I have created an Android+ add device rule as follows:
    | Name                         | DeviceFamily | TargetGroups | Priority |
    | autogenerate {guid}.RuleName | AndroidPlus  | \\My Company | Normal   |
    And I have enrolled an AfW device configured as follows:
    | AddDeviceRuleName | DeviceId                     |
    | {guid}.RuleName   | autogenerate {guid}.DeviceId |

@ignore
Scenario Outline: Create and assign one profile containing a DFC payload with the specified restriction set to False
Given I have created a profile with properties:
| Platform    | Type        | Name                            |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName |
    And I have added a DFC payload configured as follows:
    | ProfileName        | RestrictionName    | RestrictionValue |
    | {guid}.ProfileName | <Restriction Name> | False            |
When I assign the profiles as follows:
| ProfileName        | TargetDevice    | TargetGroup |
| {guid}.ProfileName | {guid}.DeviceId |             |
Then The statuses of the profiles are as follows:
| ProfileName        | DeviceId        | ProfileStatus |
| {guid}.ProfileName | {guid}.DeviceId | Installed     |
    And The values of the DFC restrictions are as follows:
    | DeviceId        | RestrictionName    | RestrictionValue |
    | {guid}.DeviceId | <Restriction Name> | False            |

Examples:
| Restriction Name                      |
| DisableAppManagement                  |
| DisableBluetoothContactSharing        |
| DisableBluetoothManagement            |
| DisableCamera                         |
| DisableCertificateManagement          |
| DisableFactoryReset                   |
| DisableFingerprintAuthentication      |
| DisableInstallationFromUnknownSources |
| DisableKeyguardCamera                 |
| DisableLocationSharing                |
| DisableMultiUser                      |
| DisableNetworkSettingsReset           |
| DisableOutgoingCalls                  |
| DisableOutgoingNfc                    |
| DisableSdCard                         |
| DisableSms                            |
| DisableStatusBar                      |
| DisableTetheringManagement            |
| DisableThirdPartyInputMethods         |
| DisableVpnManagement                  |
| DisableWifiManagement                 |
| RedactNotifications                   |

@ignore
Scenario Outline: Create and assign one profile containing a DFC payload with the specified restriction set to True
Given I have created a profile with properties:
| Platform    | Type        | Name                            |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName |
    And I have added a DFC payload configured as follows:
    | ProfileName        | RestrictionName    | RestrictionValue |
    | {guid}.ProfileName | <Restriction Name> | True             |
When I assign the profiles as follows:
| ProfileName        | TargetDevice    | TargetGroup |
| {guid}.ProfileName | {guid}.DeviceId |             |
Then The statuses of the profiles are as follows:
| ProfileName        | DeviceId        | ProfileStatus |
| {guid}.ProfileName | {guid}.DeviceId | Installed     |
    And The values of the DFC restrictions are as follows:
    | DeviceId        | RestrictionName    | RestrictionValue |
    | {guid}.DeviceId | <Restriction Name> | True             |

Examples:
| Restriction Name                      |
| DisableAppManagement                  |
| DisableBluetoothContactSharing        |
| DisableBluetoothManagement            |
| DisableCamera                         |
| DisableCertificateManagement          |
| DisableFactoryReset                   |
| DisableFingerprintAuthentication      |
| DisableInstallationFromUnknownSources |
| DisableKeyguardCamera                 |
| DisableLocationSharing                |
| DisableMultiUser                      |
| DisableNetworkSettingsReset           |
| DisableOutgoingCalls                  |
| DisableOutgoingNfc                    |
| DisableSdCard                         |
| DisableSms                            |
| DisableStatusBar                      |
| DisableTetheringManagement            |
| DisableThirdPartyInputMethods         |
| DisableVpnManagement                  |
| DisableWifiManagement                 |
| RedactNotifications                   |

@ignore
Scenario Outline: Create and assign two profiles containing conflicting DFC payloads with the specified restrictions set to False and True
Given I have created a profile with properties:
| Platform    | Type        | Name                             |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName1 |
    And I have added a DFC payload configured as follows:
    | ProfileName         | RestrictionName    | RestrictionValue |
    | {guid}.ProfileName1 | <Restriction Name> | False            |
    # ---
    And I have created a profile with properties:
    | Platform    | Type        | Name                             |
    | AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName2 |
    And I have added a DFC payload configured as follows:
    | ProfileName         | RestrictionName    | RestrictionValue |
    | {guid}.ProfileName2 | <Restriction Name> | True             |
When I assign the profiles as follows:
| ProfileName         | TargetDevice    | TargetGroup |
| {guid}.ProfileName1 | {guid}.DeviceId |             |
| {guid}.ProfileName2 | {guid}.DeviceId |             |
Then The statuses of the profiles are as follows:
| ProfileName         | DeviceId        | ProfileStatus |
| {guid}.ProfileName1 | {guid}.DeviceId | Installed     |
| {guid}.ProfileName2 | {guid}.DeviceId | Installed     |
    And The values of the DFC restrictions are as follows:
    | DeviceId        | RestrictionName    | RestrictionValue |
    | {guid}.DeviceId | <Restriction Name> | True             |

Examples:
| Restriction Name                      |
| DisableAppManagement                  |
| DisableBluetoothContactSharing        |
| DisableBluetoothManagement            |
| DisableCamera                         |
| DisableCertificateManagement          |
| DisableFactoryReset                   |
| DisableFingerprintAuthentication      |
| DisableInstallationFromUnknownSources |
| DisableKeyguardCamera                 |
| DisableLocationSharing                |
| DisableMultiUser                      |
| DisableNetworkSettingsReset           |
| DisableOutgoingCalls                  |
| DisableOutgoingNfc                    |
| DisableSdCard                         |
| DisableSms                            |
| DisableStatusBar                      |
| DisableTetheringManagement            |
| DisableThirdPartyInputMethods         |
| DisableVpnManagement                  |
| DisableWifiManagement                 |
| RedactNotifications                   |
