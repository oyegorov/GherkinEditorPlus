using System;
using System.IO;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Threading;
using System.Xml;
using ICSharpCode.AvalonEdit.CodeCompletion;
using ICSharpCode.AvalonEdit.Folding;
using ICSharpCode.AvalonEdit.Highlighting;

namespace GherkinEditorPlus.UserControls
{
    /// <summary>
    /// Interaction logic for DocumentEditor.xaml
    /// </summary>
    public partial class DocumentEditor : UserControl
    {
        private CompletionWindow _completionWindow;
        private readonly Languages _languages;

        public DocumentEditor()
        {
            // Load our custom highlighting definition
            IHighlightingDefinition customHighlighting;
            using (
                Stream s = typeof(MainWindow).Assembly.GetManifestResourceStream("GherkinEditorPlus.CustomHighlighting.xshd")
                )
            {
                if (s == null)
                    throw new InvalidOperationException("Could not find embedded resource");
                using (XmlReader reader = new XmlTextReader(s))
                {
                    customHighlighting = ICSharpCode.AvalonEdit.Highlighting.Xshd.
                        HighlightingLoader.Load(reader, HighlightingManager.Instance);
                }
            }
            // and register it in the HighlightingManager
            HighlightingManager.Instance.RegisterHighlighting(
                "Custom Highlighting",
                new[] { ".feature" },
                customHighlighting);

            InitializeComponent();
            textEditor.SyntaxHighlighting = customHighlighting;

            textEditor.TextArea.TextEntering += Text_editor_text_area_text_entering;
            textEditor.TextArea.TextEntered += Text_editor_text_area_text_entered;

            var foldingUpdateTimer = new DispatcherTimer { Interval = TimeSpan.FromSeconds(2) };
            foldingUpdateTimer.Tick += Folding_update_timer_tick;
            foldingUpdateTimer.Start();
            _languages = new Languages();
            _completionDataLoader = new CompletionDataLoader();
        }

        public void LoadDocument(string documentPath)
        {
            textEditor.Load(documentPath);
            textEditor.SyntaxHighlighting = HighlightingManager.Instance.GetDefinitionByExtension(Path.GetExtension(documentPath));
        }

        protected override void OnKeyDown(KeyEventArgs e)
        {
            if (prevKey == Key.LeftCtrl && e.Key == Key.Space)
            {
                prevKey = null;
                showAutoComplete = true;
            }
            else
            {
                prevKey = e.Key;
                showAutoComplete = false;
                base.OnKeyDown(e);
            }
        }

        void Text_editor_text_area_text_entered(object sender, TextCompositionEventArgs e)
        {
            if (showAutoComplete)
            {
                DisplayAutoComplete();
            }
            showAutoComplete = false;
        }

        private void DisplayAutoComplete()
        {
            _completionWindow = new CompletionWindow(textEditor.TextArea);
            var data = _completionWindow.CompletionList.CompletionData;

            if (textEditor.TextArea.Caret.Line == 1 && HasLanguageLine())
            {
                _completionDataLoader.LoadLanguages(data, _languages);
            }
            else
            {
                var language = GetLanguageToLoad();
                _completionDataLoader.LoadDataInto(data, language);
            }

            _completionWindow.Show();
            _completionWindow.Closed += delegate { _completionWindow = null; };
        }

        private bool HasLanguageLine()
        {
            var line = GetLineText(1).Trim().ToLower();
            return (line.StartsWith("#")
                    && line.Contains("language")
                    && line.Contains(":"));
        }

        private string GetDocumentIsoCode()
        {
            if (HasLanguageLine())
            {
                var line = GetLineText(1).Trim().ToLower();
                return line.Split(':')[1].Trim();
            }
            return "en";
        }

        private Language GetLanguageToLoad()
        {
            var isoCode = GetDocumentIsoCode();
            return _languages.Find(l => l.IsoCode == isoCode)
                           ?? new Language("en", "English", "English");
        }

        private string GetLineText(int lineNumber)
        {
            var document = textEditor.TextArea.Document;
            var line = document.GetLineByNumber(lineNumber);
            return document.GetText(line);
        }

        void Text_editor_text_area_text_entering(object sender, TextCompositionEventArgs e)
        {
            if (e.Text.Length <= 0 || _completionWindow == null) return;
            if (!char.IsLetterOrDigit(e.Text[0]))
            {
                _completionWindow.CompletionList.RequestInsertion(e);
            }
        }

        #region Folding
        FoldingManager foldingManager;
        AbstractFoldingStrategy foldingStrategy;
        private Key? prevKey;
        private bool showAutoComplete;
        private readonly CompletionDataLoader _completionDataLoader;

        void Folding_update_timer_tick(object sender, EventArgs e)
        {
            if (foldingStrategy != null)
            {
                foldingStrategy.UpdateFoldings(foldingManager, textEditor.Document);
            }
        }
        #endregion
    }
}
