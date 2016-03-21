using System;
using System.Globalization;
using System.Windows.Data;
using GherkinEditorPlus.Model;

namespace GherkinEditorPlus
{
    class TitleConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            var project = value as Project;

            return project == null ? "Gherkin Editor Plus" : $"Gherkin Editor Plus - {project.File}";
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}