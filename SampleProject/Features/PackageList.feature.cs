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
    [NUnit.Framework.DescriptionAttribute("Retrieving list of packages in the system")]
    public partial class RetrievingListOfPackagesInTheSystemFeature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "PackageList.feature"
#line hidden
        
        [NUnit.Framework.TestFixtureSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "Retrieving list of packages in the system", "", ProgrammingLanguage.CSharp, ((string[])(null)));
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
#line 6
testRunner.And("Execute once per feature STARTED", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
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
                        "autogenerate {guid}",
                        "autogenerate Aplus1.{guid}",
                        "1.0"});
            table1.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "",
                        "Aplus1.{guid}",
                        "2.0"});
            table1.AddRow(new string[] {
                        "AndroidPlus",
                        "All",
                        "autogenerate {guid}",
                        "autogenerate Aplus2.{guid}",
                        ""});
            table1.AddRow(new string[] {
                        "AndroidPlus",
                        "Android",
                        "autogenerate {guid}",
                        "autogenerate Aplus3.{guid}",
                        ""});
            table1.AddRow(new string[] {
                        "WindowsCE",
                        "All",
                        "autogenerate {guid}",
                        "autogenerate WinCe.{guid}",
                        ""});
            table1.AddRow(new string[] {
                        "WindowsCE",
                        "WindowsCE",
                        "autogenerate {guid}",
                        "autogenerate WinCe2.{guid}",
                        ""});
            table1.AddRow(new string[] {
                        "WindowsCE",
                        "AllWindowsMobile",
                        "autogenerate {guid}",
                        "autogenerate WinMobileAll.{guid}",
                        ""});
            table1.AddRow(new string[] {
                        "WindowsCE",
                        "WindowsMobile",
                        "autogenerate {guid}",
                        "autogenerate WinMobile.{guid}",
                        ""});
            table1.AddRow(new string[] {
                        "WindowsCE",
                        "WindowsMobileSmartPhone",
                        "autogenerate {guid}",
                        "autogenerate WinSP.{guid}",
                        ""});
            table1.AddRow(new string[] {
                        "WindowsDesktop",
                        "WindowsDesktop",
                        "autogenerate {guid}",
                        "autogenerate Win7x64.{guid}",
                        ""});
            table1.AddRow(new string[] {
                        "WindowsDesktop",
                        "WindowsDesktop",
                        "autogenerate {guid}",
                        "autogenerate Win7x32.{guid}",
                        ""});
            table1.AddRow(new string[] {
                        "Printer",
                        "Printer",
                        "autogenerate {guid}",
                        "autogenerate Zebra.{guid}",
                        ""});
            table1.AddRow(new string[] {
                        "Printer",
                        "Printer",
                        "autogenerate {guid}",
                        "autogenerate SOTI.{guid}",
                        ""});
#line 7
testRunner.And("System has packages with properties as follows:", ((string)(null)), table1, "And ");
#line 22
testRunner.And("Execute once per feature ENDED", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Get list of packages in the system using DeviceFamily and PackageName filters")]
        [NUnit.Framework.TestCaseAttribute("All", "{null}", "{null}", "{null}", null)]
        [NUnit.Framework.TestCaseAttribute("AndroidPlus", "{null}", "{null}", "{null}", null)]
        [NUnit.Framework.TestCaseAttribute("WindowsCE", "{null}", "{null}", "{null}", null)]
        [NUnit.Framework.TestCaseAttribute("WindowsDesktop", "{null}", "{null}", "{null}", null)]
        [NUnit.Framework.TestCaseAttribute("Printer", "{null}", "{null}", "{null}", null)]
        [NUnit.Framework.TestCaseAttribute("AndroidPlus", "Aplus3.{guid}", "{null}", "{null}", null)]
        [NUnit.Framework.TestCaseAttribute("WindowsCE", "WinCe.{guid}", "{null}", "{null}", null)]
        [NUnit.Framework.TestCaseAttribute("WindowsDesktop", "Win7x32.{guid}", "{null}", "{null}", null)]
        [NUnit.Framework.TestCaseAttribute("Printer", "SOTI.{guid}", "{null}", "{null}", null)]
        [NUnit.Framework.TestCaseAttribute("All", "Aplus2.{guid}", "{null}", "{null}", null)]
        [NUnit.Framework.TestCaseAttribute("All", "WinMobile.{guid}", "{null}", "{null}", null)]
        [NUnit.Framework.TestCaseAttribute("All", "Win7x64.{guid}", "{null}", "{null}", null)]
        [NUnit.Framework.TestCaseAttribute("All", "Zebra.{guid}", "{null}", "{null}", null)]
        [NUnit.Framework.TestCaseAttribute("AndroidPlus", "{null}", "Name", "true", null)]
        [NUnit.Framework.TestCaseAttribute("WindowsCE", "{null}", "Name", "false", null)]
        [NUnit.Framework.TestCaseAttribute("WindowsCE", "Win", "Name", "true", null)]
        [NUnit.Framework.TestCaseAttribute("All", "Aplus", "Name", "false", null)]
        [NUnit.Framework.TestCaseAttribute("All", "2.", "Name", "true", null)]
        public virtual void GetListOfPackagesInTheSystemUsingDeviceFamilyAndPackageNameFilters(string deviceFamily, string packageName, string orderBy, string descending, string[] exampleTags)
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Get list of packages in the system using DeviceFamily and PackageName filters", exampleTags);
#line 24
this.ScenarioSetup(scenarioInfo);
#line 3
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table2 = new TechTalk.SpecFlow.Table(new string[] {
                        "DeviceFamily",
                        "Name",
                        "OrderInfo.By",
                        "OrderInfo.Descending"});
            table2.AddRow(new string[] {
                        string.Format("{0}", deviceFamily),
                        string.Format("{0}", packageName),
                        string.Format("{0}", orderBy),
                        string.Format("{0}", descending)});
#line 25
    testRunner.When("I make a call to public API to get a list of packages with request properties as " +
                    "follows:", ((string)(null)), table2, "When ");
#line 28
    testRunner.Then("List of packages contains only the correct packages", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
