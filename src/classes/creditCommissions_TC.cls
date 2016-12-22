@isTest(seeAllData = true)
public with sharing class creditCommissions_TC
{
    Static testmethod Void MyUnittest(){
    
     User ur = [select id,username from User /* where id=userinfo.getUserId()*/ limit 1];
        
        Campaign c = new Campaign();
        c.Name='Testc';
        c.Type='test';
        c.StartDate =system.today();
        
        insert c;
        
        PBSI__Tax_Code__c tc = new PBSI__Tax_Code__c();
        tc.Name='Testcode';
        insert tc;
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
      /*    c2g__codaPeriod__c period= new c2g__codaPeriod__c();
         list<c2g__codaPeriod__c> perList = new  list<c2g__codaPeriod__c>();
        perList =[select c2g__YearName__c,Name,c2g__PeriodNumber__c,c2g__StartDate__c,c2g__EndDate__c from c2g__codaPeriod__c limit 1];
    
    if(perList.size()>0)
    {
   period =perList[0];
    
    }*/
    
  c2g__codaPeriod__c period=  [select c2g__YearName__c,Name,c2g__PeriodNumber__c,c2g__StartDate__c,c2g__EndDate__c from c2g__codaPeriod__c where c2g__EndDate__c > Today limit 1];
        
    c2g__codaAccountingCurrency__c ac =[select id from c2g__codaAccountingCurrency__c limit 1];
    c2g__codaCreditNote__c  cg =new c2g__codaCreditNote__c();
       cg.c2g__CreditNoteStatus__c='In Progress';
        
        cg.c2g__Opportunity__c=opp.id;
        cg.c2g__Period__c = period.id;
        cg.c2g__CreditNoteDate__c=system.today();
        cg.c2g__DueDate__c=system.today();
        cg.c2g__CreditNoteCurrency__c=ac.id;
        cg.c2g__Account__c=acc.id;
        cg.c2g__Opportunity__c=opp.id;
        
        insert cg;
        
        
        
        //update cg;
        
        c2g__codaDimension1__c d1= new c2g__codaDimension1__c();
         List<c2g__codaDimension1__c> lstDimension1=new  List<c2g__codaDimension1__c>();
       lstDimension1 = [
        SELECT Id, Name, c2g__ExternalId__c, c2g__ReportingCode__c, c2g__UnitOfWork__c
        FROM c2g__codaDimension1__c limit 1];
      if(lstDimension1.size()>0)
      {
      d1=lstDimension1 [0];
      }
      
       c2g__codaDimension2__c d2= new c2g__codaDimension2__c();
         List<c2g__codaDimension2__c> lstDimension2=new  List<c2g__codaDimension2__c>();
       lstDimension2 = [
        SELECT Id
        FROM c2g__codaDimension2__c limit 1];
      if(lstDimension2.size()>0)
      {
      d2=lstDimension2 [0];
      }
      
       c2g__codaDimension3__c d3= new c2g__codaDimension3__c();
         List<c2g__codaDimension3__c> lstDimension3=new  List<c2g__codaDimension3__c>();
       lstDimension3 = [
        SELECT Id
        FROM c2g__codaDimension3__c limit 1];
      if(lstDimension3.size()>0)
      {
      d3=lstDimension3[0];
      }
      
      c2g__codaCreditNoteLineItem__c line= new c2g__codaCreditNoteLineItem__c();
      
       PBSI__PBSI_Item_Group__c itemGroup = new PBSI__PBSI_Item_Group__c();
       itemGroup.Name = 'Test Item';
       itemGroup.PBSI__Item_Group_Code__c = '123';
       itemGroup.Is_Eligible__c = true;
       
       insert itemGroup;
        
       // Product2 pd =[select id,Item_Group__r.Is_Eligible__c from Product2 where Item_Group__r.Is_Eligible__c=true limit 1];
        
        Product2 pd = new Product2();
        pd.Name = 'Test Product';
        pd.isActive = true;
        pd.Item_Group__c = itemGroup.id;
        
        insert pd;
        
       line.c2g__CreditNote__c=cg.id;
       line.c2g__UnitPrice__c=99;
       line.c2g__Quantity__c=66;
       line.c2g__Dimension1__c=d1.id;
        line.c2g__Dimension2__c=d2.id;
        line.c2g__Dimension3__c=d3.id;
        line.c2g__Product__c=pd.id;
        insert line;
         cg.c2g__CreditNoteStatus__c ='Complete';
         
         update cg;
         
       // List<c2g__codaInvoice__c> invoiceList = [Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Account.Grand_ParentAccount__c,Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Account.parentid,Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c,Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Sales_Person_2__c, id, Ascent2FF__Sales_Order__c ,Ascent2FF__Sales_Order__r.PBSI__Opportunity__c,Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Sales_Person_1__c from c2g__codaInvoice__c 
       // select
          c2g__codaCreditNote__c  cg1 =new c2g__codaCreditNote__c();
       cg1.c2g__CreditNoteStatus__c='In Progress';
       
        cg1.c2g__Opportunity__c=opp.id;
        cg1.c2g__Period__c = period.id;
        cg1.c2g__CreditNoteDate__c=system.today();
        cg1.c2g__DueDate__c=system.today();
        cg1.c2g__CreditNoteCurrency__c=ac.id;
        cg1.c2g__Account__c=acc.id;
        cg1.WS_Recalculate__c=true;
        insert cg1;
        
        
        cg1.WS_Recalculate__c=true;
        //cg1.Void__c=true;
        cg1.c2g__CreditNoteStatus__c='Complete';        
       // update cg1;
        
        
        
        list<c2g__codaCreditNote__c> crList =new list<c2g__codaCreditNote__c>();
         list<String> crList1 =new list<String>();
         crList1.add(cg.id);
         crList1.add(cg1.id);
        crList.add(cg);
        crList.add(cg1);
       CommissionsHandler com =new CommissionsHandler();
         // CommissionsHandler com = new CommissionsHandler();
         if(aList.size()>0)
         {
        String s= aList[0].id;
       
         com.convertId( (s.substring(0,15)));
         }
         try{
           String s= null;
          com.convertId(s);
         }catch(Exception e){}
     // com.convertId(ac.id);
       //com.DebitSalesInvoice(crList1);
       
       // CommissionsHandler c = new CommissionsHandler();
        //    c.CreditSalesInvoice(creditIds);
    
     /* list<c2g__codaCreditNote__c> cgList=  new list<c2g__codaCreditNote__c>();  
      cgList=[select c2g__Account__c,c2g__CopyAccountValues__c,Account_Name_Text__c,
                    c2g__TaxCode1__c,c2g__Opportunity__c,c2g__TaxCode2__c,Ascent2FF__RMA__c,
                    c2g__Dimension1__c,c2g__Dimension2__c,c2g__CreditNoteDate__c,c2g__Transaction__c,
                    c2g__Period__c,c2g__CustomerReference__c,c2g__Invoice__c,c2g__DerivePeriod__c,
                    c2g__InvoiceDate__c,c2g__CreditNoteReason__c,c2g__CreditNoteDescription__c,c2g__CreditNoteStatus__c,
                    c2g__DueDate__c,c2g__PrintStatus__c,c2g__DeriveDueDate__c,c2g__DiscardReason__c,Void__c,
                    c2g__CopyDefaultPrintedTextDefinitions__c from c2g__codaCreditNote__c limit 1 ];
                    if(cgList.size()>0)
                    {
                    cg=cgList[0];
                    }
                    cg.c2g__CreditNoteStatus__c='In Progress';
                    upsert cg;*/
                    
    
    }
 }