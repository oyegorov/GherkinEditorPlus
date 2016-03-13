﻿using System.Collections.Generic;
using System.Linq;
using GherkinEditorPlus.Utils;

namespace GherkinEditorPlus.Model
{
    public class Project : Folder
    {
        public Project(string name, IEnumerable<Feature> features, IEnumerable<Folder> folders):base(name, features, folders)
        {
        }

        public Step[] GetAllSteps()
        {
            return
                Folders.SelectMany(
                    f =>
                        f.Folders
                            .SelectMany(fo => fo.Features)
                            .SelectMany(fe => fe.Scenarios)
                            .SelectMany(fe => fe.Steps))
                    .Union(
                        Folders.SelectMany(fo => fo.Features).SelectMany(fe => fe.Scenarios).SelectMany(fe => fe.Steps))
                    .DistinctBy(s => s.Text)
                    .ToArray();
        }

        public override string ToString()
        {
            return $"Project Name: '{Name}'";
        }
    }
}
