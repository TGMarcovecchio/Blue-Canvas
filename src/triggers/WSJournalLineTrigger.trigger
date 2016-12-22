trigger WSJournalLineTrigger on c2g__codaJournalLineItem__c (before insert) {

	// Grab your Custom Setting values
    WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
    Boolean  TriggerOff = settings.Turn_Off_Journal_Line_Trigger__c;
    Boolean  AllTriggersOff = settings.Turn_Off_All_APEX_Triggers__c;

    //Only do something if TriggerOff is False
    if(TriggerOff == FALSE && AllTriggersOff == FALSE){

    	List<c2g__codaJournalLineItem__c> lstLines = new List<c2g__codaJournalLineItem__c>();
            
            for (c2g__codaJournalLineItem__c line : Trigger.new){
       
                        lstLines.add(line);
            }

        if (!lstLines.isEmpty()) WSFFJournalLineTools.setDim13FFJournalLine(lstLines);   

    }

}