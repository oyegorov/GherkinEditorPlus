using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace GherkinEditorPlus.Model
{
    public class Folder : INotifyPropertyChanged
    {
        public Folder(string name):this(name, new List<Feature>(), new List<Folder>())
        {
        }

        public Folder(string name, IEnumerable<Feature> features, IEnumerable<Folder> folders)
        {
            Features = new ObservableCollection<Feature>(features);
            Folders = new ObservableCollection<Folder>(folders);
            Name = name;

            Features.CollectionChanged += Features_CollectionChanged;
            Folders.CollectionChanged += Folders_CollectionChanged;
        }

        public event PropertyChangedEventHandler PropertyChanged;

        public string Path { get; set; }

        public string Name { get; set; }

        public ObservableCollection<Feature> Features { get;  set; }

        public ObservableCollection<Folder> Folders { get;  set; }

        public override string ToString()
        {
            return $"Folder Name: '{Name}', Feature Count: {Features.Count}, Folder Count: {Folders.Count}";
        }

        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        private void Folders_CollectionChanged(object sender, System.Collections.Specialized.NotifyCollectionChangedEventArgs e)
        {
            OnPropertyChanged(nameof(Folders));
        }

        private void Features_CollectionChanged(object sender, System.Collections.Specialized.NotifyCollectionChangedEventArgs e)
        {
            OnPropertyChanged(nameof(Features));
        }
    }
}