using System;
using System.Deployment.Application;
using System.Globalization;
using System.Reflection;
using System.Windows.Data;
using GherkinEditorPlus.Model;

namespace GherkinEditorPlus
{
    class TitleConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            var project = value as Project;

            string version = String.Empty;
            if (ApplicationDeployment.IsNetworkDeployed)
                version = $" ({ApplicationDeployment.CurrentDeployment.CurrentVersion.ToString()})";

            return project == null ? $"Gherkin Editor Plus{version}" : $"Gherkin Editor Plus{version}- {project.File}";
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}