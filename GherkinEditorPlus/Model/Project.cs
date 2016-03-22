using System;
using System.Collections.Generic;
using System.Linq;
using GherkinEditorPlus.Utils;

namespace GherkinEditorPlus.Model
{
    public class Project : Folder
    {
        private bool _isReadOnly;

        public Project(string name, string defaultNamespace, string file, IEnumerable<Feature> features, IEnumerable<Folder> folders) : base(name, features, folders)
        {
            if (defaultNamespace == null)
                throw new ArgumentNullException(nameof(defaultNamespace));
            if (file == null)
                throw new ArgumentNullException(nameof(file));

            File = file;
            DefaultNamespace = defaultNamespace;
            Path = System.IO.Path.GetDirectoryName(File);
        }

        public string File { get; }

        public string DefaultNamespace { get; }

        public bool IsReadOnly
        {
            get
            {
                return _isReadOnly;
            }
            set
            {
                _isReadOnly = value;
                OnPropertyChanged();
            }
        }

        public Step[] GetAllSteps()
        {
            return
                Folders.SelectMany(
                    f =>
                        f.Folders
                            .SelectMany(fo => fo.Features)
                            .SelectMany(fe => fe.Scenarios)
                            .SelectMany(fe => fe.Steps))
                    .Union(
                        Folders.SelectMany(fo => fo.Features).SelectMany(fe => fe.Scenarios).SelectMany(fe => fe.Steps))
                    .DistinctBy(s => s.Text)
                    .OrderBy(s => s.Text)
                    .ToArray();
        }

        public string[] GetAllFiles()
        {
            return Folders.SelectMany(
                f =>
                    f.Folders.SelectMany(fo => fo.Features)
                        .Union(Folders.SelectMany(fo => fo.Features)).Select(fe => fe.File))
                .ToArray();
        }

        public Feature GetFeatureByFile(string fullPath)
        {
            return FlattenFeatures(this).SingleOrDefault(f => String.Equals(f.File, fullPath, StringComparison.OrdinalIgnoreCase));
        }

        public override string ToString()
        {
            return $"Project Name: '{Name}'";
        }

        private IEnumerable<Feature> FlattenFeatures(Folder parent)
        {
            foreach (var feature in parent.Features)
                yield return feature;

            foreach (Folder childFolder in parent.Folders)
                foreach (Feature feature in FlattenFeatures(childFolder))
                    yield return feature;
        }
    }
}
