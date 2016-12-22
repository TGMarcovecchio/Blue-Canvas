/**
 * Auto Generated and Deployed by the Declarative Lookup Rollup Summaries Tool package (dlrs)
 **/
@IsTest
private class dlrs_PBSI_Serial_Number_TrackerTest
{
    @IsTest
    private static void testTrigger()
    {
        // Force the dlrs_PBSI_Serial_Number_TrackerTrigger to be invoked, fails the test if org config or other Apex code prevents this.
        dlrs.RollupService.testHandler(new PBSI__Serial_Number_Tracker__c());
    }
}