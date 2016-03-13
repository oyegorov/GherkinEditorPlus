using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace GherkinEditorPlus.Model
{
    public class Feature
    {
        public Feature(string name, IEnumerable<Scenario> scenarios, string file)
        {
            Scenarios = new ObservableCollection<Scenario>(scenarios);
            File = file;
            Name = name;
        }

        public string Name { get; private set; }

        public ObservableCollection<Scenario> Scenarios { get; private set; }

        public string File { get; private set; }
        
    }
}