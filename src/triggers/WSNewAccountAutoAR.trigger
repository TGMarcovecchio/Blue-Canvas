trigger WSNewAccountAutoAR on Account (before insert) {
// Grab WS Admin Custom Settings Values
    WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
    Boolean  TriggerOff = settings.Deactivate_Auto_AR__c;
    Boolean  AllTriggersOff = settings.Turn_Off_All_APEX_Triggers__c;

//Only do something if TriggerOff is False
    if(TriggerOff == FALSE && AllTriggersOff == FALSE){
    
    
    //only pass Accounts from trigger.new that have empty AR/AP id's
        List<Account> lstAct = new List<Account>();
        Set<string> OldActId = new Set<string>();
    
        for (Account acc : Trigger.new){
         
            if (acc.PBSI__Precisio_Type__c == 'Customer'){
            
            if(acc.c2g__CODAAccountsPayableControl__c == Null || acc.c2g__CODAAccountsReceivableControl__c == Null) {
                
                lstAct.add(acc); // Add the account to the list
            }
            }

        if (!lstAct.isEmpty()) WSAccountTools.trNewAccountARAP(lstAct);  //If the list is not empty then run the method against it
            
    } 
    }
}