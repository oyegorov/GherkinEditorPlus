using System;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows;
using System.Windows.Data;
using System.Windows.Input;
using GherkinEditorPlus.Model;
using GherkinEditorPlus.UserControls;
using GherkinEditorPlus.Utils;

namespace GherkinEditorPlus
{
	public partial class MainWindow
	{
        public ICommand CloseEditedFeatureCommand { get; set; }

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
            InitializeComponent();

            Project project = ProjectLoader.LoadProject(@"..\..\SampleProject\Bdd.PublicApiTests.csproj");
	        _projectTreeView.Project = project;
            CloseEditedFeatureCommand = new DelegateCommand(CloseEditedFeature);
	    }

	    private void OnFeatureNodeDoubleClick(object sender, FeatureNodeDoubleClickEventArgs args)
	    {
            if (!EditedFeatures.Contains(args.Feature))
                EditedFeatures.Add(args.Feature);

	        ActiveFeature = args.Feature;
	    }

        private void CloseEditedFeature(object o)
        {
            var featureToRemove = (Feature) o;
            int newActiveFeatureIndex = Math.Max(EditedFeatures.IndexOf(featureToRemove) - 1, 0);

            EditedFeatures.Remove(featureToRemove);

            if (EditedFeatures.Count != 0)
                ActiveFeature = EditedFeatures[newActiveFeatureIndex];
        }
    }
}