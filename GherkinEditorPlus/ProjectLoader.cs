﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
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
        private const string ValueToken = "'%value%'";

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

            List<FolderInternal> rootFolders = new List<FolderInternal>();

            foreach (string includedFeature in includedFeatures)
            {
                string[] parts = includedFeature.Split(new[] {@"\"}, StringSplitOptions.RemoveEmptyEntries);

                string featureName = parts[parts.Length - 1];

                FolderInternal currentFolder = null;

                foreach (string featureFolder in parts.Take(parts.Length - 1))
                {
                    if (currentFolder == null)
                    {
                        currentFolder = rootFolders.SingleOrDefault(f => f.Name == featureFolder);
                        if (currentFolder == null)
                        {
                            currentFolder = new FolderInternal() {Name = featureFolder};
                            rootFolders.Add(currentFolder);
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

                currentFolder.Features.Add(new FeatureInternal() {Name = featureName});
            }

            return null;
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
        }
    }
}