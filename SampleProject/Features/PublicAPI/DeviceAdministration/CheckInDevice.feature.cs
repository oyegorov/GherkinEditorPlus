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
namespace Soti.MobiControl.Bdd.PublicApiTests.Features.PublicAPI.DeviceAdministration
{
    using TechTalk.SpecFlow;
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("TechTalk.SpecFlow", "1.9.0.77")]
    [System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [NUnit.Framework.TestFixtureAttribute()]
    [NUnit.Framework.DescriptionAttribute("CheckIn Device API")]
    public partial class CheckInDeviceAPIFeature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "CheckInDevice.feature"
#line hidden
        
        [NUnit.Framework.TestFixtureSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "CheckIn Device API", "", ProgrammingLanguage.CSharp, ((string[])(null)));
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
#line 2
#line 3
testRunner.Given("I am a user with name \'Administrator\' and password \'1\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Given ");
#line 4
testRunner.And("I have enabled LDAP integration for LDAP connection \'{sotiqa}\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
            TechTalk.SpecFlow.Table table1 = new TechTalk.SpecFlow.Table(new string[] {
                        "PrincipalType",
                        "Name",
                        "DisplayName",
                        "DomainName",
                        "LdapConnectionName",
                        "MemberOf"});
            table1.AddRow(new string[] {
                        "ActiveDirectoryUser",
                        "SSPUser",
                        "SSP1",
                        "SOTIQA",
                        "{sotiqa}",
                        "MobiControl Administrators"});
#line 5
testRunner.And("I have created principals as follows:", ((string)(null)), table1, "And ");
#line hidden
            TechTalk.SpecFlow.Table table2 = new TechTalk.SpecFlow.Table(new string[] {
                        "DeviceName",
                        "RuleName",
                        "LdapConnection",
                        "LdapUserName",
                        "LdapUserPassword",
                        "DeviceId",
                        "MacAddress",
                        "Imei",
                        "OSVersion"});
            table2.AddRow(new string[] {
                        "autogenerate IosSimulatorDevice.{guid}",
                        "{iosrule_sotiqa}",
                        "{sotiqa}",
                        "SSPUser",
                        "Welcome1234",
                        "autogenerate deviceId.{guid}",
                        "autogenerate mac.{guid}",
                        "autogenerate imei.{guid}",
                        "8.0"});
#line 8
testRunner.And("I enrolled Ios Device with properties as follows(execute once):", ((string)(null)), table2, "And ");
#line hidden
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("CheckInDevice api test")]
        [NUnit.Framework.CategoryAttribute("CarryOverScenarioContext")]
        [NUnit.Framework.TestCaseAttribute("deviceId.{guid}", "DeviceId", "OK", null)]
        [NUnit.Framework.TestCaseAttribute("nonexistingid", "DeviceId", "Unauthorized access", null)]
        [NUnit.Framework.TestCaseAttribute("{null}", "DeviceId", "errorCode: 1", null)]
        [NUnit.Framework.TestCaseAttribute("mac.{guid}", "MacAddress", "OK", null)]
        [NUnit.Framework.TestCaseAttribute("nonexistingid", "MacAddress", "Unauthorized access", null)]
        [NUnit.Framework.TestCaseAttribute("{null}", "MacAddress", "errorCode: 1", null)]
        [NUnit.Framework.TestCaseAttribute("imei.{guid}", "ImeiMeid", "OK", null)]
        [NUnit.Framework.TestCaseAttribute("nonexistingid", "ImeiMeid", "Unauthorized access", null)]
        [NUnit.Framework.TestCaseAttribute("{null}", "ImeiMeid", "errorCode: 1", null)]
        public virtual void CheckInDeviceApiTest(string deviceIdentifier, string deviceIdentityType, string result, string[] exampleTags)
        {
            string[] @__tags = new string[] {
                    "CarryOverScenarioContext"};
            if ((exampleTags != null))
            {
                @__tags = System.Linq.Enumerable.ToArray(System.Linq.Enumerable.Concat(@__tags, exampleTags));
            }
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("CheckInDevice api test", @__tags);
#line 13
this.ScenarioSetup(scenarioInfo);
#line 2
this.FeatureBackground();
#line 14
 testRunner.Given("I am a user with name \'Administrator\' and password \'1\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Given ");
#line hidden
            TechTalk.SpecFlow.Table table3 = new TechTalk.SpecFlow.Table(new string[] {
                        "SecurityRole",
                        "PermissionType",
                        "PermissionName",
                        "IsAllowed"});
            table3.AddRow(new string[] {
                        "DeviceOwner",
                        "Feature",
                        "LoginSSP",
                        "true"});
            table3.AddRow(new string[] {
                        "DeviceOwner",
                        "Device",
                        "CheckIn",
                        "true"});
#line 15
 testRunner.And("I have granted principal \'SSPUser\' the permissions as follows:", ((string)(null)), table3, "And ");
#line 19
 testRunner.When("I am a user with name \'SSPUser\' and password \'Welcome1234\' and role \'ssp\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "When ");
#line hidden
            TechTalk.SpecFlow.Table table4 = new TechTalk.SpecFlow.Table(new string[] {
                        "DeviceIdentity.Id",
                        "DeviceIdentity.DevicePropertyIdType"});
            table4.AddRow(new string[] {
                        string.Format("{0}", deviceIdentifier),
                        string.Format("{0}", deviceIdentityType)});
#line 20
    testRunner.And("I call Public API function CheckInDevice using request with properties as follows" +
                    ":", ((string)(null)), table4, "And ");
#line 23
 testRunner.Then(string.Format("Public API response is \'{0}\'", result), ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
