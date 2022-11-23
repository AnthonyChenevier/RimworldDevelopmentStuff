// $safeprojectname$Mod.cs
//
// Main mod class implementation and startup sequence hook to interact with the def database.

using System;
using System.Reflection;
using HarmonyLib;
using UnityEngine;
using Verse;

namespace $safeprojectname$
{

    //This class is constructed after defs have loaded, just before the main menu is shown. 
    //This is where any modifications to the def database can be processed. 
    [StaticConstructorOnStartup]
    public class $safeprojectname$ModOnDefsLoaded 
    {
        static $safeprojectname$ModOnDefsLoaded() { }
    }

    //This class holds settings for the mod and is constructed early, before defs are loaded.
    //Therefore it can't do anything that requires defs to be loaded already. This is where Harmony
    //should be initialised if modifications to def generation are required so that changes to the
    //code are actually used
    public class $safeprojectname$Mod : Mod
    {
        public static Mod Instance { get; private set; }
        public $safeprojectname$ModSettings Settings { get; }

        public $safeprojectname$Mod(ModContentPack content) : base(content)
        {
            if (Instance != null)
                throw new Exception("$safeprojectname$ :: ERROR Static class instance already exists on ctor");

            Instance = this;
            Settings = GetSettings< $safeprojectname$ModSettings > ();

            Debug.Log("Processing Harmony Patches");
            var harmony = new Harmony("$packageID$");
            harmony.PatchAll(Assembly.GetExecutingAssembly());
        }

        public override void DoSettingsWindowContents(Rect inRect)
        {
            //show settings in a window. Might be worth adding hugslib for extra setting window support
        }

        public override string SettingsCategory()
        {
            //returns the name of the mod for the settings window
            return "$safeprojectname$";
        }
    }
}
