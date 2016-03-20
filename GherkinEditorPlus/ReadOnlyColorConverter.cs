using System;
using System.Globalization;
using System.Windows.Data;
using System.Windows.Media;

namespace GherkinEditorPlus
{
    public class ReadOnlyColorConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            bool booleanValue = (bool) value;

            return booleanValue ? new SolidColorBrush(Color.FromRgb(255, 235, 250)) : new SolidColorBrush(Colors.White);
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}