using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace GherkinEditorPlus.Model
{
    public class Scenario
    {
        public Scenario(IEnumerable<Step> steps)
        {
            Steps = new ObservableCollection<Step>(steps);
        }

        public ObservableCollection<Step> Steps { get; private set; }
    }
}