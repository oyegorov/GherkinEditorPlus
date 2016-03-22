using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Threading;
using System.Xml;
using GherkinEditorPlus.Model;
using GherkinEditorPlus.Utils;
using ICSharpCode.AvalonEdit.CodeCompletion;
using ICSharpCode.AvalonEdit.Document;
using ICSharpCode.AvalonEdit.Folding;
using ICSharpCode.AvalonEdit.Highlighting;

namespace GherkinEditorPlus.UserControls
{
    /// <summary>
    /// Interaction logic for DocumentEditor.xaml
    /// </summary>
    public partial class DocumentEditor : UserControl
    {
        private string[] stepKeywords = { "When ", "Then ", "And ", "Given " };
        private string[] finalKeywords = { "Scenario: ", "Scenario Outline: ", "Background: ", "Examples: ", "Feature: " };

        private CompletionWindow _completionWindow;
        private readonly Languages _languages;

        private readonly Step[] _steps;

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
            textEditor.TextChanged += TextEditor_TextChanged;            
            var foldingUpdateTimer = new DispatcherTimer { Interval = TimeSpan.FromSeconds(2) };
            foldingUpdateTimer.Tick += Folding_update_timer_tick;
            foldingUpdateTimer.Start();
            _languages = new Languages();
            _completionDataLoader = new CompletionDataLoader();

            Project project = (Project) Application.Current.Properties["Project"];

            _steps = project.GetAllSteps().ToArray();
        }

        private void TextEditor_TextChanged(object sender, EventArgs e)
        {
            if (_completionWindow != null && _completionWindow.Inserting)
            {
                _completionWindow.Inserting = false;
                _completionWindow.Close();

                UpdateAutoComplete();
            }

            Feature.Modified = true;
            Feature.Text = textEditor.Text;
        }

        public Feature Feature
        {
            get { return (Feature)GetValue(FeatureProperty); }
            set { SetValue(FeatureProperty, value); }
        }
        public static readonly DependencyProperty FeatureProperty = DependencyProperty.Register("Feature", typeof(Feature), typeof(DocumentEditor), new PropertyMetadata(FeatureChanged));

        private static void FeatureChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            DocumentEditor self = (DocumentEditor)d;

            var feature = e.NewValue as Feature;
            if (feature != null)
            {
                self.LoadDocument(feature.File);
                feature.Modified = false;
            }
        }

        public void LoadDocument(string documentPath)
        {
            textEditor.Load(documentPath);
            textEditor.SyntaxHighlighting = HighlightingManager.Instance.GetDefinitionByExtension(Path.GetExtension(documentPath));
        }

        protected override void OnPreviewKeyDown(KeyEventArgs e)
        {
            if (textEditor.IsReadOnly && e.Key == Key.Delete)
                e.Handled = true;

            base.OnPreviewKeyDown(e);
        }

        protected override void OnKeyDown(KeyEventArgs e)
        {
            if (prevKey == Key.LeftCtrl && e.Key == Key.F && !Feature.IsReadOnly)
            {
                ProcessTableFormatting(true);
            }
            else if (prevKey == Key.LeftCtrl && e.Key == Key.Space && !Feature.IsReadOnly)
            {
                if (UpdateAutoComplete())
                {
                    prevKey = null;
                    e.Handled = true;
                }
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
            if (e.Text == "|")
            {
                ProcessTableFormatting(false);
                return;
            }
            
            if (e.Text != "\n")
                UpdateAutoComplete();
        }

        private bool UpdateAutoComplete()
        {
            if (Feature.IsReadOnly)
                return false;

            var filter = GetCurrentFilter();

            if (!filter.FilteredItems.Any())
            {
                if (_completionWindow != null)
                    _completionWindow.Close();

                _completionWindow = null;
            }
            else
            {
                if (_completionWindow == null)
                {
                    _completionWindow = new CompletionWindow(textEditor.TextArea);
                }

                _completionWindow.completionList.FilterLength = filter.FilterText.Length;

                var data = _completionWindow.CompletionList.CompletionData;

                data.Clear();

                filter.FilteredItems.ForEach(w => data.Add(new GherkinCompletionItem(w.Text, w.Description)));

                _completionWindow.Show();
                _completionWindow.Closed += delegate { _completionWindow = null; };
            }

            return filter.FilteredItems.Any();
        }

        private Filter GetCurrentFilter()
        {
            int column = textEditor.TextArea.Caret.Column;
            var offset = textEditor.Document.GetOffset(textEditor.TextArea.Caret.Line, 1);
            string filter = textEditor.Document.GetText(offset, column - 1).TrimStart();

            CompleionItem[] keywords;

            if (finalKeywords.Any(k => filter.StartsWith(k, StringComparison.InvariantCultureIgnoreCase)))
            {
                keywords = new CompleionItem[0];
            }
            else 
            {
                bool startsWithStepKeyword = false;

                foreach (string gherkinKeyword in stepKeywords)
                {
                    if (filter.StartsWith(gherkinKeyword, StringComparison.InvariantCultureIgnoreCase))
                    {
                        filter = filter.Remove(0, gherkinKeyword.Length);
                        startsWithStepKeyword = true;
                    }
                }

                if (startsWithStepKeyword)
                    keywords = _steps.Select(s => new CompleionItem {Text = s.Text, Description = s.AsTable()}).ToArray();
                else
                    keywords = stepKeywords.Union(finalKeywords).Select(k => new CompleionItem {Text = k}).ToArray();
            }

            if (_completionWindow != null)
                _completionWindow.completionList.FilterLength = filter.Length;

            var filteredItems =
                keywords.Where(
                    w =>
                        w.Text.IndexOf(filter, StringComparison.InvariantCultureIgnoreCase) != -1
                        && filter.Length != w.Text.Length).ToList();

            return new Filter {FilterText = filter, FilteredItems = filteredItems};
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
            if (!char.IsLetterOrDigit(e.Text[0]) && e.Text[0] != 32)
            {
                _completionWindow.CompletionList.RequestInsertion(e);
            }
        }

        private bool ProcessTableFormatting(bool keyFormatting)
        {
            int column = textEditor.TextArea.Caret.Column;

            int currentLineNumber = textEditor.TextArea.Caret.Line;
            var currentLine = textEditor.Document.GetLineByNumber(currentLineNumber);

            if (currentLine.Length == column - 1 || keyFormatting)
            {
                string lineText = textEditor.Document.GetText(currentLine);

                if (lineText.Trim().StartsWith("|") && lineText.Trim().EndsWith("|"))
                {
                    int startingLineNumber = currentLineNumber;

                    StringBuilder table = new StringBuilder();

                    Stack<string> previousLines = new Stack<string>();
                    Queue<string> queue = new Queue<string>();

                    int activeLineNumber = currentLineNumber;
                    var activeLine = textEditor.Document.GetLineByNumber(activeLineNumber);
                    var activeLineText = textEditor.Document.GetText(activeLine);

                    List<DocumentLine> tableLines = new List<DocumentLine>();

                    tableLines.Add(currentLine);

                    while (activeLineNumber > 0)
                    {
                        activeLineNumber--;

                        activeLine = textEditor.Document.GetLineByNumber(activeLineNumber);

                        activeLineText = textEditor.Document.GetText(activeLine);

                        if (activeLineText.Trim().StartsWith("|") && activeLineText.TrimEnd().EndsWith("|"))
                        {
                            tableLines.Add(activeLine);

                            previousLines.Push(activeLineText);
                            startingLineNumber = activeLineNumber;
                            continue;
                        }

                        break;
                    }

                    activeLineNumber = currentLineNumber;

                    while (true)
                    {
                        activeLineNumber++;

                        if (activeLineNumber > textEditor.Document.LineCount)
                            break;

                        activeLine = textEditor.Document.GetLineByNumber(activeLineNumber);

                        activeLineText = textEditor.Document.GetText(activeLine);

                        if (activeLineText.Trim().StartsWith("|") && activeLineText.TrimEnd().EndsWith("|"))
                        {
                            tableLines.Add(activeLine);

                            queue.Enqueue(activeLineText);
                            continue;
                        }

                        break;
                    }

                    while (previousLines.Count > 0)
                    {
                        table.AppendLine(previousLines.Pop());
                    }
                    
                    table.AppendLine(lineText);

                    foreach (var nextLine in queue)
                    {
                        table.AppendLine(nextLine);
                    }

                    string pretty;
                    string ugly = table.ToString();
                    
                    if (TableFormatter.TryPrettyPrint(ugly, out pretty))
                    {
                        var offset = textEditor.Document.GetOffset(startingLineNumber, 1);
                        textEditor.Document.Replace(offset, tableLines.Sum(tl => tl.Length) + tableLines.Count * 2 - 2, pretty);

                        return true;
                    }
                }
            }

            return false;
        }

        private class Filter
        {
            public string FilterText { get; set; }
            public List<CompleionItem> FilteredItems { get; set; } 
        }

        private class CompleionItem
        {
            public string Text { get; set; }
            public string Description { get; set; }
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
