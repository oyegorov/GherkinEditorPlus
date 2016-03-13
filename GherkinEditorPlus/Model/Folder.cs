using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace GherkinEditorPlus.Model
{
    public class Folder
    {
        public Folder(IEnumerable<Feature> features, IEnumerable<Folder> folders)
        {
            Features = new ObservableCollection<Feature>(features);
            Folders = new ObservableCollection<Folder>(folders);
        }

        public ObservableCollection<Feature> Features { get; private set; }
        public ObservableCollection<Folder> Folders { get; private set; }
    }
}