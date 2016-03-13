namespace GherkinEditorPlus.Model
{
    public class Step
    {
        public Step(string text)
        {
            Text = text;
        }

        public string Text { get; private set; }
    }
}