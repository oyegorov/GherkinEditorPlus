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

            var includedFeatures = includedStaticFiles.Where(f => f.EndsWith(".feature", StringComparison.OrdinalIgnoreCase));

            List<FolderInternal> rootFoldersInternal = new List<FolderInternal>();

            foreach (string includedFeature in includedFeatures)
            {
                string[] parts = includedFeature.Split(new[] {@"\"}, StringSplitOptions.RemoveEmptyEntries);

                string featureName = parts[parts.Length - 1];

                FolderInternal currentFolder = null;

                foreach (string featureFolder in parts.Take(parts.Length - 1))
                {
                    if (currentFolder == null)
                    {
                        currentFolder = rootFoldersInternal.SingleOrDefault(f => f.Name == featureFolder);
                        if (currentFolder == null)
                        {
                            currentFolder = new FolderInternal() {Name = featureFolder};
                            rootFoldersInternal.Add(currentFolder);
                        }
                        continue;
                    }

                    FolderInternal child = currentFolder.Folders.SingleOrDefault(f => f.Name == featureFolder);

                    if (child == null)
                    {
                        child = new FolderInternal() { Name = featureFolder };
                        currentFolder.Folders.Add(child);
                        currentFolder = child;
                    }
                }

                string fileName = Path.Combine(new FileInfo(projectFilePath).Directory.FullName, includedFeature);

                currentFolder.Features.Add(new FeatureInternal() {Name = featureName, FileName = fileName });
            }

            var rootFolders = rootFoldersInternal.Select(CreateFolderFromInternal);

            return new Project(new FileInfo(projectFilePath).Name, new Feature[0], rootFolders);
        }

        private static Folder CreateFolderFromInternal(FolderInternal folderInternal)
        {
            Folder folder = new Folder(
                folderInternal.Name,
                folderInternal.Features.Select(CreateFeatureFromInternal),
                folderInternal.Folders.Select(CreateFolderFromInternal));

            return folder;
        }

        private static Feature CreateFeatureFromInternal(FeatureInternal featureInternal)
        {
            var feature = new Feature(featureInternal.Name, new List<Scenario>(), featureInternal.FileName);

            string[] featureLines = File.ReadAllLines(featureInternal.FileName);

            Scenario currentScenario = null;
            Background backgroundScenario = null;

            bool isBackground = false;

            foreach (string featureLine in featureLines)
            {
                if (BackgroundRegex.IsMatch(featureLine))
                {
                    isBackground = true;
                    backgroundScenario = new Background();
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
                };
            }

            return feature;
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
