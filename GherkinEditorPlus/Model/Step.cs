using System;
using System.Linq;

namespace GherkinEditorPlus.Model
{
    public class Step
    {
        public Step(string text)
        {
            Text = text;
        }

        public string Text { get; private set; }

        public string[] TableHeaders { get; set; }

        public string AsTable()
        {
            if (TableHeaders == null || TableHeaders.Length == 0)
                return null;

            string headersLine =  "|" + string.Join("|", TableHeaders.Select(v => " " + v +  " ")) + "|";
            string dataLine = "|" + string.Join("|", TableHeaders.Select(v => " " + new string(' ', v.Length * 2) + " ")) + "|";

            return headersLine;// + Environment.NewLine + dataLine;
        }
    }
}