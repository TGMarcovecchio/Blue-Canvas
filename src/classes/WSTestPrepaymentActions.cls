@IsTest(SeeAllData=true)

class WSTestPrepaymentActions{

	//Unit test for Create Journal from Customer Prepayment
	
    @IsTest static void UnitTestcreatePrepaymentJournal () 
    {
    
    List<string> lstPAYIDs = new List<string>(); //A list of PAYIDs
    List<Prepayment__c> lstPAY = new List<Prepayment__c>(); //List of PAYs
    
    String PAYString = ''; //A string of comma delimited Ids to pass to the class.method
    
    // Grab your Custom Setting values
    WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
    Boolean  ThisAPEXOff = settings.Turn_Off_Batch_Create_Prepayment_Journal__c;

    if(ThisAPEXOff == false){
    
    //Generate a list of suitable PAYs
    try{
            for (Prepayment__c payget :
            [SELECT
            Id, Account_Id__c, Amount__c, ConnectionReceivedId, ConnectionSentId, 
			CreatedById, CreatedDate, Date_of_Payment__c, IsDeleted, LastModifiedById, 
			LastModifiedDate, LastReferencedDate, LastViewedDate, Method__c, Name, 
			Opportunity__c, Origin__c, Processing_Fees__c, Reference__c, SystemModstamp 
			FROM Prepayment__c
            LIMIT 1]){
            lstPAY.add(payget);
            }
            
            //Generate the List of Ids
            if (!lstPAY.isEmpty()) {
            for (Prepayment__c pay : lstPAY) {
                 lstPAYIDs.add(pay.Id);
                }
            }

            //Make sure there the list of PAYIDs is not empty 
            if (!lstPAYIDs.isEmpty()) { 

                //Generate the comma delimited string from the list of PAYs
                for(String s : lstPAYIDs) {
                PAYString += s + ',';
                }
        
                // remove last additional comma from string
                PAYString = PAYString.subString(0,PAYString.length());
                
                //Pass the list of strings to the class.method
                WSPrepaymentActions.createPrepaymentJournal(PAYString);
			
            }
        }
        
        //check for exceptions
        catch (QueryException e) {
            system.debug(e);
        }
        }
    }
	
	//Unit Test for Create Cash Entry from Customer PrePayment
	
	@IsTest static void UnitTestcreatePrepaymentCashEntry () 
    {
    
    List<string> lstPAYIDs = new List<string>(); //A list of PAYIDs
    List<Prepayment__c> lstPAY = new List<Prepayment__c>(); //List of PAYs
    
    String PAYString = ''; //A string of comma delimited Ids to pass to the class.method
    
    // Grab your Custom Setting values
    WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
    Boolean  ThisAPEXOff = settings.Turn_Off_Batch_Cash_Entry_from_PrePay__c;

    if(ThisAPEXOff == false){
    
    //Generate a list of suitable PAYs
    try{
            for (Prepayment__c payget :
            [SELECT
            Id, Account_Id__c, Amount__c, ConnectionReceivedId, ConnectionSentId, 
			CreatedById, CreatedDate, Date_of_Payment__c, IsDeleted, LastModifiedById, 
			LastModifiedDate, LastReferencedDate, LastViewedDate, Method__c, Name, 
			Opportunity__c, Origin__c, Processing_Fees__c, Reference__c, SystemModstamp 
			FROM Prepayment__c
            LIMIT 1]){
            lstPAY.add(payget);
            }
            
            //Generate the List of Ids
            if (!lstPAY.isEmpty()) {
            for (Prepayment__c pay : lstPAY) {
                 lstPAYIDs.add(pay.Id);
                }
            }

            //Make sure there the list of PAYIDs is not empty 
            if (!lstPAYIDs.isEmpty()) { 

                //Generate the comma delimited string from the list of PAYs
                for(String s : lstPAYIDs) {
                PAYString += s + ',';
                }
        
                // remove last additional comma from string
                PAYString = PAYString.subString(0,PAYString.length());
                
                //Pass the list of strings to the class.method
				WSPrepaymentActions.createPrepaymentCashEntry(PAYString);
            }
        }
        
        //check for exceptions
        catch (QueryException e) {
            system.debug(e);
        }
        }
    }
}