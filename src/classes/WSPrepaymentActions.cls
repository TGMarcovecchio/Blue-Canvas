global class WSPrepaymentActions {
    
    webservice static Integer createPrepaymentJournal(String pPAYIDs){
        List<string> lstPAYIDs = new List<string>(); //A list of PAYIDs
        Set<ID> PAYIDs = new Set<ID>();
        string msg = '';
        integer n;
        
        // Grab your Custom Setting values
        WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
        Boolean  ThisAPEXOff = settings.Turn_Off_Batch_Create_Prepayment_Journal__c;
  
        if(ThisAPEXOff == false){
        
        if (pPAYIDs != null && pPAYIDs != '') {
            lstPAYIDs = pPAYIDs.split(',');
            for (string s : lstPAYIDs) PAYIDs.add(s);
            
        List<Prepayment__c> lstPAY=
            [SELECT Id, Account_Id__c, Amount__c, ConnectionReceivedId, ConnectionSentId, Cash_Entry__c,
            CreatedById, CreatedDate, Date_of_Payment__c, IsDeleted, LastModifiedById, Name,
            LastModifiedDate, LastReferencedDate, LastViewedDate, Method__c, Journal__c,
            Opportunity__c, Origin__c, Processing_Fees__c, Reference__c, SystemModstamp 
            FROM Prepayment__c 
            WHERE Id IN :PAYIDs];
 
         //Check to see if lstInv is populated 
         if (!lstPAY.isEmpty()) {
 
 
            // Call the Flow --- Must be trigger ready flow
            Map<String, Object> params = new Map<String, Object>();
            params.put('CustomerPrepayments', lstPAY);
            Flow.Interview.WS_Batch_Prepayment_to_Processing_Fee_Journal PrePayJournalFlow = new Flow.Interview.WS_Batch_Prepayment_to_Processing_Fee_Journal (params);
            PrePayJournalFlow.start();
                
            }
            
        }
        }
        
        //How may PAYIDs were processed
        if (PAYIDs == null) n = 0; 
        else {
            n = PAYIDs.size();
        }
        
        return n;
        
    }
    
    webservice static Integer createPrepaymentCashEntry(String pPAYIDs){
        List<string> lstPAYIDs = new List<string>(); //A list of PAYIDs
        Set<ID> PAYIDs = new Set<ID>();
        string msg = '';
        integer n;
        
        // Grab your Custom Setting values
        WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
        Boolean  ThisAPEXOff = settings.Turn_Off_Batch_Cash_Entry_from_PrePay__c;
  
        if(ThisAPEXOff == false){
        
        if (pPAYIDs != null && pPAYIDs != '') {
            lstPAYIDs = pPAYIDs.split(',');
            for (string s : lstPAYIDs) PAYIDs.add(s);
            
        List<Prepayment__c> lstPAY=
            [SELECT Id, Account_Id__c, Amount__c, ConnectionReceivedId, ConnectionSentId, Cash_Entry__c,
            CreatedById, CreatedDate, Date_of_Payment__c, IsDeleted, LastModifiedById, Name,
            LastModifiedDate, LastReferencedDate, LastViewedDate, Method__c, Journal__c,
            Opportunity__c, Origin__c, Processing_Fees__c, Reference__c, SystemModstamp 
            FROM Prepayment__c 
            WHERE Id IN :PAYIDs];
 
         //Check to see if lstInv is populated 
         if (!lstPAY.isEmpty()) {
 
 
            // Call the Flow --- Must be trigger ready flow
            Map<String, Object> params = new Map<String, Object>();
            params.put('CustomerPrepayments', lstPAY);
            Flow.Interview.WS_Batch_Payment_to_Cash_Entry_Translation PrePayJournalFlow = new Flow.Interview.WS_Batch_Payment_to_Cash_Entry_Translation(params);
            PrePayJournalFlow.start();
                
            }
            
        }
        }
        
        //How may PAYIDs were processed
        if (PAYIDs == null) n = 0; 
        else {
            n = PAYIDs.size();
        }
        
        return n;
        
    }
}