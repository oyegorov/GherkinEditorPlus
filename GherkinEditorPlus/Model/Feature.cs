using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace GherkinEditorPlus.Model
{
    public class Feature : INotifyPropertyChanged
    {
        private bool _modified;

        public Feature(string name, string file) : this(name, new List<Scenario>(), file)
        {
        }

        public Feature(string name, IEnumerable<Scenario> scenarios, string file)
        {
            Scenarios = new ObservableCollection<Scenario>(scenarios);
            File = file;
            Name = name;
        }

        public string Name { get; private set; }

        public ObservableCollection<Scenario> Scenarios { get; private set; }

        public string File { get; private set; }

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

        public string Text { get; set; }

        public override string ToString()
        {
            return $"Feature Name: '{Name}'";
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}