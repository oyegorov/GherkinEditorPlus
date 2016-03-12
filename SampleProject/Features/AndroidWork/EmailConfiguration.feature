@ignore
Feature: EmailConfiguration
    In order to enforce my organization's email security policy on provisioned phones
    As an Administrator
    I want to configure s/mime options for the email app
    And I want to set maximum attachment size and want to enabling/disabling Tasks

Background:
Given I am a user with the name 'Administrator' and password '1'
    And I have created an Android+ add device rule as follows:
    | Name                         | DeviceFamily | TargetGroups | Priority |
    | autogenerate {guid}.RuleName | AndroidPlus  | \\My Company | Normal   |
    And I have enrolled an AfW device configured as follows:
    | AddDeviceRuleName | DeviceId                     |
    | {guid}.RuleName   | autogenerate {guid}.DeviceId |
    And I have uploaded the following certificates as <'CertificateId'> from <'FilePath'>' with password '<Password>':
    | CertificateId                             | FilePath                                                | Password    |
    | autogenerate {guid}.SigningCertificate    | \..\TestsData\\exch2PassIsWelcome1234.pfx               | Welcome1234 |
    | autogenerate {guid}.EncryptionCertificate | \..\Tests_Data\\exch2PassIsWelcome1234p12ForAndroid.p12 | Welcome1234 |

# Scenario for Email configuration with S/mime certificates
@ignore
Scenario: Create a profile with an email configuration containing s/mime certificates
Given I started creation of a profile with properties:
| Platform    | Type        | Name                            |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName |
	And I added a Certificates payload as follows:
	| CertificateId       |
	| {guid}.Certificate1 |
	And I added Email Configuration palyload as follows:
	| Account Name                    | Server      | Enable S/MIME | Signing Certificate       | Encryption Certificate       |
	| autogenerate {guid}.AccountName | sotidev.com | true          | {guid}.SigningCertificate | {guid}.EncryptionCertificate |
	And I saved the profile
When I assign the profiles as follows:
| ProfileName        | TargetDevice    | TargetGroup |
| {guid}.ProfileName | {guid}.DeviceId |             |
Then The status of the profile is as follows:
| ProfileName        | DeviceId        | ProfileStatus |
| {guid}.ProfileName | {guid}.DeviceId | Installed     |
	And values of the Email Configurations are as follows
	| Account Name                    | Server      | Enable S/MIME | Signing Certificate       | Encryption Certificate       |
	| autogenerate {guid}.AccountName | sotidev.com | true          | {guid}.SigningCertificate | {guid}.EncryptionCertificate |


# Scenario for Email configuration containing Maximum attachement size
@Ignore
Scenario: Create and assign a profile with an email configuration containing Maximum attachment size payload
Given I started creation of a profile with properties:
| Platform    | Type        | Name                            |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName |
	And I added Email Configuration payload as follows:
	| Account Name                    | Server      | MaximumAttachmentSize |
	| autogenerate {guid}.AccountName | sotidev.com | 1024                  |
	And I saved the profile
When I assign the profiles as follows:
| ProfileName        | TargetDevice    | TargetGroup |
| {guid}.ProfileName | {guid}.DeviceId |             |
Then The status of the profile is as follows:
| ProfileName        | DeviceId        | ProfileStatus |
| {guid}.ProfileName | {guid}.DeviceId | Installed     |
	And values of the Email Configurations are as follows
	| Account Name                    | Server      | MaximumAttachmentSize |
	| autogenerate {guid}.AccountName | sotidev.com | 1024                  |


# Scenarios for Email configuration containing Enable Task
@Ignore
Scenario: Create and assign a profile with an email configuration payload containing Enable Tasks set to True
Given I started creation of a profile with properties:
| Platform    | Type        | Name                            |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName |
	And I added Email Configuration payload as follows:
	| Account Name                    | Server      | EnableTasks |
	| autogenerate {guid}.AccountName | sotidev.com | True        |
	And I saved the profile
When I assign the profiles as follows:
	| ProfileName        | TargetDevice    | TargetGroup |
	| {guid}.ProfileName | {guid}.DeviceId |             |
Then The status of the profile is as follows:
| ProfileName        | DeviceId        | ProfileStatus |
| {guid}.ProfileName | {guid}.DeviceId | Installed     |
	And values of the Email Configurations are as follows
	| Account Name                    | Server      | EnableTasks |
	| autogenerate {guid}.AccountName | sotidev.com | True        |

@Ignore
Scenario: Create and assign a profile with an email configuration payload containing Enable Tasks set to False
Given I started creation of a profile with properties:
| Platform    | Type        | Name                            |
| AndroidPlus | AndroidWork | autogenerate {guid}.ProfileName |
	And I added Email Configuration payload as follows:
	| Account Name                    | Server      | EnableTasks |
	| autogenerate {guid}.AccountName | sotidev.com | False       |
	And I saved the profile
When I assign the profiles as follows:
	| ProfileName        | TargetDevice    | TargetGroup |
	| {guid}.ProfileName | {guid}.DeviceId |             |
Then The status of the profile is as follows:
| ProfileName        | DeviceId        | ProfileStatus |
| {guid}.ProfileName | {guid}.DeviceId | Installed     |
	And values of the Email Configurations are as follows
	| Account Name                    | Server      | EnableTasks |
	| autogenerate {guid}.AccountName | sotidev.com | False       |
