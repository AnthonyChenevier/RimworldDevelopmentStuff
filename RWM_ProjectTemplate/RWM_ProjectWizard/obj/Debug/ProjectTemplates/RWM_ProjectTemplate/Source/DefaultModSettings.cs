// $safeprojectname$ModSettings.cs
// 
// Implementation of a vanilla RW mod settings container.
// Hooks up with $safeprojectname$Mod.cs to implement interface.


using Verse;

namespace $safeprojectname$
{
    public class $safeprojectname$ModSettings : ModSettings
    {
        //put setting vars here


        //expose them here
        public override void ExposeData()
        {
            //Debug.Log($"Exposing Setting Data in '{Scribe.mode}' mode.");
            //Scribe_Deep.Look(ref _bloodDefData, "BloodDefProperties");

            base.ExposeData();
        }
    }
}
