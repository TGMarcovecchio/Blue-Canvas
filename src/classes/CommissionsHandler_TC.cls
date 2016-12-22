@isTest(seeAllData = true)
private class CommissionsHandler_TC {
    static testMethod void DebitSalesInvoice() {
        // TO DO: implement unit test   
        
        
        User ur = [select id,username from User /* where id=userinfo.getUserId()*/ limit 1];
        
        Campaign c = new Campaign();
        c.Name='Testc';
        c.Type='test';
        c.StartDate =system.today();
        
        insert c;
        
        PBSI__Tax_Code__c tc = new PBSI__Tax_Code__c();
        tc.Name='Testcode';
        insert tc;
        
        Account acc1 = new Account();
        acc1.Name = 'Test';
        insert acc1;
        
        Account acc = new Account();
        acc.Name = 'Test';
        acc.parentId=acc1.id;
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
        opp.Sales_Person_1__c=ur.id;
        opp.PBSI__Tax_Code__c=tc.id;
        opp.Campaignid=c.id;
        opp.Referral_Partner_Id__c=acc.id;
        
        insert opp;
        
        PBSI__PBSI_Sales_Order__c sr= new PBSI__PBSI_Sales_Order__c();
        sr.PBSI__Order_Date__c=system.today();
        sr.PBSI__Opportunity__c=opp.id;
        insert sr;
        
       /* c2g__codaAccountingCurrency__c ac= new c2g__codaAccountingCurrency__c();
        ac.name='EURO';
        ac.c2g__DecimalPlaces__c =2;
        insert ac;
         
        c2g__codaYear__c y= new c2g__codaYear__c();
        y.name='Test';
        y.c2g__EndDate__c= Date.newInstance(system.today().year()+1,12,31);//Date.today();//Date.newInstance(2015,12,31);?
        y.c2g__StartDate__c= Date.newInstance(system.today().year()+1,1,1);
        y.c2g__NumberOfPeriods__c=12;
        y.c2g__PeriodCalculationBasis__c='Month End';
        
        insert y; 
        
        c2g__codaYear__c y = [select id from c2g__codaYear__c where name='2016' limit 1];
        
        c2g__codaPeriod__c p= new c2g__codaPeriod__c();
        p.Name='test';
        p.c2g__PeriodNumber__c='002';
        p.c2g__StartDate__c=system.today();
        p.c2g__EndDate__c=system.today()+2;
        p.c2g__YearName__c=y.id;
        insert p;
        
        */
        //c2g__codaPeriod__c p= [select id from c2g__codaPeriod__c limit 1];
         c2g__codaPeriod__c p= new c2g__codaPeriod__c();
         list<c2g__codaPeriod__c> perList = new  list<c2g__codaPeriod__c>();
     /*    perList =[select c2g__YearName__c,Name,c2g__PeriodNumber__c,c2g__StartDate__c,c2g__EndDate__c from c2g__codaPeriod__c limit 1];
    
        if(perList.size()>0)
        {
        p =perList[0];
    
         }
       */  
          c2g__codaAccountingCurrency__c ac = new  c2g__codaAccountingCurrency__c();
        
         list< c2g__codaAccountingCurrency__c> perList1 = new  list< c2g__codaAccountingCurrency__c>();
         /*perList1 =[select id from c2g__codaAccountingCurrency__c limit 1];
    
        if(perList1.size()>0)
        {
        ac  =perList1[0];
    
         }
        
        */
       // c2g__codaAccountingCurrency__c ac =[select id from c2g__codaAccountingCurrency__c limit 1];
      c2g__codaCompany__c compp=[select id from c2g__codaCompany__c limit 1];
       List<c2g__codaInvoice__c> sl_list = new List<c2g__codaInvoice__c>();
      /* 
        c2g__codaInvoice__c sl = new c2g__codaInvoice__c();
        sl.c2g__InvoiceDate__c=system.today();
        sl.c2g__DueDate__c=system.today()+2;
        sl.c2g__InvoiceStatus__c='In Progress';
        sl.Ascent2FF__Sales_Order__c=sr.id;
        sl.c2g__InvoiceCurrency__c=ac.id;
        sl.c2g__Account__c=acc.id;
        sl.c2g__Period__c=p.id;
      //  s1.c2g__OwnerCompany__c=compp.id;
        sl.Void__c=false;
        insert sl;*/
        
         c2g__codaInvoice__c ss1 = new  c2g__codaInvoice__c();
         list<c2g__codaInvoice__c> ss1List =new list<c2g__codaInvoice__c>();
         ss1List=[select Name,id,
                         c2g__InvoiceStatus__c,Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c ,
                         Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Sales_Person_2__c
                         from c2g__codaInvoice__c where c2g__InvoiceStatus__c != 'Completed' 
                         and Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Sales_Person_2__c != null 
                         and Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c  != null limit 1];
        if(ss1List.size()>0)
        {
        ss1=ss1List[0];
        }
        // ss1.c2g__InvoiceStatus__c='Completed';
       //  update ss1;
       
        
       /* c2g__codaInvoice__c sl2 = new c2g__codaInvoice__c();
        sl2.c2g__InvoiceDate__c=system.today();
        sl2.c2g__DueDate__c=system.today()+2;
        sl2.c2g__InvoiceStatus__c='In Progress';
        sl2.Ascent2FF__Sales_Order__c=sr.id;
        sl2.c2g__InvoiceCurrency__c=ac.id;
        sl2.c2g__Account__c=acc.id;
        sl2.c2g__Period__c=p.id;
        sl2.Void__c=true;
        insert sl2; */
        
       PBSI__PBSI_Item_Group__c itemGroup = new PBSI__PBSI_Item_Group__c();
       itemGroup.Name = 'Test Item';
       itemGroup.PBSI__Item_Group_Code__c = '121';
       itemGroup.Is_Eligible__c = true;
       
       insert itemGroup;
        
       // Product2 pd =[select id,Item_Group__r.Is_Eligible__c from Product2 where Item_Group__r.Is_Eligible__c=true limit 1];
        
        Product2 pd = new Product2();
        pd.Name = 'Test Product';
        pd.isActive = true;
        pd.Item_Group__c = itemGroup.id;
        
        insert pd;
        
        
        c2g__codaInvoiceLineItem__c  cl = new c2g__codaInvoiceLineItem__c();
        
        cl.c2g__Invoice__c=ss1.id;
        cl.c2g__Product__c=pd.id;
        cl.c2g__Quantity__c=2;
        cl.c2g__UnitPrice__c=10;
        cl.c2g__DeriveUnitPriceFromProduct__c=false;
       // insert cl;
        
        /*c2g__codaInvoiceLineItem__c  cl1 = new c2g__codaInvoiceLineItem__c();
        
        cl1.c2g__Invoice__c=ss1.id;
        cl1.c2g__Product__c=pd.id;
        cl1.c2g__Quantity__c=3;
        cl1.c2g__UnitPrice__c=100;
        cl1.c2g__DeriveUnitPriceFromProduct__c=false;
        insert cl1;*/
         
        ss1.c2g__InvoiceStatus__c='Complete';
        ss1.Void__c=true;
       // update ss1;
      List<c2g__codaCreditNote__c> creditList= [select id, c2g__Opportunity__c, 
                                                       c2g__Opportunity__r.Referral_Partner_Id__c,
                                                       c2g__Opportunity__r.Sales_Person_2__c,
                                                       c2g__Opportunity__r.Sales_Person_1__c  
                                                       from c2g__codaCreditNote__c 
                                                       where c2g__Opportunity__r.Sales_Person_2__c != null 
                                                       and c2g__Opportunity__r.Referral_Partner_Id__c != null]; 
                                                       
      List<RecordType> rtid = [select id,name from RecordType where name = 'Credit' limit 1];
      
      List<String> cid = new List<String>();
      List<String> invid = new List<String>();
      if(creditList.size()>0)
      cid.add(creditList[0].id);
      if(ss1List.size()>0)
      invid.add(ss1List[0].id);
      CommissionsHandler com = new CommissionsHandler();
      com.DebitSalesInvoice(invid);
      if(ss1List.size()>0)
      com.convertId(ss1List[0].Name);
      com.CreditSalesInvoice(cid);
      
            
       }
    

}