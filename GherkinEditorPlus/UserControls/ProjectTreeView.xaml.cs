using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;
using GherkinEditorPlus.Model;
using GherkinEditorPlus.Utils;

namespace GherkinEditorPlus.UserControls
{
    public delegate void FeatureNodeDoubleClickHandler(object sender, FeatureNodeDoubleClickEventArgs args);

    public class FeatureNodeDoubleClickEventArgs : RoutedEventArgs
    {
        public Feature Feature { get; }

        public FeatureNodeDoubleClickEventArgs(Feature feature)
        {
            if (feature == null)
                throw new ArgumentNullException(nameof(feature));

            Feature = feature;
        }
    }
    
    /// <summary>
    /// Interaction logic for ProjectTreeView.xaml
    /// </summary>
    public partial class ProjectTreeView : UserControl
    {
        public ICommand AddFeatureCommand { get; set; }
        public ICommand AddFolderCommand { get; set; }

        public static readonly RoutedEvent FeatureNodeDoubleClickEvent = EventManager.RegisterRoutedEvent("FeatureNodeDoubleClick", RoutingStrategy.Bubble, typeof(FeatureNodeDoubleClickHandler), typeof(ProjectTreeView));

        public ProjectTreeView()
        {
            AddFeatureCommand = new DelegateCommand(AddFeature, (o) => !Project.IsReadOnly && (_treeView.SelectedItem == null || _treeView.SelectedItem is Folder));
            AddFolderCommand = new DelegateCommand(AddFolder, (o) => !Project.IsReadOnly && (_treeView.SelectedItem == null || _treeView.SelectedItem is Folder));

            InitializeComponent();
        }

        public event FeatureNodeDoubleClickHandler FeatureNodeDoubleClick
        {
            add { AddHandler(FeatureNodeDoubleClickEvent, value); }
            remove { RemoveHandler(FeatureNodeDoubleClickEvent, value); }
        }

        public Project Project
        {
            get { return (Project)GetValue(ProjectProperty); }
            set { SetValue(ProjectProperty, value); }
        }

        public static readonly DependencyProperty ProjectProperty = DependencyProperty.Register("Project", typeof(Project), typeof(ProjectTreeView), new PropertyMetadata(null));

        private static TreeViewItem VisualUpwardSearch(DependencyObject source)
        {
            while (source != null && !(source is TreeViewItem))
                source = VisualTreeHelper.GetParent(source);

            return source as TreeViewItem;
        }

        private void FeatureNodeOnMouseDown(object sender, MouseButtonEventArgs e)
        {
            if (e.ClickCount == 2)
            {
                var souceStackPanel = (StackPanel) sender;

                FeatureNodeDoubleClickEventArgs args = new FeatureNodeDoubleClickEventArgs((Feature)souceStackPanel.DataContext);
                args.RoutedEvent = FeatureNodeDoubleClickEvent;

                RaiseEvent(args);
            }
        }

        private void OnPreviewMouseRightButtonDown(object sender, MouseButtonEventArgs e)
        {
            TreeViewItem treeViewItem = VisualUpwardSearch(e.OriginalSource as DependencyObject);

            if (treeViewItem != null)
            {
                treeViewItem.Focus();
                treeViewItem.IsSelected = true;
            }
            else
            {
                var item = _treeView.ItemContainerGenerator.ContainerFromIndex(0) as TreeViewItem;
                if (item != null)
                {
                    item.IsSelected = true;
                    item.IsSelected = false;
                }
            }
        }

        private void AddFolder(object obj)
        {
            var inputWindow = new InputWindow("Enter new folder name:");
            if (inputWindow.ShowDialog() == true && !String.IsNullOrWhiteSpace(inputWindow.EnteredText))
            {
                ProjectManager.AddFolder(_treeView.SelectedItem as Folder ?? Project, inputWindow.EnteredText);
            }
        }

        private void AddFeature(object obj)
        {
            var inputWindow = new InputWindow("Enter new feature name:");
            if (inputWindow.ShowDialog() == true && !String.IsNullOrWhiteSpace(inputWindow.EnteredText))
            {
                ProjectManager.AddFeature(Project, _treeView.SelectedItem as Folder ?? Project, inputWindow.EnteredText);
            }
        }
    }
}
