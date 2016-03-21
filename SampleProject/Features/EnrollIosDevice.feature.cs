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
    [NUnit.Framework.DescriptionAttribute("Enrolling Ios Device")]
    public partial class EnrollingIosDeviceFeature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "EnrollIosDevice.feature"
#line hidden
        
        [NUnit.Framework.TestFixtureSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "Enrolling Ios Device", "", ProgrammingLanguage.CSharp, ((string[])(null)));
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
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Enrolling iOS device with Ldap Authentication")]
        [NUnit.Framework.IgnoreAttribute()]
        public virtual void EnrollingIOSDeviceWithLdapAuthentication()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Enrolling iOS device with Ldap Authentication", new string[] {
                        "ignore"});
#line 5
this.ScenarioSetup(scenarioInfo);
#line 6
testRunner.Given("I am a user with name \'Administrator\' and password \'1\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Given ");
#line 7
    testRunner.And("I uploaded an APNS certificate from \'file:\\\\storage\\\\qaShare\\\\BDD_IntegrationTest" +
                    "s_Data\\\\iOS_Certificate.pfx \' with password \'123456\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            TechTalk.SpecFlow.Table table1 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Server",
                        "UserName",
                        "Password",
                        "Base DN"});
            table1.AddRow(new string[] {
                        "autogenerate {guid}.LdapConnection",
                        "corp.soti.net",
                        "testuser2",
                        "Bonjour321",
                        "DC=corp,DC=soti,DC=net"});
#line 8
    testRunner.And("I have configured LDAP connection as follows:", ((string)(null)), table1, "And ");
#line hidden
            TechTalk.SpecFlow.Table table2 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "DeviceFamily",
                        "TargetGroups",
                        "LdapConnection",
                        "Priority"});
            table2.AddRow(new string[] {
                        "autogenerate {guid}.RuleName",
                        "Ios",
                        "\\My Company",
                        "{guid}.LdapConnection",
                        "Normal"});
#line 11
    testRunner.And("I have created a rule as follows:", ((string)(null)), table2, "And ");
#line hidden
            TechTalk.SpecFlow.Table table3 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Identifier",
                        "ShortVersion",
                        "Version",
                        "BundleSize",
                        "DynamicSize"});
            table3.AddRow(new string[] {
                        "autogenerate {guid}.ApplicationName",
                        "autogenerate {guid}.AppId",
                        "1.0",
                        "1.0.0",
                        "1024",
                        "2048"});
            table3.AddRow(new string[] {
                        "autogenerate {guid}.ApplicationName",
                        "autogenerate {guid}.AppId",
                        "1.1",
                        "1.1.0",
                        "2048",
                        "4096"});
#line 14
 testRunner.And("Ios Device contains applications as follows:", ((string)(null)), table3, "And ");
#line hidden
            TechTalk.SpecFlow.Table table4 = new TechTalk.SpecFlow.Table(new string[] {
                        "DeviceName",
                        "LdapUserName",
                        "LdapUserPassword"});
            table4.AddRow(new string[] {
                        "autogenerate iosSimulator.{buildnumber}.{guid}",
                        "testuser2",
                        "Bonjour321"});
#line 18
testRunner.When("I enroll an Ios Device with information as follows:", ((string)(null)), table4, "When ");
#line 21
testRunner.Then("The device is succesfully enrolled to the rule target", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            TechTalk.SpecFlow.Table table5 = new TechTalk.SpecFlow.Table(new string[] {
                        "ProfileName",
                        "Status"});
            table5.AddRow(new string[] {
                        "Profile Catalog",
                        "Installed"});
            table5.AddRow(new string[] {
                        "App Catalog",
                        "Installed"});
#line 22
 testRunner.And("The the statuses of the profiles returned from public API for the device are as f" +
                    "ollows:", ((string)(null)), table5, "And ");
#line hidden
            this.ScenarioCleanup();
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Enrolling iOS device with Ldap Authentication compact")]
        public virtual void EnrollingIOSDeviceWithLdapAuthenticationCompact()
        {
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Enrolling iOS device with Ldap Authentication compact", ((string[])(null)));
#line 27
this.ScenarioSetup(scenarioInfo);
#line 28
testRunner.Given("I am a user with name \'Administrator\' and password \'1\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Given ");
#line hidden
            TechTalk.SpecFlow.Table table6 = new TechTalk.SpecFlow.Table(new string[] {
                        "Name",
                        "Identifier",
                        "ShortVersion",
                        "Version",
                        "BundleSize",
                        "DynamicSize"});
            table6.AddRow(new string[] {
                        "autogenerate {guid}.ApplicationName",
                        "autogenerate {guid}.AppId",
                        "1.0",
                        "1.0.0",
                        "1024",
                        "2048"});
            table6.AddRow(new string[] {
                        "autogenerate {guid}.ApplicationName",
                        "autogenerate {guid}.AppId",
                        "1.1",
                        "1.1.0",
                        "2048",
                        "4096"});
            table6.AddRow(new string[] {
                        "autogenerate {guid}.ApplicationName",
                        "autogenerate {guid}.AppId",
                        "1.2",
                        "1.2.0",
                        "4096",
                        "8192"});
            table6.AddRow(new string[] {
                        "autogenerate {guid}.ApplicationName",
                        "autogenerate {guid}.AppId",
                        "1.3",
                        "1.3.0",
                        "8192",
                        "16384"});
            table6.AddRow(new string[] {
                        "autogenerate {guid}.ApplicationName",
                        "autogenerate {guid}.AppId",
                        "1.4",
                        "1.4.0",
                        "16384",
                        "32768"});
            table6.AddRow(new string[] {
                        "autogenerate {guid}.ApplicationName",
                        "autogenerate {guid}.AppId",
                        "1.5",
                        "1.5.0",
                        "32768",
                        "65536"});
#line 29
testRunner.And("Ios Device contains applications as follows:", ((string)(null)), table6, "And ");
#line hidden
            TechTalk.SpecFlow.Table table7 = new TechTalk.SpecFlow.Table(new string[] {
                        "DeviceName",
                        "RuleName",
                        "LdapConnection",
                        "LdapUserName",
                        "LdapUserPassword",
                        "RuleName"});
            table7.AddRow(new string[] {
                        "autogenerate iosSimulator_compact.{buildnumber}.{guid}",
                        "{iosrule_soti.net}",
                        "{soti.net}",
                        "testuser2",
                        "Bonjour321",
                        "{iosrule_soti.net}"});
#line 37
testRunner.And("I enrolled Ios Device with properties as follows:", ((string)(null)), table7, "And ");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
