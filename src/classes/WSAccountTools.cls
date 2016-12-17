global class WSAccountTools {

public static void trNewAccountARAP(Account[] lstAct) {
       
            //Query the WS Custom Admin Settings and return the Default AR and AP GL Ids
            WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
             
                String  AccountARId = settings.Account_AR_GLA_Id__c;   //The AR Id value
                String  AccountAPId = settings.Account_AP_GLA_Id__c;   //The AP Id value
                
            //Main body of method
            
            String aId = '';                                //An account id
            List<Account> lstacc2 = new List<account>();    //A list of accounts to update
             
            for (Account acc : lstAct) {
            
                acc.c2g__CODAAccountsPayableControl__c = AccountAPId;       //Set the Payables Control Reference on the Account
                acc.c2g__CODAAccountsReceivableControl__c = AccountARId;    //Set the Payables Control Reference on the Account
              
                
                lstacc2.add(acc); //Add the accounts to the update list
                
            }
            //update lstacc2;  //update the list
         
}

//======================================TEST METHOD(s) ======================================           
            
// unit test for New Account AR/AP Trigger
    @isTest(SeeAllData=true)
    global static void UnitTest1trNewAccountARAP() {
        string accId = '';                              //An account id
        List<Account> lstAcct = new List<Account>();    //A list of accounts

        
        // Create Some Accounts

        Account a1 = new Account();        //A new test account #1
        a1.Name = 'Test Account 1';        //Give the account the required name and nothing else
        insert a1;                         //insert the new account
        lstAcct.add(a1);                   //Add the account to the list
        
        Account a2 = new Account();       //A new test account #2
        a2.Name = 'Test Account 2';       //Give the account the required name and nothing else
        insert a2;                        //insert the new account
        lstAcct.add(a2);                  //Add the account to the list
        
        WSAccountTools.trNewAccountARAP(lstAcct);  //Test against the list by calling the method
    }       

}