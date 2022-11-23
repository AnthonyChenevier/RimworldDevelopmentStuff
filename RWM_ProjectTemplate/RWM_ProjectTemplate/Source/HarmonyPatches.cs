// HarmonyPatches.cs
// 
// Location for any required Harmony patches for the mod


namespace $safeprojectname$
{

    //Examples of some patches. Delete whatever you want

    //[HarmonyPatch(typeof(DefGenerator), "GenerateImpliedDefs_PreResolve")]
    //internal class DefGenerator_Patcher
    //{
    //    [HarmonyPostfix]
    //    private static void GenerateImpliedDefs_PreResolve_Postfix()
    //    {

    //    }
    //}


    //[HarmonyPatch(typeof(Pawn))]
    //internal class Pawn_Patcher
    //{
    //    [HarmonyPostfix]
    //    [HarmonyPatch("HealthScale", MethodType.Getter)]
    //    private static void HealthScale_Postfix(Pawn __instance, ref float __result)
    //    {

    //    }
    //}


    //[HarmonyPatch(typeof(FoodUtility), "IsHumanlikeMeat")]
    //internal class FoodUtility_Patcher
    //{
    //    [HarmonyPostfix]
    //    private static void IsHumanlikeMeat_Postfix(ThingDef def, ref bool __result)
    //    {

    //    }
    //}

    ////these next 2 are conditional based on the existence of the Alien Race Framework
    ////this one supports Xenophobic aliens. Hooray...?
    //[HarmonyPatch]
    //[HarmonyAfter("rimworld.erdelf.alien_race.main")]
    //internal class FoodUtility_ARF_Patcher
    //{
    //    [HarmonyPrepare]
    //    private static bool Prepare()
    //    {
    //        bool frameworkExists = BloodBankMod.Instance.AlienFrameworkExists;
    //        if (frameworkExists) Debug.Log("Running ARF specific FoodUtility.ThoughtsFromIngesting patch");
    //        return frameworkExists;
    //    }

    //    private static MethodBase TargetMethod()
    //    {
    //        return AccessTools.DeclaredMethod(typeof(FoodUtility), nameof(FoodUtility.ThoughtsFromIngesting));
    //    }

    //    [HarmonyPostfix]
    //    private static void ThoughtsFromIngesting_Postfix(Pawn ingester, Thing foodSource, ThingDef foodDef, ref List<ThoughtDef> __result)
    //    {

    //    }

    //}

    ////this one leaves out the check. Not much of an optimization, but I learned things!
    //[HarmonyPatch]
    //internal class FoodUtility_Vanilla_Patcher
    //{
    //    [HarmonyPrepare]
    //    private static bool Prepare()
    //    {
    //        bool frameworkExists = BloodBankMod.Instance.AlienFrameworkExists;
    //        if (!frameworkExists) Debug.Log("Running vanilla FoodUtility.ThoughtsFromIngesting patch");
    //        return !frameworkExists;
    //    }

    //    private static MethodBase TargetMethod()
    //    {
    //        return AccessTools.DeclaredMethod(typeof(FoodUtility), nameof(FoodUtility.ThoughtsFromIngesting));
    //    }

    //    [HarmonyPostfix]
    //    private static void ThoughtsFromIngesting_Postfix(Pawn ingester, Thing foodSource, ThingDef foodDef, ref List<ThoughtDef> __result)
    //    {

    //    }
    //}
}
