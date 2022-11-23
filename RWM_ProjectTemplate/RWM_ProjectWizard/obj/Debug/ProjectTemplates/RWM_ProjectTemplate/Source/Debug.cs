// Debug.cs
// 
// Debug log shortcuts to add the mod name to log output automatically


namespace $safeprojectname$
{
    public static class Debug
    {
        public static void Log(string msg)
        {
#if (DEBUG)
            Verse.Log.Message($"$safeprojectname$ :: {msg}");
#endif
        }

        public static void Warning(string msg)
        {
#if (DEBUG)
            Verse.Log.Warning($"$safeprojectname$ :: {msg}");
#endif
        }

        public static void Error(string msg)
        {
#if (DEBUG)
            Verse.Log.Error($"$safeprojectname$ :: {msg}");
#endif
        }
    }

    //use this to output regardless of build state
    public static class RuntimeLog
    {
        public static void Log(string msg) { Verse.Log.Message($"$safeprojectname$ :: {msg}"); }

        public static void Warning(string msg) { Verse.Log.Warning($"$safeprojectname$ :: {msg}"); }

        public static void Error(string msg) { Verse.Log.Error($"$safeprojectname$ :: {msg}"); }
    }
}
