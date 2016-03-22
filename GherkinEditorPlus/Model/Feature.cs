using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Runtime.CompilerServices;
using TechTalk.SpecFlow.Generator;
using TechTalk.SpecFlow.Generator.Interfaces;

namespace GherkinEditorPlus.Model
{
    public class Feature : INotifyPropertyChanged
    {
        private bool _modified;
        private bool _isReadOnly;

        public Feature(string name, IEnumerable<Scenario> scenarios, string file, bool isReadyOnly)
        {
            Scenarios = new ObservableCollection<Scenario>(scenarios);
            File = file;
            Name = name;
            IsReadOnly = isReadyOnly;
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

            if (generatedTestFile.Success)
                return generatedTestFile.GeneratedTestCode;

            string errorMessage =String.Join(Environment.NewLine, generatedTestFile.Errors.Select(e => $"(Line {e.Line}, Pos {e.LinePosition}) {e.Message}"));
            throw new TestGeneratorException(errorMessage);
        }

        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}