using System.Collections.Generic;

namespace GherkinEditorPlus.Model
{
    public class Project : Folder
    {
        public Project(string name, IEnumerable<Feature> features, IEnumerable<Folder> folders):base(name, features, folders)
        {
        }

        public override string ToString()
        {
            return $"Project Name: '{Name}'";
        }
    }
}
