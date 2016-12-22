global class WSSalesOrderTools {

    //Set the SO Contact from the Primary Contact on the Original Opportunity
  
    public static void setSOContact(PBSI__PBSI_Sales_Order__c[] lstSOs){
    
    List<PBSI__PBSI_Sales_Order__c> lstSOUpdates = new List<PBSI__PBSI_Sales_Order__c>(); //List of Sale Orders To Update
    Set<ID> oppIDs = new Set<ID>(); //The Set of Opportunity Ids
    Set<ID> SOIds = new Set<ID>(); //The Set of Sales Order Ids
    Map<ID, ID> mapSOtoOPP = new Map<ID, ID>(); //The Map of SalesOrders to Opportunities
    Map<ID, ID> mapOPPtoPRIMARY = new Map<ID, ID>(); //The Map of Opportunities to Primary Contact

    //Generate the set of SO Ids
        for (PBSI__PBSI_Sales_Order__c so: lstSOs){
        oppIDs.add(so.PBSI__Opportunity__c); //Add the Opportunity IDs to the set of OPP Ids
        mapSOtoOPP.put(so.Id, so.PBSI__Opportunity__c);  //Add the SO Id and Opp Id to a map
        }
        
        //Query For Primary Contact Roles who belong to Opportunities in the set of oppIDs and add them to a 
       for (OpportunityContactRole role : 
            [SELECT Id, ContactId, CreatedById, CreatedDate, IsDeleted, IsPrimary, 
            LastModifiedById, LastModifiedDate, OpportunityId, Role, 
            SystemModstamp FROM OpportunityContactRole  
            WHERE OpportunityId IN :oppIDs
            AND IsPrimary = TRUE
            ORDER BY Id ]) {
            mapOPPtoPRIMARY.put(role.OpportunityId, role.ContactId); //Add the Opportunity Id and Contact Id to a Map
            }
  
       //For each Sales Order in the list of Sales Orders update it's Contact using the established ID maps
        for (PBSI__PBSI_Sales_Order__c so2 : lstSOs) {
            so2.PBSI__Contact__c = mapOPPtoPRIMARY.get(mapSOtoOPP.get(so2.Id));  //Set the Contact on the SO
        }
    
    system.debug('dbgx:' + lstSOs.size().format());
   
  }
 
}