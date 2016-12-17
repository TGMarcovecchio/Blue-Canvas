@isTest(seeAllData=true)

public class CountsoldmattressesOnAccountTest{
     public static testMethod void TestCountsoldmattressesOnAccount(){
        test.startTest();
        Referral_Report_Card__c  rrecrd = new Referral_Report_Card__c();
        try{
            User usr =[select id from user where name ='Denise Gentry'];
            c2g__codaCompany__c comp = new c2g__codaCompany__c();
            comp.name ='test-company';
            insert comp;
            Campaign c = new Campaign();
            c.Name='Testc';
            c.Type='test';
            c.StartDate =system.today();        
            insert c;
            
            PBSI__Tax_Code__c tc = new PBSI__Tax_Code__c();
            tc.Name='Testcode';
            insert tc;
            
            Account acc =new Account();
            acc.name = 'test- Account';
            insert acc;
            
            Opportunity opp = new Opportunity();
            opp.Accountid=acc.id;
            opp.Name='TestOpp';
            opp.CloseDate=system.today();
            opp.StageName='Closed Won';
            opp.LeadSource='Direct Sales';
            opp.Type='New Business';
            opp.Purchase_Method__c='Online';
            opp.Primary_Reason_for_Purchasing_a__c='Back Pain';
            opp.Type_of_Mattress_do_you_currently_sleep__c='Other';
            opp.Sales_Person_1__c=usr.id;
            opp.PBSI__Tax_Code__c=tc.id;
            opp.Campaignid=c.id;
            opp.Referral_Partner_Id__c=acc.id;
            opp.Sales_Person_1__c=userinfo.getUserId();
            opp.Sales_Person_2__c =userinfo.getUserId();
            
            insert opp;
            
            PBSI__PBSI_Sales_Order__c sr= new PBSI__PBSI_Sales_Order__c();
            sr.PBSI__Order_Date__c=system.today();
            sr.PBSI__Opportunity__c=opp.id;
            insert sr;
            
            c2g__codaPeriod__c p= [select id from c2g__codaPeriod__c limit 1];
            
            PBSI__PBSI_Item_Group__c itemgroup = new PBSI__PBSI_Item_Group__c();
            itemgroup.name = 'test - item';
            itemgroup.PBSI__Item_Group_Code__c = '100';
            insert itemgroup;
            
            
            rrecrd.Period__c = p.id;
            rrecrd.Item_Group__c = itemgroup.id;
            rrecrd.Account__c = acc.id;
             
            c2g__codaInvoice__c sl = [select id from c2g__codaInvoice__c  limit 1];
            
        
            Product2 pd = new Product2();
            pd.Name = 'Test Product';
            pd.isActive = true;
            pd.Item_Group__c = itemGroup.id;
        
            insert pd;
        
            c2g__codaInvoiceLineItem__c  cl = new c2g__codaInvoiceLineItem__c();
            
            cl.c2g__Invoice__c=sl.id;
            cl.c2g__Product__c=pd.id;
            cl.c2g__Quantity__c=2;
            cl.c2g__OwnerCompany__c =comp.id;
            cl.c2g__UnitPrice__c=10;
            cl.c2g__DeriveUnitPriceFromProduct__c=false;
            insert cl;
        
           
                
            Gamification_Document__c gampsold = new Gamification_Document__c();
            gampsold.Quantity_Sold__c = 2;
            gampsold.Referral_Report__c = rrecrd.id;
            gampsold.Sales_Invoice_Line_Item__c = cl.id;
            insert gampsold;
            
          }catch(Exception e){} 
            
          insert rrecrd;  
          rrecrd.Net_Value_Roll_Up__c = 23;
          update rrecrd;
        test.stopTest();
     }
}