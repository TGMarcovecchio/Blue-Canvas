trigger WSSOLineTax on PBSI__PBSI_Sales_Order_Line__c (before update, before insert, after insert) {
 
     // Grab your Custom Setting values
    WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
    Boolean  AllTriggersOff = settings.Turn_Off_All_APEX_Triggers__c;
    Boolean  ThisTriggerOff = settings.Turn_Off_SO_Line_Tax_Trigger__c;
  
    if(AllTriggersOff == FALSE && ThisTriggerOff == FALSE){

        List<PBSI__PBSI_Sales_Order_Line__c> lstSOLs = new List<PBSI__PBSI_Sales_Order_Line__c>();
        List<PBSI__PBSI_Sales_Order_Line__c> lstSOLs2 = new List<PBSI__PBSI_Sales_Order_Line__c>();

        List<PBSI__PBSI_Sales_Order_Line__c> lstSOLs3 = new List<PBSI__PBSI_Sales_Order_Line__c>();
        List<PBSI__PBSI_Sales_Order_Line__c> lstSOLs4 = new List<PBSI__PBSI_Sales_Order_Line__c>();

        List<PBSI__PBSI_Sales_Order_Line__c> lstSOLs5 = new List<PBSI__PBSI_Sales_Order_Line__c>();
    
        //do this if the trigger is on an update
        if(Trigger.IsUpdate && Trigger.IsBefore) {
            
            for( PBSI__PBSI_Sales_Order_Line__c newSOL : trigger.new ){
            
                if (newSOL.Ascent2FF__Tax_Code_1__c == Null && newSOL.Sales_Order_Status__c != 'Closed'){
                        
                    lstSOLs.add(newSOL);  // add the SO line to the list
                 }

                 else

                 if (newSOL.Ascent2FF__Tax_Code_1__c != NULL && newSOL.Sales_Order_Status__c != 'Closed'){

                    lstSOLs2.add(newSOL);

                 }
            
            }

        }//End After Update
        
        
        
        // do this if the Trigger is on an insert
        if (Trigger.IsInsert && Trigger.IsBefore){
            
            for( PBSI__PBSI_Sales_Order_Line__c newSOL2 : trigger.new ){
                
               if (newSOL2.Ascent2FF__Tax_Code_1__c == Null){
                   
                lstSOLs3.add(newSOL2); // add the Lead to the List of Leads
                   
               }

               else

               if(newSOL2.Ascent2FF__Tax_Code_1__c != Null){

                lstSOLs4.add(newSOL2);

               }
                
             }
              

        }//End Before Insert

        // do this after an SO Line insert
        if(Trigger.isInsert && Trigger.isAfter){

            for(PBSI__PBSI_Sales_Order_Line__c newSOL3 : trigger.new){

                lstSOLs5.add(newSOL3); //Add all new SO Lines to the list
            
            }

        }//End After Insert

        //Set the SalesOrderLine Tax
        if (!lstSOLs.isEmpty())WSSOLineTools.trWSSOLineTaxCode(lstSOLs);
        if (!lstSOLs.isEmpty())WSSOLineTools.WSSOLineTaxRound(lstSOLs2);

        //Set The QuoteLine Tax
        if (!lstSOLs3.isEmpty())WSSOLineTools.trWSSOLineTaxCode(lstSOLs3);
        if (!lstSOLs4.isEmpty())WSSOLineTools.WSSOLineTaxRound(lstSOLs4);

        //Insert new Price History Lines
        if(!lstSOLs5.isEmpty())WSSOLineTools.createSOLineHistory(lstSOLs5); 


        } //End is the trigger actually on
   
}