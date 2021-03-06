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
    [NUnit.Framework.DescriptionAttribute("Device actions API")]
    public partial class DeviceActionsAPIFeature
    {
        
        private static TechTalk.SpecFlow.ITestRunner testRunner;
        
#line 1 "DeviceActions.feature"
#line hidden
        
        [NUnit.Framework.TestFixtureSetUpAttribute()]
        public virtual void FeatureSetup()
        {
            testRunner = TechTalk.SpecFlow.TestRunnerManager.GetTestRunner();
            TechTalk.SpecFlow.FeatureInfo featureInfo = new TechTalk.SpecFlow.FeatureInfo(new System.Globalization.CultureInfo("en-US"), "Device actions API", "", ProgrammingLanguage.CSharp, ((string[])(null)));
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
                        "LdapUserName",
                        "LdapUserPassword",
                        "DeviceId",
                        "MacAddress",
                        "Imei"});
            table2.AddRow(new string[] {
                        "autogenerate IosSimulatorDevice.{guid}",
                        "{iosrule_sotiqa}",
                        "SSPUser",
                        "Welcome1234",
                        "autogenerate deviceId.{guid}",
                        "autogenerate mac.{guid}",
                        "autogenerate imei.{guid}"});
#line 8
testRunner.And("I enrolled Ios Device with properties as follows(execute once):", ((string)(null)), table2, "And ");
#line 11
testRunner.And("I am a client of Public API with name \'ApiClient\' and secret \'ClientSecret\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line 12
 testRunner.And("I make calls to Public API on behalf of user \'SSPUser\' with password \'Welcome1234" +
                    "\'", ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "And ");
#line hidden
        }
        
        [NUnit.Framework.TestAttribute()]
        [NUnit.Framework.DescriptionAttribute("Send script API test")]
        [NUnit.Framework.CategoryAttribute("CarryOverScenarioContext")]
        [NUnit.Framework.TestCaseAttribute("SendDeviceScript", "deviceId.{guid}", "SendScript", "This is a script", "message: Send Script Failed. The specified device does not support the send scrip" +
            "t command.", null)]
        [NUnit.Framework.TestCaseAttribute("SendDeviceScript", "deviceId.{guid}", "SendScript", "Script with unicode ☼~ç►wrteqr♫↕♪", "message: Send Script Failed. The specified device does not support the send scrip" +
            "t command.", null)]
        [NUnit.Framework.TestCaseAttribute("SendDeviceScript", "nonexistingid", "SendScript", "This is a script", "Unauthorized access", null)]
        [NUnit.Framework.TestCaseAttribute("SendDeviceScript", "{null}", "SendScript", "This is a script", "errorCode: 0", null)]
        [NUnit.Framework.TestCaseAttribute("None", "deviceId.{guid}", "SendScript", "This is a script", "message: Send Script Failed. The specified device does not support the send scrip" +
            "t command.", null)]
        public virtual void SendScriptAPITest(string accessRight, string deviceIdentifier, string action, string script, string result, string[] exampleTags)
        {
            string[] @__tags = new string[] {
                    "CarryOverScenarioContext"};
            if ((exampleTags != null))
            {
                @__tags = System.Linq.Enumerable.ToArray(System.Linq.Enumerable.Concat(@__tags, exampleTags));
            }
            TechTalk.SpecFlow.ScenarioInfo scenarioInfo = new TechTalk.SpecFlow.ScenarioInfo("Send script API test", @__tags);
#line 15
this.ScenarioSetup(scenarioInfo);
#line 2
this.FeatureBackground();
#line hidden
            TechTalk.SpecFlow.Table table3 = new TechTalk.SpecFlow.Table(new string[] {
                        "TargetGroups",
                        "AccessRight"});
            table3.AddRow(new string[] {
                        "\\\\My Company",
                        string.Format("{0}", accessRight)});
#line 16
 testRunner.Given("I have granted principal \'SSPUser\' the old permissions as follows:", ((string)(null)), table3, "Given ");
#line hidden
            TechTalk.SpecFlow.Table table4 = new TechTalk.SpecFlow.Table(new string[] {
                        "DeviceId",
                        "ActionInfo",
                        "Message"});
            table4.AddRow(new string[] {
                        string.Format("{0}", deviceIdentifier),
                        string.Format("{0}", action),
                        string.Format("{0}", script)});
#line 19
 testRunner.When("I execute a device action with options as follows:", ((string)(null)), table4, "When ");
#line 22
 testRunner.Then(string.Format("Public API response is \'{0}\'", result), ((string)(null)), ((TechTalk.SpecFlow.Table)(null)), "Then ");
#line hidden
            this.ScenarioCleanup();
        }
    }
}
#pragma warning restore
#endregion
