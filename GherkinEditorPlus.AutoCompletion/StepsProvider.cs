using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Xml.Linq;
using System.Xml.XPath;

namespace GherkinEditorPlus.AutoCompletion
{
    public class StepsProvider
    {
        private const string IncludedStaticFileXPath = "//*[local-name()='None']";
        private const string IncludeAttributeName = "Include";
        private const string Separators = @"(Given\s|When\s|Then\s|And\s)";
        private const string ValueToken = "'%value%'";

        private static readonly Regex FeatureStepExtractorRegex = new Regex(Separators + @"\s*(?<stepInstance>.*[^\s])?\s*", RegexOptions.Compiled);
        private static readonly Regex QuotesRegex = new Regex("'[^']*'", RegexOptions.IgnoreCase);

        private readonly string _projectFilePath;
        private string[] _steps;

        public StepsProvider(string projectFilePath)
        {
            if (projectFilePath == null)
                throw new ArgumentNullException(nameof(projectFilePath));
            if (!File.Exists(projectFilePath))
                throw new FileNotFoundException(projectFilePath);

            _projectFilePath = projectFilePath;
            Refresh();
        }

        public void Refresh()
        {
            XDocument csprojDocument = XDocument.Load(_projectFilePath);

            var includedStaticFiles =
                csprojDocument.XPathSelectElements(IncludedStaticFileXPath)
                    .Where(e => e.Attribute(IncludeAttributeName) != null)
                    .Select(e => e.Attribute(IncludeAttributeName).Value);

            var includedFeatures = includedStaticFiles.Where(f => f.EndsWith(".feature", StringComparison.OrdinalIgnoreCase));

            var stepsHashset = new HashSet<string>();

            string projectDirectory = Path.GetDirectoryName(_projectFilePath);
            foreach (string featureRelativePath in includedFeatures)
            {
                string featureFilePath = Path.Combine(projectDirectory, featureRelativePath);
                if (!File.Exists(featureFilePath))
                    continue;

                string[] featureFileLines = File.ReadAllLines(featureFilePath);
                ExtractStepsFromFeatureFile(featureFileLines, stepsHashset);
            }

            _steps = stepsHashset.ToArray();
        }

        public string[] GetSteps(string searchPattern = null)
        {
            if (_steps == null)
                return new string[0];

            IEnumerable<string> filteredSteps = _steps;
            if (!String.IsNullOrEmpty(searchPattern))
                filteredSteps = filteredSteps.Where(s => s.IndexOf(searchPattern, StringComparison.OrdinalIgnoreCase) >= 0);
            else
                filteredSteps = _steps;

            return filteredSteps.OrderBy(r => r).ToArray();
        }

        private void ExtractStepsFromFeatureFile(string[] featureFileLines, HashSet<string> stepsHashset)
        {
            foreach (string featureFileLine in featureFileLines)
            {
                var matches = FeatureStepExtractorRegex.Matches(featureFileLine);
                foreach (Match match in matches)
                {
                    if (!match.Success)
                        continue;

                    string stepInstance = match.Groups["stepInstance"].Value;
                    string generalizedStep = QuotesRegex.Replace(stepInstance, ValueToken);
                    stepsHashset.Add(generalizedStep);
                }
            }
        }
    }
}