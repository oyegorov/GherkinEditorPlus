using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace GherkinEditorPlus.Model
{
    public class Feature
    {
        public Feature(IEnumerable<Scenario> scenarios, string file)
        {
            Scenarios = new ObservableCollection<Scenario>(scenarios);
            File = file;
        }

        public ObservableCollection<Scenario> Scenarios { get; private set; }
        public string File { get; private set; }
    }
}