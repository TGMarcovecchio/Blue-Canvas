trigger WSTaskTrigger on Task (before insert, before update,after update) {

	// Grab your Custom Setting values
    WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
    Boolean  AllTriggersOff = settings.Turn_Off_All_APEX_Triggers__c;
    Boolean  ThisTriggerOff = settings.Turn_off_Task_Trigger__c;
    Boolean  IntegraParserOff = settings.Turn_off_Integra_Task_Trigger__c;
    Boolean BlockDeleteOff = settings.Turn_Off_Task_Block_Delete__c;
  
    if(AllTriggersOff == FALSE && ThisTriggerOff == FALSE && IntegraParserOff == FALSE){

    List<Task> integratsks = new List<Task>();
    Set<Id> bypassids = new Set<Id>();

        if(Trigger.IsDelete && Trigger.IsBefore){

            for(Task t : trigger.Old){

                if(BlockDeleteOff == FALSE && t.CurrentUserProfile__c != 'System Administrator' && t.CurrentUserProfile__c != 'Sales Manager' && t.OwnerId != UserInfo.getUserId()){

                system.debug(t.id + ' was not deleted by user '+ UserInfo.getUserId());
                t.addError('You do not have the necessary permissions to delete this Task. Please contact your System Administrator.');

                }
            }
        }
    
        //do this if the trigger is on an update
        if(Trigger.IsInsert && Trigger.IsBefore) {

        	for(Task t : trigger.New){

        		/*String tsubject = t.Subject;

        		if(tsubject.contains('Outbound Call from') || tsubject.contains('Inbound Call from')){

        			integratsks.add(t);
        		}*/

                String body = t.Description;
                if(body != NULL && body.contains('DDI/DID:')){
                    integratsks.add(t);
                }

        	}
        }

        if(Trigger.IsUpdate && Trigger.IsBefore) {
            for(Task t : trigger.New){
                if(t.WhoId != Trigger.oldMap.get(t.Id).WhoId){
                     if(String.valueOf(t.WhoId).mid(0,3)=='003' && String.valueOf(Trigger.oldMap.get(t.Id).WhoId).mid(0,3)=='00Q'){
                        t.ByPassValidations__c = TRUE;
                     }

                }
            }

        }

        if(Trigger.IsUpdate && Trigger.IsAfter) {
            for(Task t : trigger.New){
                if(t.ByPassValidations__c == TRUE){
                    bypassids.add(t.Id);
                }
            }
        }


        if(!integratsks.isEmpty()){
			WSTaskTools.IntegraParser(integratsks);
        }

        if(!bypassids.isEmpty()){
            WSTaskTools.ResetBypass(bypassids);
        }

    }

}