﻿// ------------------------------------------------------------------------------
//  <auto-generated>
//      This code was generated by SpecFlow (http://www.specflow.org/).
//      SpecFlow Version:1.9.0.77
//      SpecFlow Generator Version:1.9.0.0
//      Runtime Version:4.0.30319.42000
// 
//      Changes to this file may cause incorrect behavior and will be lost if
//      the code is regenerated.
//  </auto-generated>
// ------------------------------------------------------------------------------
#region Designer generated code
#pragma warning disable
namespace Soti.MobiControl.Bdd.PublicApiTests.Features
{
    using TechTalk.SpecFlow;
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("TechTalk.SpecFlow", "1.9.0.77")]
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [NUnit.Framework.TestFixtureAttribute()]
    [NUnit.Framework.DescriptionAttribute("Setting profile assignments options")]
    [NUnit.Framework.CategoryAttribute("ProfileManagement")]
    public partial class SettingProfileAssignmentsOptionsFeature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "SpecifyProfileAssignmentOptions.feature"
#line hidden
        
        [NUnit.Framework.TestFixtureSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "Setting profile assignments options", "", ProgrammingLanguage.CSharp, new string[] {
                        "ProfileManagement"});
            testRunner.OnFeatureStart(featureInfo);
        }
        
        [NUnit.Framework.TestFixtureTearDownAttribute()]
        public virtual void FeatureTearDown()
        {
            testRunner.OnFeatureEnd();
            testRunner = null;
        }
        
        [NUnit.Framework.SetUpAttribute()]
        public virtual void TestInitialize()
        {
        }
        
        [NUnit.Framework.TearDownAttribute()]
        public virtual void ScenarioTearDown()
        {
            testRunner.OnScenarioEnd();
        }
        
        public virtual void ScenarioSetup(TechTalk.SpecFlow.ScenarioInfo scenarioInfo)
        {
            testRunner.OnScenarioStart(scenarioInfo);
        }
        
        public virtual void ScenarioCleanup()
        {
            testRunner.CollectScenarioErrors();
        }
        
        public virtual void FeatureBackground()
        {
#line 4
#line 5
    testRunner.Given("I am a system administrator", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Given ");
#line 6
    testRunner.Given("Package file is stored at \'\\\\storage\\qaShare\\BDD_IntegrationTests_Data\\AndroidPlu" +
                    "sPackage.pcg\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Given ");
#line hidden
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Setting package installation schedule for a profile with package payload")]
        [NUnit.Framework.IgnoreAttribute()]
        [NUnit.Framework.CategoryAttribute("Package_via_profile")]
        [NUnit.Framework.CategoryAttribute("[MC14401]")]
        [NUnit.Framework.TestCaseAttribute("UTC,06 July 2015 7:32:47 AM", null)]
        [NUnit.Framework.TestCaseAttribute("15 July 2015 7:32:47 AM", null)]
        [NUnit.Framework.TestCaseAttribute("", null)]
        public virtual void SettingPackageInstallationScheduleForAProfileWithPackagePayload(string dateValue, string[] exampleTags)
        {
            string[] @__tags = new string[] {
                    "Package_via_profile",
                    "[MC14401]",
                    "ignore"};
            if ((exampleTags != null))
            {
                @__tags = System.Linq.Enumerable.ToArray(System.Linq.Enumerable.Concat(@__tags, exampleTags));
            }
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Setting package installation schedule for a profile with package payload", @__tags);
#line 11
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table1 = new TechTalk.SpecFlow.Table(new string[] {
                        "DeviceFamily",
                        "PackagePlatform",
                        "ReferenceId",
                        "PackageName"});
            table1.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "autogenerate {guid}",
                        "autogenerate Aplus1.{guid}"});
            table1.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "autogenerate {guid}",
                        "autogenerate Aplus2.{guid}"});
#line 12
    testRunner.Given("System has packages with properties as follows:", ((string)(null)), table1, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table2 = new TechTalk.SpecFlow.Table(new string[] {
                        "PackageName",
                        "Depends On"});
            table2.AddRow(new string[] {
                        "Aplus1.{guid}",
                        "Aplus2.{guid}"});
#line 17
    testRunner.When("I create a profile for a platfrom \'AndroidPlus\' with package payloads as follows", ((string)(null)), table2, "When ");
#line hidden
            TechTalk.SpecFlow.Table table3 = new TechTalk.SpecFlow.Table(new string[] {
                        "OptionName",
                        "OptionValue"});
            table3.AddRow(new string[] {
                        "InstallationSchedule",
                        string.Format("{0}", dateValue)});
#line 21
    testRunner.And("I assign this profile to path \'\\\\My Company\\Warehouse Devices\' with options as fo" +
                    "llows", ((string)(null)), table3, "And ");
#line hidden
            TechTalk.SpecFlow.Table table4 = new TechTalk.SpecFlow.Table(new string[] {
                        "OptionName",
                        "OptionValue"});
            table4.AddRow(new string[] {
                        "InstallationSchedule",
                        string.Format("{0}", dateValue)});
#line 25
    testRunner.Then("The resulting profile assignment response contains assignment options as follows:" +
                    "", ((string)(null)), table4, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Setting network restriction for a profile with simple payload")]
        [NUnit.Framework.IgnoreAttribute()]
        [NUnit.Framework.TestCaseAttribute("AnyNetwork", "AnyNetwork", null)]
        [NUnit.Framework.TestCaseAttribute("ActiveSync", "ActiveSync", null)]
        [NUnit.Framework.TestCaseAttribute("LAN", "LAN", null)]
        [NUnit.Framework.TestCaseAttribute("WiFi", "WiFi", null)]
        [NUnit.Framework.TestCaseAttribute("Cellular", "Cellular", null)]
        [NUnit.Framework.TestCaseAttribute("Roaming", "Roaming", null)]
        [NUnit.Framework.TestCaseAttribute("", "AnyNetwork", null)]
        public virtual void SettingNetworkRestrictionForAProfileWithSimplePayload(string restrictionValue, string expectedValue, string[] exampleTags)
        {
            string[] @__tags = new string[] {
                    "ignore"};
            if ((exampleTags != null))
            {
                @__tags = System.Linq.Enumerable.ToArray(System.Linq.Enumerable.Concat(@__tags, exampleTags));
            }
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Setting network restriction for a profile with simple payload", @__tags);
#line 36
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line 37
    testRunner.When("I create a profile for a platfrom \'AndroidPlus\' with wifi payload", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
            TechTalk.SpecFlow.Table table5 = new TechTalk.SpecFlow.Table(new string[] {
                        "OptionName",
                        "OptionValue"});
            table5.AddRow(new string[] {
                        "NetworkRestriction",
                        string.Format("{0}", restrictionValue)});
#line 39
    testRunner.And("I assign this profile to path \'\\\\My Company\\Warehouse Devices\' with options as fo" +
                    "llows", ((string)(null)), table5, "And ");
#line hidden
            TechTalk.SpecFlow.Table table6 = new TechTalk.SpecFlow.Table(new string[] {
                        "OptionName",
                        "OptionValue"});
            table6.AddRow(new string[] {
                        "NetworkRestriction",
                        string.Format("{0}", expectedValue)});
#line 43
    testRunner.Then("The resulting profile assignment response contains assignment options as follows:" +
                    "", ((string)(null)), table6, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Setting network restriction for a profile with package payload")]
        [NUnit.Framework.CategoryAttribute("Package_via_profile")]
        [NUnit.Framework.CategoryAttribute("[MC14399]")]
        [NUnit.Framework.TestCaseAttribute("AnyNetwork", "AnyNetwork", null)]
        [NUnit.Framework.TestCaseAttribute("ActiveSync", "ActiveSync", null)]
        [NUnit.Framework.TestCaseAttribute("LAN", "LAN", null)]
        [NUnit.Framework.TestCaseAttribute("WiFi", "WiFi", null)]
        [NUnit.Framework.TestCaseAttribute("Cellular", "Cellular", null)]
        [NUnit.Framework.TestCaseAttribute("Roaming", "Roaming", null)]
        [NUnit.Framework.TestCaseAttribute("", "AnyNetwork", null)]
        public virtual void SettingNetworkRestrictionForAProfileWithPackagePayload(string restrictionValue, string expectedValue, string[] exampleTags)
        {
            string[] @__tags = new string[] {
                    "Package_via_profile",
                    "[MC14399]"};
            if ((exampleTags != null))
            {
                @__tags = System.Linq.Enumerable.ToArray(System.Linq.Enumerable.Concat(@__tags, exampleTags));
            }
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Setting network restriction for a profile with package payload", @__tags);
#line 59
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table7 = new TechTalk.SpecFlow.Table(new string[] {
                        "DeviceFamily",
                        "PackagePlatform",
                        "ReferenceId",
                        "PackageName"});
            table7.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "autogenerate {guid}",
                        "autogenerate Aplus1.{guid}"});
#line 60
    testRunner.Given("System has packages with properties as follows:", ((string)(null)), table7, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table8 = new TechTalk.SpecFlow.Table(new string[] {
                        "PackageName",
                        "Depends On"});
            table8.AddRow(new string[] {
                        "Aplus1.{guid}",
                        ""});
#line 64
    testRunner.When("I create a profile for a platfrom \'AndroidPlus\' with package payloads as follows", ((string)(null)), table8, "When ");
#line hidden
            TechTalk.SpecFlow.Table table9 = new TechTalk.SpecFlow.Table(new string[] {
                        "OptionName",
                        "OptionValue"});
            table9.AddRow(new string[] {
                        "NetworkRestriction",
                        string.Format("{0}", restrictionValue)});
#line 68
    testRunner.And("I assign this profile to path \'\\\\My Company\\Warehouse Devices\' with options as fo" +
                    "llows", ((string)(null)), table9, "And ");
#line hidden
            TechTalk.SpecFlow.Table table10 = new TechTalk.SpecFlow.Table(new string[] {
                        "OptionName",
                        "OptionValue"});
            table10.AddRow(new string[] {
                        "NetworkRestriction",
                        string.Format("{0}", expectedValue)});
#line 72
    testRunner.Then("The resulting profile assignment response contains assignment options as follows:" +
                    "", ((string)(null)), table10, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Setting Force Reinstallation Option for a profile with package payload")]
        [NUnit.Framework.CategoryAttribute("Package_via_profile")]
        [NUnit.Framework.CategoryAttribute("[MC14404]")]
        [NUnit.Framework.TestCaseAttribute("True", "True", null)]
        [NUnit.Framework.TestCaseAttribute("False", "False", null)]
        public virtual void SettingForceReinstallationOptionForAProfileWithPackagePayload(string setValue, string expectedValue, string[] exampleTags)
        {
            string[] @__tags = new string[] {
                    "Package_via_profile",
                    "[MC14404]"};
            if ((exampleTags != null))
            {
                @__tags = System.Linq.Enumerable.ToArray(System.Linq.Enumerable.Concat(@__tags, exampleTags));
            }
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Setting Force Reinstallation Option for a profile with package payload", @__tags);
#line 88
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table11 = new TechTalk.SpecFlow.Table(new string[] {
                        "DeviceFamily",
                        "PackagePlatform",
                        "ReferenceId",
                        "PackageName"});
            table11.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "autogenerate {guid}",
                        "autogenerate Aplus1.{guid}"});
#line 89
    testRunner.Given("System has packages with properties as follows:", ((string)(null)), table11, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table12 = new TechTalk.SpecFlow.Table(new string[] {
                        "PackageName",
                        "Depends On"});
            table12.AddRow(new string[] {
                        "Aplus1.{guid}",
                        ""});
#line 93
    testRunner.When("I create a profile for a platfrom \'AndroidPlus\' with package payloads as follows", ((string)(null)), table12, "When ");
#line hidden
            TechTalk.SpecFlow.Table table13 = new TechTalk.SpecFlow.Table(new string[] {
                        "OptionName",
                        "OptionValue"});
            table13.AddRow(new string[] {
                        "ForceReinstallation",
                        string.Format("{0}", setValue)});
#line 97
    testRunner.And("I assign this profile to path \'\\\\My Company\\Warehouse Devices\' with options as fo" +
                    "llows", ((string)(null)), table13, "And ");
#line hidden
            TechTalk.SpecFlow.Table table14 = new TechTalk.SpecFlow.Table(new string[] {
                        "OptionName",
                        "OptionValue"});
            table14.AddRow(new string[] {
                        "ForceReinstallation",
                        string.Format("{0}", expectedValue)});
#line 101
    testRunner.Then("The resulting profile assignment response contains assignment options as follows:" +
                    "", ((string)(null)), table14, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Setting Package Persistence Option for a profile with package payload")]
        [NUnit.Framework.CategoryAttribute("Package_via_profile")]
        [NUnit.Framework.CategoryAttribute("[MC14402]")]
        [NUnit.Framework.TestCaseAttribute("True", "True", null)]
        [NUnit.Framework.TestCaseAttribute("False", "False", null)]
        public virtual void SettingPackagePersistenceOptionForAProfileWithPackagePayload(string setValue, string expectedValue, string[] exampleTags)
        {
            string[] @__tags = new string[] {
                    "Package_via_profile",
                    "[MC14402]"};
            if ((exampleTags != null))
            {
                @__tags = System.Linq.Enumerable.ToArray(System.Linq.Enumerable.Concat(@__tags, exampleTags));
            }
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Setting Package Persistence Option for a profile with package payload", @__tags);
#line 112
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table15 = new TechTalk.SpecFlow.Table(new string[] {
                        "DeviceFamily",
                        "PackagePlatform",
                        "ReferenceId",
                        "PackageName"});
            table15.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "autogenerate {guid}",
                        "autogenerate Aplus1.{guid}"});
#line 113
    testRunner.Given("System has packages with properties as follows:", ((string)(null)), table15, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table16 = new TechTalk.SpecFlow.Table(new string[] {
                        "PackageName",
                        "Depends On"});
            table16.AddRow(new string[] {
                        "Aplus1.{guid}",
                        ""});
#line 117
    testRunner.When("I create a profile for a platfrom \'AndroidPlus\' with package payloads as follows", ((string)(null)), table16, "When ");
#line hidden
            TechTalk.SpecFlow.Table table17 = new TechTalk.SpecFlow.Table(new string[] {
                        "OptionName",
                        "OptionValue"});
            table17.AddRow(new string[] {
                        "PersistPackages",
                        string.Format("{0}", setValue)});
#line 121
    testRunner.And("I assign this profile to path \'\\\\My Company\\Warehouse Devices\' with options as fo" +
                    "llows", ((string)(null)), table17, "And ");
#line hidden
            TechTalk.SpecFlow.Table table18 = new TechTalk.SpecFlow.Table(new string[] {
                        "OptionName",
                        "OptionValue"});
            table18.AddRow(new string[] {
                        "PersistPackages",
                        string.Format("{0}", expectedValue)});
#line 125
    testRunner.Then("The resulting profile assignment response contains assignment options as follows:" +
                    "", ((string)(null)), table18, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Setting Package Uninstall Upon Revocation Option for a profile with package paylo" +
            "ad")]
        [NUnit.Framework.CategoryAttribute("Package_via_profile")]
        [NUnit.Framework.CategoryAttribute("[MC14403]")]
        [NUnit.Framework.TestCaseAttribute("True", "True", null)]
        [NUnit.Framework.TestCaseAttribute("False", "False", null)]
        public virtual void SettingPackageUninstallUponRevocationOptionForAProfileWithPackagePayload(string setValue, string expectedValue, string[] exampleTags)
        {
            string[] @__tags = new string[] {
                    "Package_via_profile",
                    "[MC14403]"};
            if ((exampleTags != null))
            {
                @__tags = System.Linq.Enumerable.ToArray(System.Linq.Enumerable.Concat(@__tags, exampleTags));
            }
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Setting Package Uninstall Upon Revocation Option for a profile with package paylo" +
                    "ad", @__tags);
#line 136
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table19 = new TechTalk.SpecFlow.Table(new string[] {
                        "DeviceFamily",
                        "PackagePlatform",
                        "ReferenceId",
                        "PackageName"});
            table19.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "autogenerate {guid}",
                        "autogenerate Aplus1.{guid}"});
#line 137
    testRunner.Given("System has packages with properties as follows:", ((string)(null)), table19, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table20 = new TechTalk.SpecFlow.Table(new string[] {
                        "PackageName",
                        "Depends On"});
            table20.AddRow(new string[] {
                        "Aplus1.{guid}",
                        ""});
#line 141
    testRunner.When("I create a profile for a platfrom \'AndroidPlus\' with package payloads as follows", ((string)(null)), table20, "When ");
#line hidden
            TechTalk.SpecFlow.Table table21 = new TechTalk.SpecFlow.Table(new string[] {
                        "OptionName",
                        "OptionValue"});
            table21.AddRow(new string[] {
                        "UninstallUponRevocation",
                        string.Format("{0}", setValue)});
#line 145
    testRunner.And("I assign this profile to path \'\\\\My Company\\Warehouse Devices\' with options as fo" +
                    "llows", ((string)(null)), table21, "And ");
#line hidden
            TechTalk.SpecFlow.Table table22 = new TechTalk.SpecFlow.Table(new string[] {
                        "OptionName",
                        "OptionValue"});
            table22.AddRow(new string[] {
                        "UninstallUponRevocation",
                        string.Format("{0}", expectedValue)});
#line 149
    testRunner.Then("The resulting profile assignment response contains assignment options as follows:" +
                    "", ((string)(null)), table22, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Configuring assigned profile and set Package Uninstall Upon Revocation Option")]
        [NUnit.Framework.CategoryAttribute("Package_via_profile")]
        [NUnit.Framework.CategoryAttribute("[MC14402]")]
        [NUnit.Framework.CategoryAttribute("[MC14403]")]
        [NUnit.Framework.TestCaseAttribute("True", "True", null)]
        [NUnit.Framework.TestCaseAttribute("False", "False", null)]
        public virtual void ConfiguringAssignedProfileAndSetPackageUninstallUponRevocationOption(string setValue, string expectedValue, string[] exampleTags)
        {
            string[] @__tags = new string[] {
                    "Package_via_profile",
                    "[MC14402]",
                    "[MC14403]"};
            if ((exampleTags != null))
            {
                @__tags = System.Linq.Enumerable.ToArray(System.Linq.Enumerable.Concat(@__tags, exampleTags));
            }
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Configuring assigned profile and set Package Uninstall Upon Revocation Option", @__tags);
#line 161
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table23 = new TechTalk.SpecFlow.Table(new string[] {
                        "DeviceFamily",
                        "PackagePlatform",
                        "ReferenceId",
                        "PackageName"});
            table23.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "autogenerate {guid}",
                        "autogenerate Aplus1.{guid}"});
            table23.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "autogenerate {guid}",
                        "autogenerate Aplus2.{guid}"});
#line 162
    testRunner.Given("System has packages with properties as follows:", ((string)(null)), table23, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table24 = new TechTalk.SpecFlow.Table(new string[] {
                        "PackageName",
                        "Depends On"});
            table24.AddRow(new string[] {
                        "Aplus1.{guid}",
                        ""});
#line 167
    testRunner.When("I create a profile for a platfrom \'AndroidPlus\' with package payloads as follows", ((string)(null)), table24, "When ");
#line hidden
            TechTalk.SpecFlow.Table table25 = new TechTalk.SpecFlow.Table(new string[] {
                        "OptionName",
                        "OptionValue"});
            table25.AddRow(new string[] {
                        "PersistPackages",
                        string.Format("{0}", setValue)});
#line 171
    testRunner.And("I assign this profile to path \'\\\\My Company\\Warehouse Devices\' with options as fo" +
                    "llows", ((string)(null)), table25, "And ");
#line hidden
            TechTalk.SpecFlow.Table table26 = new TechTalk.SpecFlow.Table(new string[] {
                        "OptionName",
                        "OptionValue"});
            table26.AddRow(new string[] {
                        "PersistPackages",
                        string.Format("{0}", expectedValue)});
#line 175
    testRunner.Then("The resulting profile assignment response contains assignment options as follows:" +
                    "", ((string)(null)), table26, "Then ");
#line hidden
            TechTalk.SpecFlow.Table table27 = new TechTalk.SpecFlow.Table(new string[] {
                        "PackageName",
                        "Depends On"});
            table27.AddRow(new string[] {
                        "Aplus2.{guid}",
                        ""});
#line 179
    testRunner.When("I configure this profile with package payloads as follows", ((string)(null)), table27, "When ");
#line hidden
            TechTalk.SpecFlow.Table table28 = new TechTalk.SpecFlow.Table(new string[] {
                        "OptionName",
                        "OptionValue"});
            table28.AddRow(new string[] {
                        "UninstallUponRevocation",
                        string.Format("{0}", setValue)});
#line 183
    testRunner.And("I assign this profile to path \'\\\\My Company\\Warehouse Devices\' with options as fo" +
                    "llows", ((string)(null)), table28, "And ");
#line hidden
            TechTalk.SpecFlow.Table table29 = new TechTalk.SpecFlow.Table(new string[] {
                        "OptionName",
                        "OptionValue"});
            table29.AddRow(new string[] {
                        "UninstallUponRevocation",
                        string.Format("{0}", expectedValue)});
#line 187
    testRunner.Then("The resulting profile assignment response contains assignment options as follows:" +
                    "", ((string)(null)), table29, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
