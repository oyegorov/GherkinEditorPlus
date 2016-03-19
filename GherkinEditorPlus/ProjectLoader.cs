using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Xml.Linq;
using System.Xml.XPath;
using GherkinEditorPlus.Model;

namespace GherkinEditorPlus
{
    public static class ProjectLoader
    {
        private const string IncludedStaticFileXPath = "//*[local-name()='None']";
        private const string DefaultNamespaceXPath = "//*[local-name()='RootNamespace']";
        private const string IncludeAttributeName = "Include";
        private const string Separators = @"(Given\s|When\s|Then\s|And\s)";
        private const string ScenarioRegexTemplate = @"(Scenario:\s|Scenario Outline:\s)(?<scenario_name>.*)";
        private const string ValueToken = "'%value%'";
        private const string BackGroundTemplate = "Background:";
        
        private static readonly Regex QuotesRegex = new Regex("'[^']*'", RegexOptions.IgnoreCase);
        private static readonly Regex BackgroundRegex = new Regex(BackGroundTemplate, RegexOptions.Compiled);
        private static readonly Regex ScenarioExtractorRegex = new Regex(ScenarioRegexTemplate, RegexOptions.Compiled);
        private static readonly Regex FeatureStepExtractorRegex = new Regex(Separators + @"\s*(?<stepInstance>.*[^\s])?\s*", RegexOptions.Compiled);

        public static Project LoadProject(string projectFilePath)
        {
            if (projectFilePath == null)
                throw new ArgumentNullException(nameof(projectFilePath));

            if (!File.Exists(projectFilePath))
                throw new FileNotFoundException(projectFilePath);

            XDocument csprojDocument = XDocument.Load(projectFilePath);

            var includedStaticFiles =
                csprojDocument.XPathSelectElements(IncludedStaticFileXPath)
                    .Where(e => e.Attribute(IncludeAttributeName) != null)
                    .Select(e => e.Attribute(IncludeAttributeName).Value);

            string defaultNamespace = csprojDocument.XPathSelectElement(DefaultNamespaceXPath).Value;

            var includedFeatures = includedStaticFiles.Where(f => f.EndsWith(".feature", StringComparison.OrdinalIgnoreCase));

            List<Folder> rootFolders = new List<Folder>();

            foreach (string includedFeature in includedFeatures)
            {
                string[] parts = includedFeature.Split(new[] {@"\"}, StringSplitOptions.RemoveEmptyEntries);

                string featureName = parts[parts.Length - 1];

                Folder currentFolder = null;

                foreach (string featureFolder in parts.Take(parts.Length - 1))
                {
                    if (currentFolder == null)
                    {
                        currentFolder = rootFolders.SingleOrDefault(f => f.Name == featureFolder);
                        if (currentFolder == null)
                        {
                            currentFolder = new Folder(featureFolder);
                            rootFolders.Add(currentFolder);
                        }
                        continue;
                    }

                    Folder child = currentFolder.Folders.SingleOrDefault(f => f.Name == featureFolder);

                    if (child == null)
                    {
                        child = new Folder(featureFolder);
                        currentFolder.Folders.Add(child);
                        currentFolder = child;
                    }
                    else
                    {
                        currentFolder = child;
                    }
                }

                string fileName = Path.Combine(new FileInfo(projectFilePath).Directory.FullName, includedFeature);

                currentFolder.Features.Add(CreateFeatureFromInternal(featureName, fileName));
            }

            return new Project(new FileInfo(projectFilePath).Name, defaultNamespace, Path.GetFullPath(projectFilePath), new List<Feature>(), rootFolders);
        }

        private static Feature CreateFeatureFromInternal(string name, string file)
        {
            var feature = new Feature(name, new List<Scenario>(), file);
            feature.Text = File.ReadAllText(file);

            string[] featureLines = File.ReadAllLines(file);

            Scenario currentScenario = null;
            Background backgroundScenario = null;
            Step lastStep = null;

            bool isBackground = false;

            bool processingTable = false;
            
            foreach (string featureLine in featureLines)
            {
                string[] columns = null;
                if (TryParseAsTable(featureLine, out columns))
                {
                    if (!processingTable)
                    {
                        lastStep.TableHeaders = columns;
                        processingTable = true;
                    }

                    continue;
                }

                processingTable = false;

                if (BackgroundRegex.IsMatch(featureLine))
                {
                    isBackground = true;
                    backgroundScenario = new Background();
                    feature.Scenarios.Add(backgroundScenario);
                    continue;
                }

                string scenarioName;

                if (TryParseAsScenario(featureLine, out scenarioName))
                {
                    isBackground = false;

                    currentScenario = new Scenario(scenarioName);
                    feature.Scenarios.Add(currentScenario);
                    
                    continue;
                };

                string stepText;

                if (TryParseAsStep(featureLine, out stepText))
                {
                    Step step = new Step(stepText);
                    lastStep = step;

                    if (isBackground)
                    {
                        backgroundScenario.Steps.Add(step);
                        continue;
                    }

                    //Warning...Someone decided that feature description should also be written in terms of And, When, etc...
                    if (currentScenario == null)
                    {
                        continue;
                        //throw new InvalidOperationException($"Unable to process a step without a correspoding scenario. Step Text = '{stepText}'");
                    }

                    currentScenario.Steps.Add(step);

                    continue;
                };

              
            }

            return feature;
        }

        public static bool TryParseAsTable(string featureLine, out string[] columns)
        {
            columns = null;

            string trimmedFeatureLine = featureLine.Trim();

            if (trimmedFeatureLine.StartsWith("|") && trimmedFeatureLine.EndsWith("|"))
            {
                columns =
                    trimmedFeatureLine.Split(new[] {"|"}, StringSplitOptions.RemoveEmptyEntries).
                        Select(v => v.Trim()).
                        ToArray();

                return true;
            }

            return false;
        }

        private static bool TryParseAsScenario(string featureLine, out string scenarioName)
        {
            scenarioName = null;

            var matches = ScenarioExtractorRegex.Matches(featureLine);

            foreach (Match match in matches)
            {
                if (!match.Success)
                {
                    return false;
                }

                scenarioName = match.Groups["scenario_name"].Value;
                return true;
            }

            return false;
        }

        private static bool TryParseAsStep(string featureLine, out string stepText)
        {
            stepText = null;

            var matches = FeatureStepExtractorRegex.Matches(featureLine);

            foreach (Match match in matches)
            {
                if (!match.Success)
                {
                    return false;
                }

                stepText = match.Groups["stepInstance"].Value;
                stepText = QuotesRegex.Replace(stepText, ValueToken);

                return true;
            }

            return false;
        }

        private class FolderInternal
        {
            public string Name { get; set; }
            public List<FolderInternal> Folders = new List<FolderInternal>();
            public List<FeatureInternal> Features = new List<FeatureInternal>();
        }

        private class FeatureInternal
        {
            public string Name { get; set; }
            public string FileName { get; set; }
        }
    }
}
