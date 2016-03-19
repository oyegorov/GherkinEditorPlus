﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GherkinEditorPlus.Utils
{
    public static class TableFormatter
    {
        private const char VerticalBar = '|';

        public static string PrettyPrint(string tableString)
        {
            string[] lines = tableString.Split(new[] { Environment.NewLine }, StringSplitOptions.RemoveEmptyEntries);

            int firstBarIndex = lines[0].IndexOf(VerticalBar.ToString(), StringComparison.InvariantCultureIgnoreCase);

            string headerOffset = lines[0].Substring(0, firstBarIndex);

            if (headerOffset.Any(c => !char.IsWhiteSpace(c)))
                return tableString;

            int numberOfbars = CalculateBarCount(lines[0]);

            if (lines.Any(l => CalculateBarCount(l) != numberOfbars))
                return tableString;

            List<TableRow> tableRows = new List<TableRow>();

            foreach (string line in lines)
            {
                string[] values = line.Trim().Split(new[] { VerticalBar }, StringSplitOptions.RemoveEmptyEntries).Select(v => v.Trim()).ToArray();

                TableRow tableRow = new TableRow();

                for (int i = 0; i < values.Length; i++)
                    tableRow.Add(i, values[i]);

                tableRows.Add(tableRow);
            }

            StringBuilder result = new StringBuilder();

            for (int i = 0; i < tableRows.Count; i++)
            {
                var tableRow = tableRows[i];
                result.Append(headerOffset);

                result.Append(VerticalBar + " ");

                List<string> values = new List<string>();

                foreach (KeyValuePair<int, string> column in tableRow)
                {
                    int maxColumnLentgh = tableRows.Select(r => r[column.Key].Length).Max();

                    int numberOfWhiteSpacesToadd = maxColumnLentgh - column.Value.Length;

                    values.Add(column.Value + new string(' ', numberOfWhiteSpacesToadd));
                }

                result.Append(string.Join(" | ", values));

                result.Append(" " + VerticalBar);

                if (i != tableRows.Count - 1)
                    result.AppendLine();
            }

            return result.ToString();
        }

        private static int CalculateBarCount(string line)
        {
            return line.Count(c => c == VerticalBar);
        }

        private class TableRow : Dictionary<int, string>
        {
        }
    }
}