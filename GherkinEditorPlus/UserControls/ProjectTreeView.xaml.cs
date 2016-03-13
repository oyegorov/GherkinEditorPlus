using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using GherkinEditorPlus.Model;

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
        public static readonly RoutedEvent FeatureNodeDoubleClickEvent = EventManager.RegisterRoutedEvent("FeatureNodeDoubleClick", RoutingStrategy.Bubble, typeof(FeatureNodeDoubleClickHandler), typeof(ProjectTreeView));

        public ProjectTreeView()
        {
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
    }
}
