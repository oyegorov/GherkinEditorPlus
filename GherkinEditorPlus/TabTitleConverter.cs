using System;
using System.Globalization;
using System.Windows.Data;

namespace GherkinEditorPlus
{
    public class TabTitleConverter : IMultiValueConverter
    {
        public object Convert(object[] values, Type targetType, object parameter, CultureInfo culture)
        {
            string name = (string) values[0];
            bool isModified = (bool) values[1];

            return $"{name}{(isModified ? "*" : " ")}";
        }

        public object[] ConvertBack(object value, Type[] targetTypes, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
