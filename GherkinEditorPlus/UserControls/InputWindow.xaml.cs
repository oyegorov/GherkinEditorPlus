using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using GherkinEditorPlus.Utils;

namespace GherkinEditorPlus.UserControls
{
    /// <summary>
    /// Interaction logic for InputWindow.xaml
    /// </summary>
    public partial class InputWindow : Window
    {
        public ICommand OkCommand { get; set; }
        public ICommand CancelCommand { get; set; }

        public InputWindow(string prompt) : this()
        {
            Prompt = prompt;
        }

        public string Prompt
        {
            get { return (string)GetValue(PromptProperty); }
            set { SetValue(PromptProperty, value); }
        }
        public static readonly DependencyProperty PromptProperty =
            DependencyProperty.Register("Prompt", typeof(string), typeof(InputWindow), new PropertyMetadata(String.Empty));

        public string EnteredText
        {
            get { return (string)GetValue(EnteredTextProperty); }
            set { SetValue(EnteredTextProperty, value); }
        }
        public static readonly DependencyProperty EnteredTextProperty =
            DependencyProperty.Register("EnteredText", typeof(string), typeof(InputWindow), new PropertyMetadata(String.Empty));

        public InputWindow()
        {
            OkCommand = new DelegateCommand((o) => DialogResult = true);
            CancelCommand = new DelegateCommand((o) => Close());

            InitializeComponent();
        }
    }
}
