using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.IO;
using System.Runtime.CompilerServices;
using TechTalk.SpecFlow.Generator;
using TechTalk.SpecFlow.Generator.Interfaces;

namespace GherkinEditorPlus.Model
{
    public class Feature : INotifyPropertyChanged
    {
        private bool _modified;

        public Feature(string name, string file) : this(name, new List<Scenario>(), file)
        {
        }

        public Feature(string name, IEnumerable<Scenario> scenarios, string file)
        {
            Scenarios = new ObservableCollection<Scenario>(scenarios);
            File = file;
            Name = name;
        }

        public event PropertyChangedEventHandler PropertyChanged;

        public string Name { get; }

        public ObservableCollection<Scenario> Scenarios { get; private set; }

        public string File { get; }

        public bool Modified
        {
            get
            {
                return _modified;
            }
            set
            {
                _modified = value;
                OnPropertyChanged();
            }
        }

        public string Text { get; set; }

        public override string ToString()
        {
            return $"Feature Name: '{Name}'";
        }
        
        public string GetCodeBehind(string codeNamespace)
        {
            if (codeNamespace == null)
                throw new ArgumentNullException(nameof(codeNamespace));

            var factory = new TestGeneratorFactory();
            var generator = factory.CreateGenerator(new ProjectSettings
            {
                ProjectFolder = Path.GetDirectoryName(File)
            });

            var featureInput = new FeatureFileInput(Path.GetFileName(File))
            {
                CustomNamespace = codeNamespace,
                FeatureFileContent = Text,
            };

            var generatedTestFile = generator.GenerateTestFile(featureInput, new GenerationSettings());
            return generatedTestFile.Success ? generatedTestFile.GeneratedTestCode : String.Empty;
        }

        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}