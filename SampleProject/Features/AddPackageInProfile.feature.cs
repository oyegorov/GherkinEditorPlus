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
    [NUnit.Framework.DescriptionAttribute("Create a profile with package")]
    [NUnit.Framework.CategoryAttribute("Package_via_profile")]
    public partial class CreateAProfileWithPackageFeature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "AddPackageInProfile.feature"
#line hidden
        
        [NUnit.Framework.TestFixtureSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "Create a profile with package", "  Creating a profile with package via public API", ProgrammingLanguage.CSharp, new string[] {
                        "Package_via_profile"});
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
#line 5
#line 6
    testRunner.Given("I am a user with name \'Administrator\' and password \'1\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Given ");
#line 7
    testRunner.Given("Package file is stored at \'\\\\storage\\\\qaShare\\\\BDD_IntegrationTests_Data\\\\Android" +
                    "PlusPackage.pcg\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Given ");
#line hidden
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Create profile with one package")]
        public virtual void CreateProfileWithOnePackage()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Create profile with one package", ((string[])(null)));
#line 9
this.ScenarioSetup(scenarioInfo);
#line 5
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
#line 10
    testRunner.Given("System has packages with properties as follows:", ((string)(null)), table1, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table2 = new TechTalk.SpecFlow.Table(new string[] {
                        "PackageName",
                        "Depends On"});
            table2.AddRow(new string[] {
                        "Aplus1.{guid}",
                        ""});
#line 14
    testRunner.When("I create a profile for a platfrom \'AndroidPlus\' with package payloads as follows", ((string)(null)), table2, "When ");
#line 17
    testRunner.Then("The profile returned via public API with the properties as specified", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Create profile with a package that has dependency")]
        public virtual void CreateProfileWithAPackageThatHasDependency()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Create profile with a package that has dependency", ((string[])(null)));
#line 19
this.ScenarioSetup(scenarioInfo);
#line 5
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table3 = new TechTalk.SpecFlow.Table(new string[] {
                        "DeviceFamily",
                        "PackagePlatform",
                        "ReferenceId",
                        "PackageName"});
            table3.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "autogenerate {guid}",
                        "autogenerate Aplus1.{guid}"});
            table3.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "autogenerate {guid}",
                        "autogenerate Aplus2.{guid}"});
#line 20
    testRunner.Given("System has packages with properties as follows:", ((string)(null)), table3, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table4 = new TechTalk.SpecFlow.Table(new string[] {
                        "PackageName",
                        "Depends On"});
            table4.AddRow(new string[] {
                        "Aplus1.{guid}",
                        "Aplus2.{guid}"});
#line 25
    testRunner.When("I create a profile for a platfrom \'AndroidPlus\' with package payloads as follows", ((string)(null)), table4, "When ");
#line 28
    testRunner.Then("The profile returned via public API with the properties as specified", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Create profile with a package that has dependency on itself")]
        public virtual void CreateProfileWithAPackageThatHasDependencyOnItself()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Create profile with a package that has dependency on itself", ((string[])(null)));
#line 30
this.ScenarioSetup(scenarioInfo);
#line 5
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table5 = new TechTalk.SpecFlow.Table(new string[] {
                        "DeviceFamily",
                        "PackagePlatform",
                        "ReferenceId",
                        "PackageName"});
            table5.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "autogenerate {guid}",
                        "autogenerate Aplus1.{guid}"});
#line 31
    testRunner.Given("System has packages with properties as follows:", ((string)(null)), table5, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table6 = new TechTalk.SpecFlow.Table(new string[] {
                        "PackageName",
                        "Depends On"});
            table6.AddRow(new string[] {
                        "Aplus1.{guid}",
                        "Aplus1.{guid}"});
#line 35
    testRunner.When("I create a profile for a platfrom \'AndroidPlus\' with package payloads as follows", ((string)(null)), table6, "When ");
#line 38
    testRunner.Then("The profile returned via public API must fail with error 140", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Create a profile with simple circular dependency between packages")]
        public virtual void CreateAProfileWithSimpleCircularDependencyBetweenPackages()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Create a profile with simple circular dependency between packages", ((string[])(null)));
#line 40
this.ScenarioSetup(scenarioInfo);
#line 5
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
            table7.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "autogenerate {guid}",
                        "autogenerate Aplus2.{guid}"});
#line 41
    testRunner.Given("System has packages with properties as follows:", ((string)(null)), table7, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table8 = new TechTalk.SpecFlow.Table(new string[] {
                        "PackageName",
                        "Depends On"});
            table8.AddRow(new string[] {
                        "Aplus1.{guid}",
                        "Aplus2.{guid}"});
            table8.AddRow(new string[] {
                        "Aplus2.{guid}",
                        "Aplus1.{guid}"});
#line 46
    testRunner.When("I create a profile for a platfrom \'AndroidPlus\' with package payloads as follows", ((string)(null)), table8, "When ");
#line 50
    testRunner.Then("The profile returned via public API must fail with error 139", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Creating a profile with package for a wrong platfrom")]
        public virtual void CreatingAProfileWithPackageForAWrongPlatfrom()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Creating a profile with package for a wrong platfrom", ((string[])(null)));
#line 52
this.ScenarioSetup(scenarioInfo);
#line 5
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table9 = new TechTalk.SpecFlow.Table(new string[] {
                        "DeviceFamily",
                        "PackagePlatform",
                        "ReferenceId",
                        "PackageName"});
            table9.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "autogenerate {guid}",
                        "autogenerate Aplus1.{guid}"});
#line 53
    testRunner.Given("System has packages with properties as follows:", ((string)(null)), table9, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table10 = new TechTalk.SpecFlow.Table(new string[] {
                        "PackageName",
                        "Depends On"});
            table10.AddRow(new string[] {
                        "Aplus1.{guid}",
                        ""});
#line 57
    testRunner.When("I create a profile for a platfrom \'WindowsCE\' with package payloads as follows", ((string)(null)), table10, "When ");
#line 60
    testRunner.Then("The profile returned via public API must fail with error 141", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Creating a profile with package which depends of a package for a wrong platfrom")]
        public virtual void CreatingAProfileWithPackageWhichDependsOfAPackageForAWrongPlatfrom()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Creating a profile with package which depends of a package for a wrong platfrom", ((string[])(null)));
#line 62
this.ScenarioSetup(scenarioInfo);
#line 5
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
            table11.AddRow(new string[] {
                        "WindowsCE",
                        "WindowsCE",
                        "autogenerate {guid}",
                        "autogenerate wince.{guid}"});
#line 63
    testRunner.Given("System has packages with properties as follows:", ((string)(null)), table11, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table12 = new TechTalk.SpecFlow.Table(new string[] {
                        "PackageName",
                        "Depends On"});
            table12.AddRow(new string[] {
                        "Aplus1.{guid}",
                        "wince.{guid}"});
#line 68
    testRunner.When("I create a profile for a platfrom \'AndroidPlus\' with package payloads as follows", ((string)(null)), table12, "When ");
#line 71
    testRunner.Then("The profile returned via public API must fail with error 142", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Create a profile with circular dependency between packages")]
        public virtual void CreateAProfileWithCircularDependencyBetweenPackages()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Create a profile with circular dependency between packages", ((string[])(null)));
#line 73
this.ScenarioSetup(scenarioInfo);
#line 5
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table13 = new TechTalk.SpecFlow.Table(new string[] {
                        "DeviceFamily",
                        "PackagePlatform",
                        "ReferenceId",
                        "PackageName"});
            table13.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "autogenerate {guid}",
                        "autogenerate Aplus1.{guid}"});
            table13.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "autogenerate {guid}",
                        "autogenerate Aplus2.{guid}"});
            table13.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "autogenerate {guid}",
                        "autogenerate Aplus3.{guid}"});
            table13.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "autogenerate {guid}",
                        "autogenerate Aplus4.{guid}"});
            table13.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "autogenerate {guid}",
                        "autogenerate Aplus5.{guid}"});
#line 74
    testRunner.Given("System has packages with properties as follows:", ((string)(null)), table13, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table14 = new TechTalk.SpecFlow.Table(new string[] {
                        "PackageName",
                        "Depends On"});
            table14.AddRow(new string[] {
                        "Aplus1.{guid}",
                        "Aplus2.{guid}"});
            table14.AddRow(new string[] {
                        "Aplus2.{guid}",
                        "Aplus3.{guid}"});
            table14.AddRow(new string[] {
                        "Aplus3.{guid}",
                        "Aplus4.{guid}"});
            table14.AddRow(new string[] {
                        "Aplus4.{guid}",
                        "Aplus5.{guid}"});
            table14.AddRow(new string[] {
                        "Aplus5.{guid}",
                        "Aplus1.{guid}"});
#line 82
    testRunner.When("I create a profile for a platfrom \'AndroidPlus\' with package payloads as follows", ((string)(null)), table14, "When ");
#line 89
    testRunner.Then("The profile returned via public API must fail with error 139", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Create a profile with packages in given order")]
        public virtual void CreateAProfileWithPackagesInGivenOrder()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Create a profile with packages in given order", ((string[])(null)));
#line 91
this.ScenarioSetup(scenarioInfo);
#line 5
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table15 = new TechTalk.SpecFlow.Table(new string[] {
                        "DeviceFamily",
                        "PackagePlatform",
                        "ReferenceId",
                        "PackageName"});
            table15.AddRow(new string[] {
                        "WindowsCE",
                        "WindowsCE",
                        "autogenerate {guid}",
                        "autogenerate A.{guid}"});
            table15.AddRow(new string[] {
                        "WindowsCE",
                        "WindowsCE",
                        "autogenerate {guid}",
                        "autogenerate B.{guid}"});
            table15.AddRow(new string[] {
                        "WindowsCE",
                        "WindowsCE",
                        "autogenerate {guid}",
                        "autogenerate C.{guid}"});
            table15.AddRow(new string[] {
                        "WindowsCE",
                        "WindowsCE",
                        "autogenerate {guid}",
                        "autogenerate D.{guid}"});
            table15.AddRow(new string[] {
                        "WindowsCE",
                        "WindowsCE",
                        "autogenerate {guid}",
                        "autogenerate E.{guid}"});
#line 92
    testRunner.Given("System has packages with properties as follows:", ((string)(null)), table15, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table16 = new TechTalk.SpecFlow.Table(new string[] {
                        "PackageName",
                        "Depends On"});
            table16.AddRow(new string[] {
                        "A.{guid}",
                        "B.{guid}"});
            table16.AddRow(new string[] {
                        "B.{guid}",
                        "C.{guid}"});
            table16.AddRow(new string[] {
                        "C.{guid}",
                        "E.{guid}"});
            table16.AddRow(new string[] {
                        "D.{guid}",
                        "E.{guid}"});
            table16.AddRow(new string[] {
                        "E.{guid}",
                        ""});
#line 100
    testRunner.When("I create a profile for a platfrom \'WindowsCE\' with package payloads as follows", ((string)(null)), table16, "When ");
#line 107
    testRunner.Then("The profile returned via public API with the properties as specified", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            TechTalk.SpecFlow.Table table17 = new TechTalk.SpecFlow.Table(new string[] {
                        "PackageName"});
            table17.AddRow(new string[] {
                        "A.{guid}"});
            table17.AddRow(new string[] {
                        "B.{guid}"});
            table17.AddRow(new string[] {
                        "C.{guid}"});
            table17.AddRow(new string[] {
                        "D.{guid}"});
            table17.AddRow(new string[] {
                        "E.{guid}"});
#line 108
    testRunner.And("Profile summary returned by public API contains packages in following order", ((string)(null)), table17, "And ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Configure a profile with packages in given order")]
        public virtual void ConfigureAProfileWithPackagesInGivenOrder()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Configure a profile with packages in given order", ((string[])(null)));
#line 116
this.ScenarioSetup(scenarioInfo);
#line 5
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table18 = new TechTalk.SpecFlow.Table(new string[] {
                        "DeviceFamily",
                        "PackagePlatform",
                        "ReferenceId",
                        "PackageName"});
            table18.AddRow(new string[] {
                        "WindowsCE",
                        "WindowsCE",
                        "autogenerate {guid}",
                        "autogenerate A.{guid}"});
            table18.AddRow(new string[] {
                        "WindowsCE",
                        "WindowsCE",
                        "autogenerate {guid}",
                        "autogenerate B.{guid}"});
            table18.AddRow(new string[] {
                        "WindowsCE",
                        "WindowsCE",
                        "autogenerate {guid}",
                        "autogenerate C.{guid}"});
            table18.AddRow(new string[] {
                        "WindowsCE",
                        "WindowsCE",
                        "autogenerate {guid}",
                        "autogenerate D.{guid}"});
            table18.AddRow(new string[] {
                        "WindowsCE",
                        "WindowsCE",
                        "autogenerate {guid}",
                        "autogenerate E.{guid}"});
#line 117
    testRunner.Given("System has packages with properties as follows:", ((string)(null)), table18, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table19 = new TechTalk.SpecFlow.Table(new string[] {
                        "PackageName",
                        "Depends On"});
#line 125
    testRunner.When("I create a profile for a platfrom \'WindowsCE\' with package payloads as follows", ((string)(null)), table19, "When ");
#line hidden
            TechTalk.SpecFlow.Table table20 = new TechTalk.SpecFlow.Table(new string[] {
                        "PackageName",
                        "Depends On"});
            table20.AddRow(new string[] {
                        "A.{guid}",
                        "B.{guid}"});
            table20.AddRow(new string[] {
                        "B.{guid}",
                        "C.{guid}"});
            table20.AddRow(new string[] {
                        "C.{guid}",
                        "E.{guid}"});
            table20.AddRow(new string[] {
                        "D.{guid}",
                        "E.{guid}"});
            table20.AddRow(new string[] {
                        "E.{guid}",
                        ""});
#line 127
    testRunner.And("I configure this profile with package payloads as follows", ((string)(null)), table20, "And ");
#line hidden
            TechTalk.SpecFlow.Table table21 = new TechTalk.SpecFlow.Table(new string[] {
                        "PackageName"});
            table21.AddRow(new string[] {
                        "A.{guid}"});
            table21.AddRow(new string[] {
                        "B.{guid}"});
            table21.AddRow(new string[] {
                        "C.{guid}"});
            table21.AddRow(new string[] {
                        "D.{guid}"});
            table21.AddRow(new string[] {
                        "E.{guid}"});
#line 134
    testRunner.Then("Profile summary returned by public API contains packages in following order", ((string)(null)), table21, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Create and assign profile with a package")]
        public virtual void CreateAndAssignProfileWithAPackage()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Create and assign profile with a package", ((string[])(null)));
#line 142
this.ScenarioSetup(scenarioInfo);
#line 5
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table22 = new TechTalk.SpecFlow.Table(new string[] {
                        "DeviceFamily",
                        "PackagePlatform",
                        "ReferenceId",
                        "PackageName"});
            table22.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "autogenerate {guid}",
                        "autogenerate Aplus1.{guid}"});
#line 143
    testRunner.Given("System has packages with properties as follows:", ((string)(null)), table22, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table23 = new TechTalk.SpecFlow.Table(new string[] {
                        "PackageName",
                        "Depends On"});
            table23.AddRow(new string[] {
                        "Aplus1.{guid}",
                        ""});
#line 147
    testRunner.When("I create a profile for a platfrom \'AndroidPlus\' with package payloads as follows " +
                    "and assign it with default options to path \'\\\\My Company\\Warehouse Devices\'", ((string)(null)), table23, "When ");
#line 150
    testRunner.Then("The profile returned via public API with the properties as specified", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
