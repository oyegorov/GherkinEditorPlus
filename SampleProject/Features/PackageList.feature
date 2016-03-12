Feature: Retrieving list of packages in the system

Background: 
Given I am a system administrator
Given  Package file is stored at '\\storage\\qaShare\\BDD_IntegrationTests_Data\\AndroidPlusPackage.pcg'
And Execute once per feature STARTED
And  System has packages with properties as follows: 
    | DeviceFamily   | PackagePlatform         | ReferenceId         | PackageName                      | Version |
    | AndroidPlus    | Android                 | autogenerate {guid} | autogenerate Aplus1.{guid}       | 1.0     |
    | AndroidPlus    | Android                 |                     | Aplus1.{guid}                    | 2.0     |
    | AndroidPlus    | All                     | autogenerate {guid} | autogenerate Aplus2.{guid}       |         |
    | AndroidPlus    | Android                 | autogenerate {guid} | autogenerate Aplus3.{guid}       |         |
    | WindowsCE      | All                     | autogenerate {guid} | autogenerate WinCe.{guid}        |         |
    | WindowsCE      | WindowsCE               | autogenerate {guid} | autogenerate WinCe2.{guid}       |         |
    | WindowsCE      | AllWindowsMobile        | autogenerate {guid} | autogenerate WinMobileAll.{guid} |         |
    | WindowsCE      | WindowsMobile           | autogenerate {guid} | autogenerate WinMobile.{guid}    |         |
    | WindowsCE      | WindowsMobileSmartPhone | autogenerate {guid} | autogenerate WinSP.{guid}        |         |
    | WindowsDesktop | WindowsDesktop          | autogenerate {guid} | autogenerate Win7x64.{guid}      |         |
    | WindowsDesktop | WindowsDesktop          | autogenerate {guid} | autogenerate Win7x32.{guid}      |         |
    | Printer        | Printer                 | autogenerate {guid} | autogenerate Zebra.{guid}        |         |
    | Printer        | Printer                 | autogenerate {guid} | autogenerate SOTI.{guid}         |         |
And Execute once per feature ENDED

Scenario Outline: Get list of packages in the system using DeviceFamily and PackageName filters
    When I make a call to public API to get a list of packages with request properties as follows:
    | DeviceFamily   | Name          | OrderInfo.By | OrderInfo.Descending |
    | <DeviceFamily> | <PackageName> | <OrderBy>    | <Descending>         |
    Then List of packages contains only the correct packages

Examples:
    | DeviceFamily   | PackageName      | OrderBy | Descending |
    | All            | {null}           | {null}  | {null}     |
    | AndroidPlus    | {null}           | {null}  | {null}     |
    | WindowsCE      | {null}           | {null}  | {null}     |
    | WindowsDesktop | {null}           | {null}  | {null}     |
    | Printer        | {null}           | {null}  | {null}     |
    | AndroidPlus    | Aplus3.{guid}    | {null}  | {null}     |
    | WindowsCE      | WinCe.{guid}     | {null}  | {null}     |
    | WindowsDesktop | Win7x32.{guid}   | {null}  | {null}     |
    | Printer        | SOTI.{guid}      | {null}  | {null}     |
    | All            | Aplus2.{guid}    | {null}  | {null}     |
    | All            | WinMobile.{guid} | {null}  | {null}     |
    | All            | Win7x64.{guid}   | {null}  | {null}     |
    | All            | Zebra.{guid}     | {null}  | {null}     |
    | AndroidPlus    | {null}           | Name    | true       |
    | WindowsCE      | {null}           | Name    | false      |
    | WindowsCE      | Win              | Name    | true       |
    | All            | Aplus            | Name    | false      |
    | All            | 2.               | Name    | true       |

# Note: PackageName in search can be full or partial