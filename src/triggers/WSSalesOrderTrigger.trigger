trigger WSSalesOrderTrigger on PBSI__PBSI_Sales_Order__c (before insert) {

// Grab your Custom Setting values
    WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
    Boolean  TriggerOff = settings.Turn_Off_Sales_Order_Trigger__c;
    Boolean  AllTriggersOff = settings.Turn_Off_All_APEX_Triggers__c;

//Only do something if TriggerOff is False
    if(TriggerOff == FALSE && AllTriggersOff == FALSE){
    
    List<PBSI__PBSI_Sales_Order__c> lstSOs = new List<PBSI__PBSI_Sales_Order__c>();
    
    for (PBSI__PBSI_Sales_Order__c SO : Trigger.new)
    
    //Check for a Sales Order Contact. If there isn't one send the SO to WSSalesOrderTools.setSOContact
        
    if (SO.PBSI__Contact__c == NULL && SO.PBSI__Opportunity__c != NULL){
            lstSOs.add(SO);
            }
        
    if (!lstSOs.isEmpty()) WSSalesOrderTools.setSOContact(lstSOs);
    } 
}