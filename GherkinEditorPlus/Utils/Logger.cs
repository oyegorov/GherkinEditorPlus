using log4net;

namespace GherkinEditorPlus.Utils
{
    public static class Logger
    {
        private static readonly ILog _logger = LogManager.GetLogger(typeof (App));

        public static ILog Instance => _logger;
    }
}