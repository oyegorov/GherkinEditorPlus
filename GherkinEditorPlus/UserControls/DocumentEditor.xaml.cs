﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Threading;
using System.Xml;
using GherkinEditorPlus.Model;
using GherkinEditorPlus.Utils;
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
        private string[] stepKeywords = new[] { "When ", "Then ", "And ", "Given " };
        private string[] finalKeywords = { "Scenario: ", "Scenario Outline: ", "Background: " };

        private CompletionWindow _completionWindow;
        private readonly Languages _languages;

        private readonly string[] _steps;

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

            _steps = project.GetAllSteps().Select(s => s.Text).ToArray();
        }

        private void TextEditor_TextChanged(object sender, EventArgs e)
        {
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

        protected override void OnKeyDown(KeyEventArgs e)
        {
            if (prevKey == Key.LeftCtrl && e.Key == Key.Space)
            {
                if (_completionWindow != null)
                {
                    e.Handled = true;
                    return;
                }

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

            if (_completionWindow != null)
            {
                var data = _completionWindow.CompletionList.CompletionData;

                var filter = GetCurrentFilter();

                if (!filter.FilteredItems.Any())
                {
                    _completionWindow.Close();
                    _completionWindow = null;
                }
                else
                {
                    data.Clear();

                    filter.FilteredItems.ForEach(w => data.Add(new GherkinCompletionItem(w)));
                }
            }

            showAutoComplete = false;
        }

        private void DisplayAutoComplete()
        {
            _completionWindow = new CompletionWindow(textEditor.TextArea);
            var data = _completionWindow.CompletionList.CompletionData;

            var filter = GetCurrentFilter();
            filter.FilteredItems.ForEach(w => data.Add(new GherkinCompletionItem(w)));

            _completionWindow.Show();
            _completionWindow.Closed += delegate { _completionWindow = null; };
        }

        private Filter GetCurrentFilter()
        {
            int column = textEditor.TextArea.Caret.Column;
            var offset = textEditor.Document.GetOffset(textEditor.TextArea.Caret.Line, 0);
            string filter = textEditor.Document.GetText(offset, column).TrimStart();

            string[] keywords;

            if (finalKeywords.Any(k => filter.StartsWith(k, StringComparison.InvariantCultureIgnoreCase)))
            {
                keywords = new string[0];
            }
            else 
            {
                bool startsWithGherkinVerb = false;

                foreach (string gherkinKeyword in stepKeywords)
                {
                    if (filter.StartsWith(gherkinKeyword, StringComparison.InvariantCultureIgnoreCase))
                    {
                        filter = filter.Remove(0, gherkinKeyword.Length);
                        startsWithGherkinVerb = true;
                    }
                }

                if (startsWithGherkinVerb)
                    keywords = _steps;
                else
                    keywords = stepKeywords.Union(finalKeywords).ToArray();
            }

            if (_completionWindow != null)
                _completionWindow.completionList.FilterLength = filter.Length;

            var filteredItems =
                keywords.Where(
                    w =>
                        w.IndexOf(filter, StringComparison.InvariantCultureIgnoreCase) != -1
                        && filter.Length != w.Length).ToList();

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

        private class Filter
        {
            public string FilterText { get; set; }
            public List<string> FilteredItems { get; set; } 
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
