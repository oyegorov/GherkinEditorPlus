using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Windows.Data;
using GherkinEditorPlus.Model;

namespace GherkinEditorPlus.UserControls
{
    public class ProjectItemsConverter : IMultiValueConverter
    {
        public object Convert(object[] values, Type targetType, object parameter, CultureInfo culture)
        {
            var features = values[0] as ICollection<Feature>;
            var folders = values[1] as ICollection<Folder>;

            return folders.Select(f => (object) f).Union(features.Select(f => (object) f)).ToList();
        }

        public object[] ConvertBack(object value, Type[] targetTypes, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
