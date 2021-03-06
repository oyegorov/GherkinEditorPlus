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
namespace Soti.MobiControl.Bdd.PublicApiTests.Features.PublicAPI.DeviceGroup
{
    using TechTalk.SpecFlow;
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("TechTalk.SpecFlow", "1.9.0.77")]
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [NUnit.Framework.TestFixtureAttribute()]
    [NUnit.Framework.DescriptionAttribute("Device Group Management")]
    public partial class DeviceGroupManagementFeature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "DeviceGroupManagement.feature"
#line hidden
        
        [NUnit.Framework.TestFixtureSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "Device Group Management", "Operation related management of device groups", ProgrammingLanguage.CSharp, ((string[])(null)));
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
testRunner.Given("I am a client of Public API with name \'ApiClient\' and secret \'ClientSecret\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Given ");
#line 6
 testRunner.And("I make calls to Public API on behalf of user \'Administrator\' with password \'1\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Get All Device Groups")]
        public virtual void GetAllDeviceGroups()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Get All Device Groups", ((string[])(null)));
#line 8
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table1 = new TechTalk.SpecFlow.Table(new string[] {
                        "parentpath"});
            table1.AddRow(new string[] {
                        "{null}"});
#line 9
 testRunner.When("I invoke GET on DeviceGroups with parameters as follows:", ((string)(null)), table1, "When ");
#line 12
 testRunner.Then("Public API response is \'OK\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Get All standard Device Groups")]
        public virtual void GetAllStandardDeviceGroups()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Get All standard Device Groups", ((string[])(null)));
#line 14
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table2 = new TechTalk.SpecFlow.Table(new string[] {
                        "parentpath"});
            table2.AddRow(new string[] {
                        "{null}"});
#line 15
 testRunner.When("I invoke GET on DeviceGroups with parameters as follows:", ((string)(null)), table2, "When ");
#line hidden
            TechTalk.SpecFlow.Table table3 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table3.AddRow(new string[] {
                        "My Company",
                        "Regular",
                        "Yellow",
                        "\\\\My Company"});
            table3.AddRow(new string[] {
                        "Management Devices",
                        "Regular",
                        "Yellow",
                        "\\\\My Company\\Management Devices"});
            table3.AddRow(new string[] {
                        "Sales Devices",
                        "Regular",
                        "Yellow",
                        "\\\\My Company\\Sales Devices"});
            table3.AddRow(new string[] {
                        "Warehouse Devices",
                        "Regular",
                        "Yellow",
                        "\\\\My Company\\Warehouse Devices"});
#line 18
 testRunner.Then("Public API response includes the following device groups:", ((string)(null)), table3, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Creating a Group")]
        public virtual void CreatingAGroup()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Creating a Group", ((string[])(null)));
#line 25
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table4 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table4.AddRow(new string[] {
                        "autogenerate devicegroup1.{guid}",
                        "Regular",
                        "Yellow",
                        "\\\\My Company\\devicegroup1.{guid}"});
#line 26
testRunner.When("I invoke POST on DeviceGroups with properties as follows:", ((string)(null)), table4, "When ");
#line 29
testRunner.Then("Public API response includes the device group with properties as specified", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Getting a device group by path")]
        public virtual void GettingADeviceGroupByPath()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Getting a device group by path", ((string[])(null)));
#line 31
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table5 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table5.AddRow(new string[] {
                        "autogenerate devicegroup2.{guid}",
                        "Regular",
                        "Yellow",
                        "\\\\My Company\\devicegroup2.{guid}"});
#line 32
testRunner.Given("I have created a device group with properties as follows:", ((string)(null)), table5, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table6 = new TechTalk.SpecFlow.Table(new string[] {
                        "parentpath"});
            table6.AddRow(new string[] {
                        "\\\\My Company"});
#line 35
testRunner.When("I invoke GET on DeviceGroups with parameters as follows:", ((string)(null)), table6, "When ");
#line hidden
            TechTalk.SpecFlow.Table table7 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table7.AddRow(new string[] {
                        "devicegroup2.{guid}",
                        "Regular",
                        "Yellow",
                        "\\\\My Company\\devicegroup2.{guid}"});
#line 38
testRunner.Then("Public API response includes the following device groups:", ((string)(null)), table7, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Creating a New Root Group")]
        public virtual void CreatingANewRootGroup()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Creating a New Root Group", ((string[])(null)));
#line 42
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table8 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table8.AddRow(new string[] {
                        "autogenerate devicegroup3.{guid}",
                        "Regular",
                        "Yellow",
                        "\\\\devicegroup3.{guid}"});
#line 43
testRunner.When("I invoke POST on DeviceGroups with properties as follows:", ((string)(null)), table8, "When ");
#line 46
testRunner.Then("Public API response is \'OK\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Getting a New root group created")]
        public virtual void GettingANewRootGroupCreated()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Getting a New root group created", ((string[])(null)));
#line 48
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table9 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table9.AddRow(new string[] {
                        "autogenerate devicegroup4.{guid}",
                        "Regular",
                        "Red",
                        "\\\\devicegroup4.{guid}"});
#line 49
testRunner.Given("I have created a device group with properties as follows:", ((string)(null)), table9, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table10 = new TechTalk.SpecFlow.Table(new string[] {
                        "parentpath"});
            table10.AddRow(new string[] {
                        "{null}"});
#line 52
testRunner.When("I invoke GET on DeviceGroups with parameters as follows:", ((string)(null)), table10, "When ");
#line hidden
            TechTalk.SpecFlow.Table table11 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table11.AddRow(new string[] {
                        "devicegroup4.{guid}",
                        "Regular",
                        "Red",
                        "\\\\devicegroup4.{guid}"});
#line 55
testRunner.Then("Public API response includes the following device groups:", ((string)(null)), table11, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Creating a new Subgroup Inside New root Group")]
        public virtual void CreatingANewSubgroupInsideNewRootGroup()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Creating a new Subgroup Inside New root Group", ((string[])(null)));
#line 59
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table12 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table12.AddRow(new string[] {
                        "autogenerate devicegroup5.{guid}",
                        "Regular",
                        "Yellow",
                        "\\\\devicegroup5.{guid}"});
#line 60
testRunner.Given("I have created a device group with properties as follows:", ((string)(null)), table12, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table13 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table13.AddRow(new string[] {
                        "autogenerate devicegroup6.{time}",
                        "Regular",
                        "Yellow",
                        "\\\\devicegroup5.{guid}\\devicegroup6.{time}"});
#line 63
testRunner.When("I invoke POST on DeviceGroups with properties as follows:", ((string)(null)), table13, "When ");
#line 66
testRunner.Then("Public API response is \'OK\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Getting subgroup inside New Root group")]
        public virtual void GettingSubgroupInsideNewRootGroup()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Getting subgroup inside New Root group", ((string[])(null)));
#line 68
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table14 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table14.AddRow(new string[] {
                        "autogenerate devicegroup6.{guid}",
                        "Regular",
                        "Yellow",
                        "\\\\devicegroup6.{guid}"});
#line 69
testRunner.Given("I have created a device group with properties as follows:", ((string)(null)), table14, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table15 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table15.AddRow(new string[] {
                        "autogenerate devicegroup7.{time}",
                        "Regular",
                        "Yellow",
                        "\\\\devicegroup6.{guid}\\devicegroup7.{time}"});
#line 72
testRunner.And("I have created a device group with properties as follows:", ((string)(null)), table15, "And ");
#line hidden
            TechTalk.SpecFlow.Table table16 = new TechTalk.SpecFlow.Table(new string[] {
                        "parentpath"});
            table16.AddRow(new string[] {
                        "\\\\devicegroup6.{guid}"});
#line 75
testRunner.When("I invoke GET on DeviceGroups with parameters as follows:", ((string)(null)), table16, "When ");
#line hidden
            TechTalk.SpecFlow.Table table17 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table17.AddRow(new string[] {
                        "devicegroup7.{time}",
                        "Regular",
                        "Yellow",
                        "\\\\devicegroup6.{guid}\\devicegroup7.{time}"});
#line 78
testRunner.Then("Public API response includes the following device groups:", ((string)(null)), table17, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Creating a New Virtual Group")]
        public virtual void CreatingANewVirtualGroup()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Creating a New Virtual Group", ((string[])(null)));
#line 82
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table18 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table18.AddRow(new string[] {
                        "autogenerate devicegroup5.{guid}",
                        "Virtual",
                        "Yellow",
                        "\\\\My Company\\devicegroup5.{guid}"});
#line 83
testRunner.When("I invoke POST on DeviceGroups with properties as follows:", ((string)(null)), table18, "When ");
#line 86
testRunner.Then("Public API response is \'OK\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Creating a Green color Device Group")]
        public virtual void CreatingAGreenColorDeviceGroup()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Creating a Green color Device Group", ((string[])(null)));
#line 88
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table19 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table19.AddRow(new string[] {
                        "autogenerate devicegroup8.{guid}",
                        "Regular",
                        "Green",
                        "\\\\My Company\\devicegroup8.{guid}"});
#line 89
testRunner.Given("I have created a device group with properties as follows:", ((string)(null)), table19, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table20 = new TechTalk.SpecFlow.Table(new string[] {
                        "parentpath"});
            table20.AddRow(new string[] {
                        "\\\\My Company"});
#line 92
testRunner.When("I invoke GET on DeviceGroups with parameters as follows:", ((string)(null)), table20, "When ");
#line hidden
            TechTalk.SpecFlow.Table table21 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table21.AddRow(new string[] {
                        "devicegroup8.{guid}",
                        "Regular",
                        "Green",
                        "\\\\My Company\\devicegroup8.{guid}"});
#line 95
testRunner.Then("Public API response includes the following device groups:", ((string)(null)), table21, "Then ");
#line 98
testRunner.And("Public API response is \'OK\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Creating a Group Inside Non existent Group")]
        public virtual void CreatingAGroupInsideNonExistentGroup()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Creating a Group Inside Non existent Group", ((string[])(null)));
#line 100
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table22 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table22.AddRow(new string[] {
                        "autogenerate devicegroup9.{guid}",
                        "Regular",
                        "Yellow",
                        "\\\\No Path\\devicegroup9.{guid}"});
#line 101
testRunner.When("I invoke POST on DeviceGroups with properties as follows:", ((string)(null)), table22, "When ");
#line 104
testRunner.Then("Public API response is \'Unauthorized access\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Creating device group with Special characters in Its name")]
        public virtual void CreatingDeviceGroupWithSpecialCharactersInItsName()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Creating device group with Special characters in Its name", ((string[])(null)));
#line 106
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table23 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table23.AddRow(new string[] {
                        "autogenerate _device&%@9.{guid}",
                        "Regular",
                        "Yellow",
                        "\\\\My Company\\_device&%@9.{guid}"});
#line 107
testRunner.When("I invoke POST on DeviceGroups with properties as follows:", ((string)(null)), table23, "When ");
#line 110
testRunner.Then("Public API response is \'OK\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Creating Root group with space in Name")]
        public virtual void CreatingRootGroupWithSpaceInName()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Creating Root group with space in Name", ((string[])(null)));
#line 112
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table24 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table24.AddRow(new string[] {
                        "autogenerate device Group 10.{guid}",
                        "Regular",
                        "Yellow",
                        "\\\\device Group 10.{guid}"});
#line 113
testRunner.When("I invoke POST on DeviceGroups with properties as follows:", ((string)(null)), table24, "When ");
#line 116
 testRunner.Then("Public API response is \'OK\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Deleting Root Group")]
        public virtual void DeletingRootGroup()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Deleting Root Group", ((string[])(null)));
#line 118
 this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table25 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table25.AddRow(new string[] {
                        "autogenerate devicegroup_12.{guid}",
                        "Regular",
                        "Green",
                        "\\\\devicegroup_12.{guid}"});
#line 119
 testRunner.Given("I have created a device group with properties as follows:", ((string)(null)), table25, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table26 = new TechTalk.SpecFlow.Table(new string[] {
                        "Path"});
            table26.AddRow(new string[] {
                        "\\\\devicegroup_12.{guid}"});
#line 122
testRunner.When("I invoke DELETE on DeviceGroups with properties as follows:", ((string)(null)), table26, "When ");
#line 125
testRunner.Then("Public API response is \'OK\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Deleting root group that has rule Associated with it")]
        public virtual void DeletingRootGroupThatHasRuleAssociatedWithIt()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Deleting root group that has rule Associated with it", ((string[])(null)));
#line 127
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line 128
testRunner.Given("I am a user with name \'Administrator\' and password \'1\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Given ");
#line hidden
            TechTalk.SpecFlow.Table table27 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table27.AddRow(new string[] {
                        "autogenerate devicegroup_13.{guid}",
                        "Regular",
                        "Green",
                        "\\\\devicegroup_13.{guid}"});
#line 129
testRunner.And("I have created a device group with properties as follows:", ((string)(null)), table27, "And ");
#line hidden
            TechTalk.SpecFlow.Table table28 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "DeviceFamily",
                        "TargetGroups",
                        "LdapConnection",
                        "Priority"});
            table28.AddRow(new string[] {
                        "autogenerate {guid}.RuleName",
                        "Ios",
                        "\\\\devicegroup_13.{guid}",
                        "{sotiqa}",
                        "Normal"});
#line 132
testRunner.And("I have created a rule as follows:", ((string)(null)), table28, "And ");
#line hidden
            TechTalk.SpecFlow.Table table29 = new TechTalk.SpecFlow.Table(new string[] {
                        "Path"});
            table29.AddRow(new string[] {
                        "\\\\devicegroup_13.{guid}"});
#line 135
testRunner.When("I invoke DELETE on DeviceGroups with properties as follows:", ((string)(null)), table29, "When ");
#line 138
testRunner.Then("Public API response is \'errorCode: 1902\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Deleting a Root group that has Subgroup")]
        public virtual void DeletingARootGroupThatHasSubgroup()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Deleting a Root group that has Subgroup", ((string[])(null)));
#line 140
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table30 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table30.AddRow(new string[] {
                        "autogenerate devicegroup_20.{guid}",
                        "Regular",
                        "Yellow",
                        "\\\\devicegroup_20.{guid}"});
#line 141
testRunner.Given("I have created a device group with properties as follows:", ((string)(null)), table30, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table31 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table31.AddRow(new string[] {
                        "autogenerate devicegroup1.{time}",
                        "Regular",
                        "Yellow",
                        "\\\\devicegroup_20.{guid}\\devicegroup1.{time}"});
#line 144
testRunner.And("I have created a device group with properties as follows:", ((string)(null)), table31, "And ");
#line hidden
            TechTalk.SpecFlow.Table table32 = new TechTalk.SpecFlow.Table(new string[] {
                        "Path"});
            table32.AddRow(new string[] {
                        "\\\\devicegroup_20.{guid}\\devicegroup1.{time}"});
#line 147
testRunner.When("I invoke DELETE on DeviceGroups with properties as follows:", ((string)(null)), table32, "When ");
#line 150
testRunner.Then("Public API response is \'OK\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Renaming Group")]
        public virtual void RenamingGroup()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Renaming Group", ((string[])(null)));
#line 152
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table33 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table33.AddRow(new string[] {
                        "autogenerate devicegroup_20.{guid}",
                        "Regular",
                        "Yellow",
                        "\\\\devicegroup_20.{guid}"});
#line 153
testRunner.Given("I have created a device group with properties as follows:", ((string)(null)), table33, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table34 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name"});
            table34.AddRow(new string[] {
                        "autogenerate devicegroup_21.{guid}"});
#line 156
testRunner.When("I invoke PUT on DeviceGroups for group \'\\\\devicegroup_20.{guid}\' with properties " +
                    "as following:", ((string)(null)), table34, "When ");
#line 159
testRunner.Then("Public API response is \'OK\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Creating a Group with name not being part of a path")]
        public virtual void CreatingAGroupWithNameNotBeingPartOfAPath()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Creating a Group with name not being part of a path", ((string[])(null)));
#line 161
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table35 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table35.AddRow(new string[] {
                        "autogenerate {guid}",
                        "Regular",
                        "Yellow",
                        "\\\\My Company\\invalidname"});
#line 162
testRunner.When("I invoke POST on DeviceGroups with properties as follows:", ((string)(null)), table35, "When ");
#line 165
testRunner.Then("Public API response is \'errorCode: 1907\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Creating a Group with path that already exists")]
        public virtual void CreatingAGroupWithPathThatAlreadyExists()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Creating a Group with path that already exists", ((string[])(null)));
#line 167
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table36 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table36.AddRow(new string[] {
                        "autogenerate devicegroup_22.{guid}",
                        "Regular",
                        "Yellow",
                        "\\\\devicegroup_22.{guid}"});
#line 168
testRunner.When("I invoke POST on DeviceGroups with properties as follows:", ((string)(null)), table36, "When ");
#line hidden
            TechTalk.SpecFlow.Table table37 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table37.AddRow(new string[] {
                        "devicegroup_22.{guid}",
                        "Regular",
                        "Yellow",
                        "\\\\devicegroup_22.{guid}"});
#line 171
testRunner.And("I invoke POST on DeviceGroups with properties as follows:", ((string)(null)), table37, "And ");
#line 174
testRunner.Then("Public API response is \'errorCode: 1900\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Creating a Group with a virtual parent group")]
        public virtual void CreatingAGroupWithAVirtualParentGroup()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Creating a Group with a virtual parent group", ((string[])(null)));
#line 176
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table38 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "IsVirtual",
                        "Icon"});
            table38.AddRow(new string[] {
                        "autogenerate devicegroup_23.{guid}",
                        "true",
                        "Yellow"});
#line 177
testRunner.Given("I have added device group as follows:", ((string)(null)), table38, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table39 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table39.AddRow(new string[] {
                        "autogenerate devicegroup_24.{time}",
                        "Regular",
                        "Yellow",
                        "\\\\devicegroup_23.{guid}\\devicegroup_24.{time}"});
#line 180
testRunner.When("I invoke POST on DeviceGroups with properties as follows:", ((string)(null)), table39, "When ");
#line 183
testRunner.Then("Public API response is \'errorCode: 1901\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Creating a Group with empty name")]
        public virtual void CreatingAGroupWithEmptyName()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Creating a Group with empty name", ((string[])(null)));
#line 185
this.ScenarioSetup(scenarioInfo);
#line 4
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table40 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Kind",
                        "Icon",
                        "Path"});
            table40.AddRow(new string[] {
                        "{null}",
                        "Regular",
                        "Yellow",
                        "autogenerate \\\\{guid}"});
#line 186
testRunner.When("I invoke POST on DeviceGroups with properties as follows:", ((string)(null)), table40, "When ");
#line 189
testRunner.Then("Public API response is \'errorCode: 0\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
