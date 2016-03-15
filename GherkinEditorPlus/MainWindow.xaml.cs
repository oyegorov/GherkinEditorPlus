using System;
using System.Collections.ObjectModel;
using System.IO;
using System.Linq;
using System.Windows;
using System.Windows.Data;
using System.Windows.Input;
using GherkinEditorPlus.Model;
using GherkinEditorPlus.UserControls;
using GherkinEditorPlus.Utils;
using Microsoft.Win32;

namespace GherkinEditorPlus
{
	public partial class MainWindow
	{
        public ICommand CloseEditedFeatureCommand { get; set; }
        public ICommand OpenCommand { get; set; }
        public ICommand SaveCommand { get; set; }
        public ICommand SaveAllCommand { get; set; }

	    public static readonly DependencyProperty EditedFeaturesProperty = DependencyProperty.Register("EditedFeaturesProperty", typeof(ObservableCollection<Feature>), typeof(MainWindow), new PropertyMetadata(new ObservableCollection<Feature>()));
        public ObservableCollection<Feature> EditedFeatures
        {
            get { return (ObservableCollection<Feature>)GetValue(EditedFeaturesProperty); }
            set { SetValue(EditedFeaturesProperty, value); }
        }

        public Feature ActiveFeature
        {
            get { return (Feature)GetValue(ActiveFeatureProperty); }
            set { SetValue(ActiveFeatureProperty, value); }
        }
        public static readonly DependencyProperty ActiveFeatureProperty = DependencyProperty.Register("ActiveFeature", typeof(Feature), typeof(MainWindow), new PropertyMetadata(null));

        public MainWindow()
	    {
            CloseEditedFeatureCommand = new DelegateCommand(CloseEditedFeature);
            OpenCommand = new DelegateCommand(Open);
            SaveCommand = new DelegateCommand(Save);
            SaveAllCommand = new DelegateCommand(SaveAll);

            InitializeComponent();

            LoadProject(@"..\..\SampleProject\Bdd.PublicApiTests.csproj");
	    }

	    private void SaveAll(object obj)
	    {
	        foreach (var editedFeature in EditedFeatures)
	        {
                File.WriteAllText(editedFeature.File, editedFeature.Text);
                editedFeature.Modified = false;
            }
	    }

	    private void Save(object obj)
	    {
	        if (ActiveFeature != null)
	        {
                File.WriteAllText(ActiveFeature.File, ActiveFeature.Text);
	            ActiveFeature.Modified = false;
	        }
	    }

	    private void Open(object obj)
	    {
            OpenFileDialog openFileDialog = new OpenFileDialog();
	        openFileDialog.Filter = "C# project files|*.csproj";

	        if (openFileDialog.ShowDialog() == true)
               LoadProject(openFileDialog.FileName);
	    }

	    private void OnFeatureNodeDoubleClick(object sender, FeatureNodeDoubleClickEventArgs args)
	    {
            if (!EditedFeatures.Contains(args.Feature))
                EditedFeatures.Add(args.Feature);

	        ActiveFeature = args.Feature;
	    }

        private void CloseEditedFeature(object o)
        {
            var featureToClose = (Feature) o;

            if (featureToClose.Modified && MessageBox.Show($"Feature '{featureToClose.Name}' was changed. Continue?", "Gherkin Editor Plus", MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
            {
                int newActiveFeatureIndex = Math.Max(EditedFeatures.IndexOf(featureToClose) - 1, 0);

                EditedFeatures.Remove(featureToClose);

                if (EditedFeatures.Count != 0)
                    ActiveFeature = EditedFeatures[newActiveFeatureIndex];
            }
        }

	    private void LoadProject(string fileName)
	    {
            EditedFeatures.Clear();

            Project project = ProjectLoader.LoadProject(fileName);
            _projectTreeView.Project = project;
            Application.Current.Properties["Project"] = project;
        }
    }
}