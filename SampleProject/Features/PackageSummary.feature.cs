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
    [NUnit.Framework.DescriptionAttribute("Retrieving package summary/details")]
    public partial class RetrievingPackageSummaryDetailsFeature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "PackageSummary.feature"
#line hidden
        
        [NUnit.Framework.TestFixtureSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "Retrieving package summary/details", "", ProgrammingLanguage.CSharp, ((string[])(null)));
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
#line 3
#line 4
    testRunner.Given("I am a system administrator", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Given ");
#line 5
    testRunner.Given("Package file is stored at \'\\\\storage\\\\qaShare\\\\BDD_IntegrationTests_Data\\\\Android" +
                    "PlusPackage.pcg\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Given ");
#line hidden
            TechTalk.SpecFlow.Table table1 = new TechTalk.SpecFlow.Table(new string[] {
                        "DeviceFamily",
                        "PackagePlatform",
                        "ReferenceId",
                        "PackageName",
                        "Version"});
            table1.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "autogenerate refId1.{guid}",
                        "autogenerate Aplus1.{guid}",
                        "1.0"});
            table1.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "refId1.{guid}",
                        "Aplus1.{guid}",
                        "2.0"});
            table1.AddRow(new string[] {
                        "AndroidPlus",
                        "All",
                        "autogenerate refId2.{guid}",
                        "autogenerate Aplus2.{guid}",
                        "3.0"});
#line 6
    testRunner.And("System has packages with properties as follows:", ((string)(null)), table1, "And ");
#line hidden
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Get package summary for a given package")]
        [NUnit.Framework.TestCaseAttribute("refId1.{guid}", "Aplus1.{guid}", "2", null)]
        [NUnit.Framework.TestCaseAttribute("refId2.{guid}", "Aplus2.{guid}", "1", null)]
        public virtual void GetPackageSummaryForAGivenPackage(string referenceId, string packageName, string totalVersions, string[] exampleTags)
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Get package summary for a given package", exampleTags);
#line 12
this.ScenarioSetup(scenarioInfo);
#line 3
this.FeatureBackground();
#line 13
 testRunner.When(string.Format("I make a call to public API to get package summary for a package with reference I" +
                        "D {0}", referenceId), ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
            TechTalk.SpecFlow.Table table2 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "TotalVersions"});
            table2.AddRow(new string[] {
                        string.Format("{0}", packageName),
                        string.Format("{0}", totalVersions)});
#line 14
 testRunner.Then("Resulting response contains information as follows:", ((string)(null)), table2, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Get package summary for non-existent package")]
        [NUnit.Framework.TestCaseAttribute("WrongReferenceId", null)]
        [NUnit.Framework.TestCaseAttribute("autogenerate {guid}", null)]
        public virtual void GetPackageSummaryForNon_ExistentPackage(string referenceId, string[] exampleTags)
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Get package summary for non-existent package", exampleTags);
#line 23
this.ScenarioSetup(scenarioInfo);
#line 3
this.FeatureBackground();
#line 24
 testRunner.When(string.Format("I make a call to public API to get package summary for a package with reference I" +
                        "D {0}", referenceId), ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 25
 testRunner.Then("Resulting package summary response is empty", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Get package summary with wrong request parameter")]
        public virtual void GetPackageSummaryWithWrongRequestParameter()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Get package summary with wrong request parameter", ((string[])(null)));
#line 31
this.ScenarioSetup(scenarioInfo);
#line 3
this.FeatureBackground();
#line 32
 testRunner.When("I make a call to public API to get package summary for a package with null refere" +
                    "nce ID", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line 33
 testRunner.Then("Server reports BusinessLogicException with error code \'2\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Get details for a given version of a package")]
        [NUnit.Framework.TestCaseAttribute("refId1.{guid}", "Aplus1.{guid}", "2.0", null)]
        [NUnit.Framework.TestCaseAttribute("refId2.{guid}", "Aplus2.{guid}", "3.0", null)]
        public virtual void GetDetailsForAGivenVersionOfAPackage(string referenceId, string packageName, string version, string[] exampleTags)
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Get details for a given version of a package", exampleTags);
#line 36
this.ScenarioSetup(scenarioInfo);
#line 3
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table3 = new TechTalk.SpecFlow.Table(new string[] {
                        "ReferenceId",
                        "Version"});
            table3.AddRow(new string[] {
                        string.Format("{0}", referenceId),
                        string.Format("{0}", version)});
#line 37
 testRunner.When("I make a call to public API to get package version details for following package " +
                    "versions:", ((string)(null)), table3, "When ");
#line hidden
            TechTalk.SpecFlow.Table table4 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Version"});
            table4.AddRow(new string[] {
                        string.Format("{0}", packageName),
                        string.Format("{0}", version)});
#line 40
 testRunner.Then("Resulting package version details response contains infromation as follows:", ((string)(null)), table4, "Then ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Get details for non-existent package or package version")]
        [NUnit.Framework.TestCaseAttribute("WrongReferenceId", "2.0", null)]
        [NUnit.Framework.TestCaseAttribute("refId2.{guid}", "1.0", null)]
        [NUnit.Framework.TestCaseAttribute("autogenerate {guid}", "7", null)]
        public virtual void GetDetailsForNon_ExistentPackageOrPackageVersion(string referenceId, string version, string[] exampleTags)
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Get details for non-existent package or package version", exampleTags);
#line 48
this.ScenarioSetup(scenarioInfo);
#line 3
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table5 = new TechTalk.SpecFlow.Table(new string[] {
                        "ReferenceId",
                        "Version"});
            table5.AddRow(new string[] {
                        string.Format("{0}", referenceId),
                        string.Format("{0}", version)});
#line 49
 testRunner.When("I make a call to public API to get package version details for following package " +
                    "versions:", ((string)(null)), table5, "When ");
#line 52
 testRunner.Then("Resulting package version details response is empty", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
