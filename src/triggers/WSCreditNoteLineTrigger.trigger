trigger WSCreditNoteLineTrigger on c2g__codaCreditNoteLineItem__c (after insert, after update){

	// Grab your Custom Setting values
    WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
    Boolean  TriggerOff = settings.Turn_Off_All_APEX_Triggers__c;
    Boolean  AllTriggersOff = settings.Turn_Off_All_APEX_Triggers__c;

    //Only do something if TriggerOff is False
    if(TriggerOff == FALSE && AllTriggersOff == FALSE){

        if(checkRecursive.runOnce()){

        	//List<c2g__codaCreditNoteLineItem__c> lstLines = new List<c2g__codaCreditNoteLineItem__c>();
            Set<Id> lineids = new Set<Id>();
                
                for (c2g__codaCreditNoteLineItem__c line : Trigger.new){
           
                            if(line.c2g__Dimension1__c == NULL){
                            lineids.add(line.id);
    				}
                }

            if (!lineids.isEmpty()) WSFFSalesCreditNoteLineTools.setDim13FFSalesCreditNoteLine(lineids);  
             
        }

    }

}