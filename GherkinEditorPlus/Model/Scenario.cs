using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace GherkinEditorPlus.Model
{
    public class Scenario
    {
        public Scenario(string name): this(name, new List<Step>())
        {
        }

        public Scenario(string name, IEnumerable<Step> steps)
        {
            Name = name;
            Steps = new ObservableCollection<Step>(steps);
        }

        public string Name { get; set; }
        public ObservableCollection<Step> Steps { get; set; }
    }
}