using System.Collections.Generic;

namespace GherkinEditorPlus.Model
{
    public class Background : Scenario
    {
        public Background():base("Background", new List<Step>())
        {
        }
    }
}