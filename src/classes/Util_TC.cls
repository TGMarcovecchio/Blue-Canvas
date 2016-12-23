@isTest(seeAllData = true)
public with sharing class Util_TC
{
    Static testmethod Void MyUnittest(){
     c2g__codaCreditNote__c  cg1 =new c2g__codaCreditNote__c(); PBSI__Tax_Code__c tc = new PBSI__Tax_Code__c();
        tc.Name='Testcode';
        insert tc;
        
        
     User ur = [select id,username from User /* where id=userinfo.getUserId()*/ limit 1];
        
        Campaign c = new Campaign();
        c.Name='Testc';
        c.Type='test';
        c.StartDate =system.today();
        
        insert c;
           Account a =new Account();
        a.name='tt';
        insert a;
        
        Account acc1 = new Account();
        acc1.Name = 'Test1';
         acc1.parentId=a.id;
        insert acc1;
        
        Account acc = new Account();
        acc.Name = 'Test';
        acc.parentId=acc1.id;
        acc.Grand_ParentAccount__c=acc1.id;
        insert acc;
        list<Account> aList=new list<Account>();
        aList.add(a);
      
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
       opp.Sales_Person_1__c=ur.id;
        opp.PBSI__Tax_Code__c=tc.id;
        opp.Campaignid=c.id;
        opp.Referral_Partner_Id__c=acc.id;
        opp.Referral_Partner_Id__c=acc.id;
        opp.Sales_Person_1__c=userinfo.getUserId();
        opp.Sales_Person_2__c =userinfo.getUserId();
        
        insert opp;
        
        PBSI__PBSI_Sales_Order__c sr= new PBSI__PBSI_Sales_Order__c();
        sr.PBSI__Order_Date__c=system.today();
        sr.PBSI__Opportunity__c=opp.id;
        insert sr;
     
       cg1.c2g__CreditNoteStatus__c='In Progress';
       
        cg1.c2g__Opportunity__c=opp.id;
      //  cg1.c2g__Period__c = period.id;
        cg1.c2g__CreditNoteDate__c=system.today();
        cg1.c2g__DueDate__c=system.today();
      //  cg1.c2g__CreditNoteCurrency__c=ac.id;
        cg1.c2g__Account__c=acc.id;
        cg1.WS_Recalculate__c=true;
        insert cg1;
         List<c2g__codaInvoice__c> invoiceList = [select Name,Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Account.Grand_ParentAccount__c,Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Account.parentid,Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c,Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Sales_Person_2__c, id, Ascent2FF__Sales_Order__c ,Ascent2FF__Sales_Order__r.PBSI__Opportunity__c,Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Sales_Person_1__c from c2g__codaInvoice__c ];
        
        c2g__codaPeriod__c p=[select id from c2g__codaPeriod__c limit 1];
        PBSI__PBSI_Item_Group__c itm=[select id from PBSI__PBSI_Item_Group__c limit 1];
        
        Referral_Report_Card__c rr = new Referral_Report_Card__c();
        rr.Account__c=acc1.id;
        rr.Item_Group__c=itm.id;
        rr.Period__c=p.id;
        insert rr;
        
        list<String> alists =new list<String>();
        alists.add(cg1.id);
        if(invoiceList.size()>0)
        {
        alists.add(invoiceList[0].id);
        }
    Util u =new Util();
   Map<String, Referral_Report_Card__c> invoiceMap1 = new Map<String, Referral_Report_Card__c>();
    
    
    u.Recalculate(alists,invoiceMap1);    
    u.RecalculateNotes(alists);
    
    }
    
  }