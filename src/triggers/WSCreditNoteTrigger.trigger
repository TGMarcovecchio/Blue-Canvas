trigger WSCreditNoteTrigger on c2g__codaCreditNote__c (before insert) {

	// Grab your Custom Setting values
    WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
    Boolean  TriggerOff = settings.Turn_Off_All_APEX_Triggers__c;
    Boolean  AllTriggersOff = settings.Turn_Off_All_APEX_Triggers__c;

    //Only do something if TriggerOff is False
    if(TriggerOff == FALSE && AllTriggersOff == FALSE){

    	List<c2g__codaCreditNote__c> lstnotes = new List<c2g__codaCreditNote__c>();
            
            for (c2g__codaCreditNote__c note : Trigger.new){
       
                        if(note.c2g__Dimension1__c == NULL || note.c2g__Opportunity__c == NULL){
                        lstnotes.add(note);
				}
            }

        if (!lstnotes.isEmpty()) WSSalesCreditNoteTools.setDim13FFSalesCreditNote(lstnotes);   

    }

}