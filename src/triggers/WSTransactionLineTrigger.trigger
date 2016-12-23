trigger WSTransactionLineTrigger on c2g__codaTransactionLineItem__c (after insert, after update){

	// Grab your Custom Setting values
    WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
    Boolean  TriggerOff = settings.Turn_Off_Transaction_Line_Trigger__c;
    Boolean  AllTriggersOff = settings.Turn_Off_All_APEX_Triggers__c;

    //Only do something if TriggerOff is False
    if(TriggerOff == FALSE && AllTriggersOff == FALSE){

        if(checkRecursive.runOnce()){

            //List<c2g__codaTransactionLineItem__c> lstLines = new List<c2g__codaTransactionLineItem__c>();
            Set<Id> lineids = new Set<Id>();
                    
            for (c2g__codaTransactionLineItem__c tl : Trigger.new){
                if(tl.c2g__Dimension1__c == NULL){ //tl.Document_Number__c.left(3) == 'SIN' && ()
                        //lstLines.add(tl);
                        lineids.add(tl.id);
                }
            }

            /*if (!lstLines.isEmpty()){
                WSFFTransactionLineTools.setDim13FFTranLine(lstLines);   
            }*/

            if (!lineids.isEmpty()){
                WSFFTransactionLineTools.setDim13FFTranLine(lineids);   
            } 
            
        }

    }

}