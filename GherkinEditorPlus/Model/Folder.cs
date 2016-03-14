using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace GherkinEditorPlus.Model
{
    public class Folder
    {
        public Folder(string name):this(name, new List<Feature>(), new List<Folder>())
        {
        }

        public Folder(string name, IEnumerable<Feature> features, IEnumerable<Folder> folders)
        {
            Features = new ObservableCollection<Feature>(features);
            Folders = new ObservableCollection<Folder>(folders);
            Name = name;
        }

        public string Name { get; set; }
        public ObservableCollection<Feature> Features { get; private set; }
        public ObservableCollection<Folder> Folders { get; private set; }

        public override string ToString()
        {
            return $"Folder Name: '{Name}', Feature Count: {Features.Count}, Folder Count: {Folders.Count}";
        }
    }
}