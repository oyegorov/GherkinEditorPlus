using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Windows;
using System.Windows.Data;
using System.Windows.Input;
using GherkinEditorPlus.Model;
using GherkinEditorPlus.UserControls;
using GherkinEditorPlus.Utils;
using log4net;
using log4net.Config;
using Microsoft.Win32;
using TechTalk.SpecFlow.Generator;

namespace GherkinEditorPlus
{
	public partial class MainWindow
	{
        public ICommand CloseEditedFeatureCommand { get; set; }
        public ICommand OpenCommand { get; set; }
        public ICommand SaveCommand { get; set; }

	    public static readonly DependencyProperty EditedFeaturesProperty = DependencyProperty.Register("EditedFeaturesProperty", typeof(ObservableCollection<Feature>), typeof(MainWindow), new PropertyMetadata(new ObservableCollection<Feature>()));
        public ObservableCollection<Feature> EditedFeatures
        {
            get { return (ObservableCollection<Feature>)GetValue(EditedFeaturesProperty); }
            set { SetValue(EditedFeaturesProperty, value); }
        }

        public Project ActiveProject
        {
            get { return (Project)GetValue(ActiveProjectProperty); }
            set { SetValue(ActiveProjectProperty, value); }
        }
        public static readonly DependencyProperty ActiveProjectProperty =
            DependencyProperty.Register("ActiveProject", typeof(Project), typeof(MainWindow), new PropertyMetadata(null));

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

            InitializeComponent();

            Logger.Instance.Info("Application started.");
        }

	    private void Save(object obj)
	    {
            if (ActiveFeature != null)
	            SaveFeature(ActiveFeature);
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

            if (!featureToClose.Modified || MessageBox.Show($"Your changes will be lost. Close window?", App.ApplicationName, MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
            {
                int newActiveFeatureIndex = Math.Max(EditedFeatures.IndexOf(featureToClose) - 1, 0);

                EditedFeatures.Remove(featureToClose);

                if (EditedFeatures.Count != 0)
                    ActiveFeature = EditedFeatures[newActiveFeatureIndex];
            }
        }

	    private void LoadProject(string fileName)
	    {
	        Project project = null;
            try
	        {
	            EditedFeatures.Clear();
	            project = ProjectManager.LoadProject(fileName);
	        }
            catch (Exception ex)
            {
                string error = $"Cannot load project {fileName}";

                MessageBox.Show(error, App.ApplicationName, MessageBoxButton.OK, MessageBoxImage.Error);
                Logger.Instance.Error(error, ex);
            }

            _projectTreeView.Project = project;
            Application.Current.Properties["Project"] = project;
	        ActiveProject = project;
	    }

	    private void SaveFeature(Feature feature)
	    {
	        try
	        {
	            ProjectManager.SaveFeature(feature);
	            Logger.Instance.Info($"Feature '{feature.Name}' has been saved successfully");
	        }
	        catch (TestGeneratorException ex)
	        {
                string error = $"Cannot generate code-behind for feature '{feature.Name}' {Environment.NewLine}{ex.Message}";
                MessageBox.Show(error, App.ApplicationName, MessageBoxButton.OK, MessageBoxImage.Error);
                Logger.Instance.Warn(error, ex);
            }
	        catch (Exception ex)
	        {
	            string error = $"Cannot save feature '{feature.Name}'";

	            MessageBox.Show(error, App.ApplicationName, MessageBoxButton.OK, MessageBoxImage.Error);
	            Logger.Instance.Error(error, ex);
	        }
	    }

	    private void WindowClosing(object sender, CancelEventArgs e)
	    {
	        if (EditedFeatures.Any(f => f.Modified))
	        {
	            if (MessageBox.Show("There are unsaved files. All your changes will be lost. \r\nContinue?", App.ApplicationName, MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.No)
	                e.Cancel = true;
	        }
	    }
	}
}