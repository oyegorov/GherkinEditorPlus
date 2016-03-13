using GherkinEditorPlus.Model;
using GherkinEditorPlus.UserControls;

namespace GherkinEditorPlus
{
	public partial class MainWindow
	{
	    public MainWindow()
	    {
            InitializeComponent();

            Project project = ProjectLoader.LoadProject(@"..\..\SampleProject\Bdd.PublicApiTests.csproj");
	        _projectTreeView.Project = project;
        }

	    private void OnFeatureNodeDoubleClick(object sender, FeatureNodeDoubleClickEventArgs args)
	    {
	        _documentEditor.LoadDocument(args.Feature.File);
	    }
	}
}