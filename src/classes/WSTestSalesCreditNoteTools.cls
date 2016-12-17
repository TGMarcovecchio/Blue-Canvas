@IsTest(SeeAllData=true)

class WSTestSalesCreditNoteTools {
	
	@IsTest static void WSTestSalesCreditNoteTools(){

		//Grab your Custom Setting values
        WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
        Boolean  AllTriggersOff = settings.Turn_Off_All_APEX_Triggers__c;
        Boolean  ThisTriggerOff = settings.Turn_Off_SO_Line_Tax_Trigger__c;
      
        if(AllTriggersOff == FALSE && ThisTriggerOff == FALSE){

        Set<ID> SOIDs = new Set<ID>(); //A Set of Sales Order Ids
        Set<Id> IIDs = new Set<Id>(); //A Set of Invoice Ids
        Set<Id> CIDs = new Set<Id>(); //A Set of RMAIds
        Set<Id> SCRIDs = new Set<Id>(); //A Set of Sales Credit Note Ids

        Map<String, ID> Dim1Map = new Map<String, ID>(); //The Map of FF Dimension 1 Names to their Ids
        Map<ID, ID> Dim3Map = new Map<ID,ID>(); //The Map of Campaign Ids to their FF Dimension3 Ids

        List<c2g__codaInvoice__c> lstInvs = new List<c2g__codaInvoice__c>(); //A list of FFA Invoices
    
        List<PBSI__PBSI_Sales_Order_Line__c> lstlns = new List<PBSI__PBSI_Sales_Order_Line__c>();
        List<PBSI__PBSI_Sales_Order_Line__c> uplns = new List<PBSI__PBSI_Sales_Order_Line__c>();

        //Get The Consumer Account Record Type Id

        String accRecType = ([Select Id From RecordType  Where SobjectType = 'Account' and Name = 'Customer']).id;
        String conRecType = ([Select Id From RecordType  Where SobjectType = 'Contact' and Name = 'Customer']).id;

        //Get the FFA Company
        c2g__codaCompany__c Intellibed = [SELECT Id FROM c2g__codaCompany__c LIMIT 1];

        //Find A Period
            c2g__codaPeriod__c openPeriod = new c2g__codaPeriod__c();
            openPeriod = [
            SELECT Id, c2g__Closed__c, c2g__StartDate__c
            FROM c2g__codaPeriod__c
            WHERE c2g__Closed__c =: FALSE
            AND c2g__StartDate__c > YESTERDAY
            LIMIT 1];

        //Create GLAs

        List<c2g__codaGeneralLedgerAccount__c> glas = new List<c2g__codaGeneralLedgerAccount__c>();

        c2g__codaGeneralLedgerAccount__c GLATax = new c2g__codaGeneralLedgerAccount__c();

        GLATax.Name = 'GLATax';
        GLATax.c2g__ReportingCode__c = '0000';
        GLATax.c2g__Type__c = 'Balance Sheet';
        glas.add(GLATax);

        c2g__codaGeneralLedgerAccount__c GLAar = new c2g__codaGeneralLedgerAccount__c();

        GLAar.Name = 'GLAAR';
        GLAar.c2g__ReportingCode__c = '0001';
        GLAar.c2g__Type__c = 'Balance Sheet';
        glas.add(GLAar);

        c2g__codaGeneralLedgerAccount__c GLAap = new c2g__codaGeneralLedgerAccount__c();

        GLAap.Name = 'GLAAP';
        GLAap.c2g__ReportingCode__c = '0002';
        GLAap.c2g__Type__c = 'Balance Sheet';
        glas.add(GLAap);

        c2g__codaGeneralLedgerAccount__c GLAdef = new c2g__codaGeneralLedgerAccount__c();

        GLAdef.Name = 'GLAdef';
        GLAdef.c2g__ReportingCode__c = '0003';
        GLAdef.c2g__Type__c = 'Balance Sheet';
        glas.add(GLAdef);

        insert glas;

        //Create FFA Tax Codes

        List<c2g__codaTaxCode__c> taxcodes = new List<c2g__codaTaxCode__c>();

        c2g__codaTaxCode__c FFATax = new c2g__codaTaxCode__c();

        FFATax.Name = 'Test';
        FFATax.c2g__Description__c = 'Test';
        FFATax.c2g__GeneralLedgerAccount__c = GLATax.id;
        FFATax.c2g__TaxGroup__c = '';
        FFATax.c2g__UnitOfWork__c = 1;
        insert FFATax;

        //Create A FFA Tax Rate

        c2g__codaTaxRate__c FFARate = new c2g__codaTaxRate__c();

        FFARate.c2g__TaxCode__c = FFATax.id;
        FFARate.c2g__Rate__c = 10.00;
        FFARate.c2g__UnitOfWork__c = 1;
        FFARate.c2g__StartDate__c = date.today();

        insert FFARate;

        //Create Two Ascent Tax Codes

        PBSI__Tax_Code__c AscTax = new PBSI__Tax_Code__c();

        AscTax.Name = 'Test';
        AscTax.FF_Tax_Code__c = FFATax.id;
        AscTax.PBSI__Start_Date__c = date.today();
        AscTax.PBSI__End_Date__c = date.today()+1;
        AscTax.PBSI__Description__c = 'Test';
        AscTax.PBSI__Tax_Rate__c = 10.0;

        insert AscTax;

        //Create An Account

        Account acc = new Account();

        acc.Name = 'Test';
        acc.RecordTypeId = accRecType;
        acc.c2g__CODAAccountsReceivableControl__c = GLAar.id;
        acc.PBSI__Tax_Code__c = AscTax.id;
        acc.c2g__CODATaxCode1__c = FFATax.id;
        acc.c2g__CODAIncomeTaxType__c = 'Not Reportable';

        insert acc;

        //Create A Contact

        Contact con = new Contact();

        con.FirstName = 'Test';
        con.LastName = 'Test';
        con.RecordTypeId = conRecType;
        
        con.AccountId = acc.id;
        con.Email = UserInfo.getUserEmail();

        insert con;


        //Create An Ascent Address Tracker Record

        PBSI__Address_Tracker__c addtr = new PBSI__Address_Tracker__c();

        addtr.Name = 'Test Address Tracker';
        addtr.PBSI__Account__c = acc.id;
        addtr.PBSI__Address_line1__c = 'Test Street 1';
        addtr.PBSI__Address_line_2__c = 'Test Street 2';
        addtr.PBSI__Address_line3__c = 'Test Street 3';
        addtr.PBSI__City__c = 'Pittsburgh';
        addtr.PBSI__Contact__c = con.id;
        addtr.PBSI__Country__c = 'USA';
        addtr.PBSI__County__c = 'Allegheny';
        addtr.PBSI__Postal_Code__c = '15102';
        addtr.PBSI__State__c = 'PA';
        addtr.PBSI__Tax_Code__c = AscTax.id;
        addtr.PBSI__Use_AddressTrackerName_for_Delivery_Comp__c = true;

        insert addtr;

        //Create A Warehouse -- Not Used
        //Create A Location  -- Not Used
        //Create An Item Group -- Not Used
        //Create Item Masters  -- Not Used
        //Find Suitable Item Masters

        PBSI__PBSI_Item__c taxableitem = new PBSI__PBSI_Item__c();

        taxableitem = [
        SELECT Id, PBSI__Taxable__c, PBSI__Not_Available_For_Sale__c, PBSI__Item_Type__c, PBSI__Product__c
        FROM PBSI__PBSI_Item__c
        WHERE PBSI__Product__c != NULL and PBSI__Taxable__c = true and PBSI__Not_Available_For_Sale__c = false AND PBSI__Item_Type__c = 'Item'
        LIMIT 1];

        String p1id;
        p1id = taxableitem.PBSI__Product__c; //Id of taxable product

        //Get The Lead Source Values
        List<String> lstLeadSource = new List<String>();
        Schema.DescribeFieldResult fieldResult = Opportunity.LeadSource.getDescribe();
        List<Schema.PicklistEntry> LeadSourceValues = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry v : LeadSourceValues ) {
            lstLeadSource.add(v.getValue());//add the value  to our list
         }

        //Get The Dimension 1 Values Which Correspond to Lead Source Values
        List<c2g__codaDimension1__c> lstDimension1 = [
        SELECT Id, Name, c2g__ExternalId__c, c2g__ReportingCode__c, c2g__UnitOfWork__c
        FROM c2g__codaDimension1__c
        WHERE Name IN: lstLeadSource
        LIMIT 1
        ];


        //Map The Dimension 1 Name to their Ids
        for(c2g__codaDimension1__c d1 : lstDimension1){
            Dim1Map.put(d1.Name, d1.Id);
        }

        //Get The List of Campaigns which have Dimension 3 Specified
        List<Campaign> lstCampaigns = [
        SELECT Id, Name, Dimension_3__c
        FROM Campaign
        WHERE Dimension_3__c != NUll
        LIMIT 1
        ];

        //Map the Campaign Id To Their Dimension 3 Id
        for(Campaign c : lstCampaigns){
            Dim3Map.put(c.Id, c.Dimension_3__c);
        }

        //------------------------------------------

            //Create a Sales Order

            PBSI__PBSI_Sales_Order__c so = new PBSI__PBSI_Sales_Order__c();

            so.PBSI__Order_Date__c = date.today();
            so.PBSI__Address_Tracker__c = addtr.id;
            so.Ascent2FF__Company__c = NULL;
            so.PBSI__Contact__c = con.id;
            so.PBSI__Customer__c = acc.id;
            so.PBSI__Tax_Code__c = AscTax.id;
            so.PBSI__Status__c = 'Open';
            so.PBSI__Stage__c = 'Open';

            insert so;

            SOIDs.add(so.id); //Add the Id to a Set of Ids

            //Create An Opportunity = Lead Source & Campaign = Dim 1 and Dim 3

            Opportunity opp = new Opportunity();
            opp.PBSI__Sales_Order__c = so.id;
            opp.Name = 'Test';
            opp.AccountId = acc.id;
            opp.CloseDate = date.Today();
            opp.StageName = 'Prospecting';
            opp.LeadSource = lstDimension1[0].Name;
            opp.CampaignId = lstCampaigns[0].Id;
            opp.Type = 'Existing Business';
            opp.Purchase_Method__c = 'Call In';
            opp.PBSI__Tax_Code__c = AscTax.id;
            opp.Primary_Reason_for_Purchasing_a__c = 'Back Pain';
            opp.Type_of_Mattress_do_you_currently_sleep__c = 'Other';
            opp.Sales_Person_1__c = UserInfo.getUserId();
            opp.Medical_Type__c = 'Patient';
            insert opp;

            
            //Create Sales Order Lines
            
            PBSI__PBSI_Sales_Order_Line__c theline = new PBSI__PBSI_Sales_Order_Line__c();

            theline.PBSI__Sales_Order__c = so.id;
            theline.PBSI__TransactionType__c ='Sale';
            theline.PBSI__Item__c = taxableitem.id;
            theline.PBSI__Quantity_Needed__c = 1;
            theline.PBSI__Price__c = 10;
            theline.Ascent2FF__Tax_Code_1__c = null; //Insert a taxable line with no tax codes
            insert theline;

                PBSI__PBSI_Location__c loc = [SELECT Id, Name from PBSI__PBSI_Location__c WHERE Name LIKE '%MAIN%'];

                PBSI__Lot__c lot = new PBSI__Lot__c();
                lot.PBSI__Location__c = loc.id;
                lot.PBSI__Item__c = theline.PBSI__Item__c;
                lot.PBSI__Lot_Status__c = 'Released';

                insert lot;

                PBSI__PBSI_Inventory__c inv = new PBSI__PBSI_Inventory__c();
                inv.PBSI__location_lookup__c = loc.id;
                inv.PBSI__Lot__c = lot.id;
                inv.PBSI__qty__c = theline.PBSI__Quantity_Needed__c;
                inv.PBSI__item_lookup__c = theline.PBSI__Item__c;

                insert inv;

                PBSI__Shipped_Sales_Order_Line__c pline = new PBSI__Shipped_Sales_Order_Line__c();

                pline.PBSI__Item__c = theline.PBSI__Item__c;
                pline.PBSI__Shipping_Date__c = date.today();
                pline.PBSI__Shipped_Time__c = datetime.now();
                pline.PBSI__Waranty_Start_Date__c = date.today();
                pline.PBSI__Type__c = 'sale';
                pline.PBSI__Sales_Order_Line__c = theline.Id;
                pline.PBSI__Sales_Order__c = so.id;
                pline.PBSI__Quantity_Shipped__c = theline.PBSI__Quantity_Needed__c;
                pline.PBSI__Price__c = theline.PBSI__Price__c;
                pline.PBSI__Lot__c = lot.id;

                insert pline;

            //Create an RMA .. To SO .. To Opportunity = Lead Source & Campaign = Dim 1 and Dim 3
            Case rma = new Case();
            rma.AccountId = acc.id;
            rma.PBSI__Sales_Order__c = so.id;
            rma.Status = 'New';
            rma.Origin = 'Inbound Call';
            rma.Priority = 'Medium';
            rma.PBSI__Return_Type__c = 'From Customer';
            insert rma;

            PBSI__RMA_Lines__c rmaline = new PBSI__RMA_Lines__c();
            rmaline.PBSI__RMA__c = rma.id;
            rmaline.PBSI__Item__c = theline.PBSI__Item__c;
            rmaline.PBSI__Quantity__c = theline.PBSI__Quantity_Needed__c;
            rmaline.PBSI__Quantity_Received__c = theline.PBSI__Quantity_Needed__c;
            rmaline.PBSI__Reason_RMA_Line__c = 'Other';
            rmaline.PBSI__Sales_Order_Line__c = theline.Id;
            rmaline.PBSI__Cost__c = 100;
            rmaline.PBSI__Type__c = 'Return';
            insert rmaline;

            //Create an FFA Invoice = Dim1 and Dim 3
            c2g__codaInvoice__c SIN = new c2g__codaInvoice__c();
            SIN.c2g__Period__c = openPeriod.Id;
            SIN.c2g__InvoiceDate__c = openPeriod.c2g__StartDate__c;
            SIN.c2g__Dimension1__c = lstDimension1[0].id;
            SIN.c2g__Dimension3__c = lstCampaigns[0].Dimension_3__c;
            SIN.Ascent2FF__Sales_Order__c = so.id;
            SIN.c2g__Account__c = acc.id;
            SIN.c2g__InvoiceStatus__c = 'In Progress';
            insert SIN;

        //Start The Test
        Test.StartTest();

        List<c2g__codaCreditNote__c> lstcrns = new List<c2g__codaCreditNote__c>(); //List of Notes
        List<c2g__codaCreditNoteLineItem__c> lstcnlins = new List <c2g__codaCreditNoteLineItem__c>(); //List of Note Lines

        //for (Integer i = 0, j = 0; i < 5; i++){
            
            c2g__codaCreditNote__c note = new c2g__codaCreditNote__c(); //A Sales Credit Note
            note.c2g__CreditNoteDate__c = openPeriod.c2g__StartDate__c;
            note.c2g__DueDate__c = openPeriod.c2g__StartDate__c.addDays(7);
            note.c2g__Period__c = openPeriod.Id;
            note.c2g__Account__c = acc.id;
            note.Account_Name_Text__c = acc.Name;
            note.c2g__OwnerCompany__c = Intellibed.id;
            note.c2g__TaxCode1__c = FFATax.id;
            note.c2g__CustomerReference__c = 'None';
            note.c2g__CreditNoteReason__c = 'Goods Returned';
            note.c2g__CreditNoteDescription__c = 'Goods returned from customer';
            note.c2g__CreditNoteStatus__c = 'In Progress';
            note.c2g__PrintStatus__c = 'Not Printed';
            note.c2g__Opportunity__c = opp.id;
            note.Ascent2FF__RMA__c = rma.id;
            note.c2g__Opportunity__c = opp.id;
            insert note;

            c2g__codaCreditNoteLineItem__c line = new c2g__codaCreditNoteLineItem__c();
            line.c2g__UnitPrice__c = 1;
            line.c2g__Quantity__c = 1;
            line.c2g__Product__c = taxableitem.PBSI__Product__c;
            line.c2g__CreditNote__c = note.id;
            line.c2g__OwnerCompany__c = Intellibed.id;
            insert line;

            //Post the Note
            c2g.CODAAPICommon.Reference ref2 = new c2g.CODAAPICommon.Reference();
            ref2.Id = note.Id;
            c2g.CODAAPISalesCreditNote_10_0.PostCreditNote(null, ref2);

    
        //End The Test

        Test.StopTest();

    	} //End if Off
		
	} //End isTest static void WSTestSalesCreditNoteTools

    @IsTest static void WSTestSalesCreditNoteTools2(){

        //Grab your Custom Setting values
        WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
        Boolean  AllTriggersOff = settings.Turn_Off_All_APEX_Triggers__c;
        Boolean  ThisTriggerOff = settings.Turn_Off_SO_Line_Tax_Trigger__c;
      
        if(AllTriggersOff == FALSE && ThisTriggerOff == FALSE){

        Set<ID> SOIDs = new Set<ID>(); //A Set of Sales Order Ids
        Set<Id> IIDs = new Set<Id>(); //A Set of Invoice Ids
        Set<Id> CIDs = new Set<Id>(); //A Set of RMAIds
        Set<Id> SCRIDs = new Set<Id>(); //A Set of Sales Credit Note Ids

        Map<String, ID> Dim1Map = new Map<String, ID>(); //The Map of FF Dimension 1 Names to their Ids
        Map<ID, ID> Dim3Map = new Map<ID,ID>(); //The Map of Campaign Ids to their FF Dimension3 Ids

        List<c2g__codaInvoice__c> lstInvs = new List<c2g__codaInvoice__c>(); //A list of FFA Invoices
    
        List<PBSI__PBSI_Sales_Order_Line__c> lstlns = new List<PBSI__PBSI_Sales_Order_Line__c>();
        List<PBSI__PBSI_Sales_Order_Line__c> uplns = new List<PBSI__PBSI_Sales_Order_Line__c>();

        //Get The Consumer Account Record Type Id

        String accRecType = ([Select Id From RecordType  Where SobjectType = 'Account' and Name = 'Customer']).id;
        //String conRecType = ([Select Id From RecordType  Where SobjectType = 'Contact' and Name = 'Customer']).id;

        //Get the FFA Company
        c2g__codaCompany__c Intellibed = [SELECT Id FROM c2g__codaCompany__c LIMIT 1];

        //Find A Period
            c2g__codaPeriod__c openPeriod = new c2g__codaPeriod__c();
            openPeriod = [
            SELECT Id, c2g__Closed__c, c2g__StartDate__c
            FROM c2g__codaPeriod__c
            WHERE c2g__Closed__c =: FALSE
            AND c2g__StartDate__c > YESTERDAY
            LIMIT 1];

        //Create GLAs

        List<c2g__codaGeneralLedgerAccount__c> glas = new List<c2g__codaGeneralLedgerAccount__c>();

        c2g__codaGeneralLedgerAccount__c GLATax = new c2g__codaGeneralLedgerAccount__c();

        GLATax.Name = 'GLATax';
        GLATax.c2g__ReportingCode__c = '0000';
        GLATax.c2g__Type__c = 'Balance Sheet';
        glas.add(GLATax);

        c2g__codaGeneralLedgerAccount__c GLAar = new c2g__codaGeneralLedgerAccount__c();

        GLAar.Name = 'GLAAR';
        GLAar.c2g__ReportingCode__c = '0001';
        GLAar.c2g__Type__c = 'Balance Sheet';
        glas.add(GLAar);

        c2g__codaGeneralLedgerAccount__c GLAap = new c2g__codaGeneralLedgerAccount__c();

        GLAap.Name = 'GLAAP';
        GLAap.c2g__ReportingCode__c = '0002';
        GLAap.c2g__Type__c = 'Balance Sheet';
        glas.add(GLAap);

        c2g__codaGeneralLedgerAccount__c GLAdef = new c2g__codaGeneralLedgerAccount__c();

        GLAdef.Name = 'GLAdef';
        GLAdef.c2g__ReportingCode__c = '0003';
        GLAdef.c2g__Type__c = 'Balance Sheet';
        glas.add(GLAdef);

        insert glas;

        //Create FFA Tax Codes

        List<c2g__codaTaxCode__c> taxcodes = new List<c2g__codaTaxCode__c>();

        c2g__codaTaxCode__c FFATax = new c2g__codaTaxCode__c();

        FFATax.Name = 'Test';
        FFATax.c2g__Description__c = 'Test';
        FFATax.c2g__GeneralLedgerAccount__c = GLATax.id;
        FFATax.c2g__TaxGroup__c = '';
        FFATax.c2g__UnitOfWork__c = 1;
        insert FFATax;

        c2g__codaTaxRate__c FFARate = new c2g__codaTaxRate__c();

        FFARate.c2g__TaxCode__c = FFATax.id;
        FFARate.c2g__Rate__c = 10.00;
        FFARate.c2g__UnitOfWork__c = 1;
        FFARate.c2g__StartDate__c = date.today();

        insert FFARate;

        //Create Two Ascent Tax Codes

        PBSI__Tax_Code__c AscTax = new PBSI__Tax_Code__c();

        AscTax.Name = 'Test';
        AscTax.FF_Tax_Code__c = FFATax.id;
        AscTax.PBSI__Start_Date__c = date.today();
        AscTax.PBSI__End_Date__c = date.today()+1;
        AscTax.PBSI__Description__c = 'Test';
        AscTax.PBSI__Tax_Rate__c = 10.0;

        insert AscTax;

        //Create An Account

        Account acc = new Account();

        acc.Name = 'Test';
        acc.RecordTypeId = accRecType;
        acc.c2g__CODAAccountsReceivableControl__c = GLAar.id;
        acc.PBSI__Tax_Code__c = AscTax.id;
        acc.c2g__CODATaxCode1__c = FFATax.id;
        acc.c2g__CODAIncomeTaxType__c = 'Not Reportable';

        insert acc;

        //Create A Contact

        //Contact con = new Contact();

        //con.FirstName = 'Test';
        //con.LastName = 'Test';
        //con.RecordTypeId = conRecType;
        
        //con.AccountId = acc.id;
        //con.Email = UserInfo.getUserEmail();

        //insert con;


        //Create An Ascent Address Tracker Record

        PBSI__Address_Tracker__c addtr = new PBSI__Address_Tracker__c();

        addtr.Name = 'Test Address Tracker';
        addtr.PBSI__Account__c = acc.id;
        addtr.PBSI__Address_line1__c = 'Test Street 1';
        addtr.PBSI__Address_line_2__c = 'Test Street 2';
        addtr.PBSI__Address_line3__c = 'Test Street 3';
        addtr.PBSI__City__c = 'Pittsburgh';
        //addtr.PBSI__Contact__c = con.id;
        addtr.PBSI__Country__c = 'USA';
        addtr.PBSI__County__c = 'Allegheny';
        addtr.PBSI__Postal_Code__c = '15102';
        addtr.PBSI__State__c = 'PA';
        addtr.PBSI__Tax_Code__c = AscTax.id;
        addtr.PBSI__Use_AddressTrackerName_for_Delivery_Comp__c = true;

        insert addtr;

        //Create A Warehouse -- Not Used
        //Create A Location  -- Not Used
        //Create An Item Group -- Not Used
        //Create Item Masters  -- Not Used
        //Find Suitable Item Masters

        PBSI__PBSI_Item__c taxableitem = new PBSI__PBSI_Item__c();

        taxableitem = [
        SELECT Id, PBSI__Taxable__c, PBSI__Not_Available_For_Sale__c, PBSI__Item_Type__c, PBSI__Product__c
        FROM PBSI__PBSI_Item__c
        WHERE PBSI__Product__c != NULL and PBSI__Taxable__c = true and PBSI__Not_Available_For_Sale__c = false AND PBSI__Item_Type__c = 'Item'
        LIMIT 1];

        String p1id;
        p1id = taxableitem.PBSI__Product__c; //Id of taxable product

        //Get The Lead Source Values
        List<String> lstLeadSource = new List<String>();
        Schema.DescribeFieldResult fieldResult = Opportunity.LeadSource.getDescribe();
        List<Schema.PicklistEntry> LeadSourceValues = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry v : LeadSourceValues ) {
            lstLeadSource.add(v.getValue());//add the value  to our list
         }

        //Get The Dimension 1 Values Which Correspond to Lead Source Values
        List<c2g__codaDimension1__c> lstDimension1 = [
        SELECT Id, Name, c2g__ExternalId__c, c2g__ReportingCode__c, c2g__UnitOfWork__c
        FROM c2g__codaDimension1__c
        WHERE Name IN: lstLeadSource
        LIMIT 1
        ];


        //Map The Dimension 1 Name to their Ids
        //for(c2g__codaDimension1__c d1 : lstDimension1){
        //    Dim1Map.put(d1.Name, d1.Id);
        //}

        //Get The List of Campaigns which have Dimension 3 Specified
        List<Campaign> lstCampaigns = [
        SELECT Id, Name, Dimension_3__c
        FROM Campaign
        WHERE Dimension_3__c != NUll
        LIMIT 1
        ];

        //Map the Campaign Id To Their Dimension 3 Id
        //for(Campaign c : lstCampaigns){
        //    Dim3Map.put(c.Id, c.Dimension_3__c);
        //}

        //------------------------------------------

            //Create a Sales Order

            PBSI__PBSI_Sales_Order__c so = new PBSI__PBSI_Sales_Order__c();

            so.PBSI__Order_Date__c = date.today();
            so.PBSI__Address_Tracker__c = addtr.id;
            so.Ascent2FF__Company__c = NULL;
            //so.PBSI__Contact__c = con.id;
            so.PBSI__Customer__c = acc.id;
            so.PBSI__Tax_Code__c = AscTax.id;
            so.PBSI__Status__c = 'Open';
            so.PBSI__Stage__c = 'Open';

            insert so;

            SOIDs.add(so.id); //Add the Id to a Set of Ids

            //Create An Opportunity = Lead Source & Campaign = Dim 1 and Dim 3

            Opportunity opp = new Opportunity();
            opp.PBSI__Sales_Order__c = so.id;
            opp.Name = 'Test';
            opp.AccountId = acc.id;
            opp.CloseDate = date.Today();
            opp.StageName = 'Prospecting';
            opp.LeadSource = lstDimension1[0].Name;
            opp.CampaignId = lstCampaigns[0].Id;
            opp.Type = 'Existing Business';
            opp.Purchase_Method__c = 'Call In';
            opp.PBSI__Tax_Code__c = AscTax.id;
            opp.Primary_Reason_for_Purchasing_a__c = 'Back Pain';
            opp.Type_of_Mattress_do_you_currently_sleep__c = 'Other';
            opp.Sales_Person_1__c = UserInfo.getUserId();
            opp.Medical_Type__c = 'Patient';
            insert opp;

            
            //Create Sales Order Lines
            
            PBSI__PBSI_Sales_Order_Line__c theline = new PBSI__PBSI_Sales_Order_Line__c();

            theline.PBSI__Sales_Order__c = so.id;
            theline.PBSI__TransactionType__c ='Sale';
            theline.PBSI__Item__c = taxableitem.id;
            theline.PBSI__Quantity_Needed__c = 1;
            theline.PBSI__Price__c = 10;
            theline.Ascent2FF__Tax_Code_1__c = null; //Insert a taxable line with no tax codes
            insert theline;


                /*PBSI__PBSI_Location__c loc = [SELECT Id, Name from PBSI__PBSI_Location__c WHERE Name LIKE '%MAIN%'];

                PBSI__Lot__c lot = new PBSI__Lot__c();
                lot.PBSI__Location__c = loc.id;
                lot.PBSI__Item__c = theline.PBSI__Item__c;
                lot.PBSI__Lot_Status__c = 'Released';

                insert lot;

                PBSI__PBSI_Inventory__c inv = new PBSI__PBSI_Inventory__c();
                inv.PBSI__location_lookup__c = loc.id;
                inv.PBSI__Lot__c = lot.id;
                inv.PBSI__qty__c = theline.PBSI__Quantity_Needed__c;
                inv.PBSI__item_lookup__c = theline.PBSI__Item__c;

                insert inv;*/

                /*PBSI__Shipped_Sales_Order_Line__c pline = new PBSI__Shipped_Sales_Order_Line__c();

                pline.PBSI__Item__c = theline.PBSI__Item__c;
                pline.PBSI__Shipping_Date__c = date.today();
                pline.PBSI__Shipped_Time__c = datetime.now();
                pline.PBSI__Waranty_Start_Date__c = date.today();
                pline.PBSI__Type__c = 'sale';
                pline.PBSI__Sales_Order_Line__c = theline.Id;
                pline.PBSI__Sales_Order__c = so.id;
                pline.PBSI__Quantity_Shipped__c = theline.PBSI__Quantity_Needed__c;
                pline.PBSI__Price__c = theline.PBSI__Price__c;
                pline.PBSI__Lot__c = lot.id;

                insert pline;*/

            //Create an RMA .. To SO .. To Opportunity = Lead Source & Campaign = Dim 1 and Dim 3
            Case rma = new Case();
            rma.AccountId = acc.id;
            rma.PBSI__Sales_Order__c = so.id;
            rma.Status = 'New';
            rma.Origin = 'Inbound Call';
            rma.Priority = 'Medium';
            rma.PBSI__Return_Type__c = 'From Customer';
            insert rma;

            /*PBSI__RMA_Lines__c rmaline = new PBSI__RMA_Lines__c();
            rmaline.PBSI__RMA__c = rma.id;
            rmaline.PBSI__Item__c = theline.PBSI__Item__c;
            rmaline.PBSI__Quantity__c = theline.PBSI__Quantity_Needed__c;
            rmaline.PBSI__Quantity_Received__c = theline.PBSI__Quantity_Needed__c;
            rmaline.PBSI__Reason_RMA_Line__c = 'Other';
            rmaline.PBSI__Sales_Order_Line__c = theline.Id;
            rmaline.PBSI__Cost__c = 100;
            rmaline.PBSI__Type__c = 'Return';
            insert rmaline;*/

            //Create an FFA Invoice = Dim1 and Dim 3
            c2g__codaInvoice__c SIN = new c2g__codaInvoice__c();
            SIN.c2g__Period__c = openPeriod.Id;
            SIN.c2g__InvoiceDate__c = openPeriod.c2g__StartDate__c;
            SIN.c2g__Dimension1__c = lstDimension1[0].id;
            SIN.c2g__Dimension3__c = lstCampaigns[0].Dimension_3__c;
            SIN.Ascent2FF__Sales_Order__c = so.id;
            SIN.c2g__Account__c = acc.id;
            SIN.c2g__InvoiceStatus__c = 'In Progress';
            insert SIN;

        //Start The Test
        Test.StartTest();
            
            c2g__codaCreditNote__c note = new c2g__codaCreditNote__c(); //A Sales Credit Note
            
            note.c2g__CreditNoteDate__c = openPeriod.c2g__StartDate__c;
            note.c2g__DueDate__c = openPeriod.c2g__StartDate__c.addDays(7);
            note.c2g__Period__c = openPeriod.Id;
            note.c2g__Account__c = acc.id;
            note.Account_Name_Text__c = acc.Name;
            note.c2g__OwnerCompany__c = Intellibed.id;
            note.c2g__TaxCode1__c = FFATax.id;
            note.c2g__CustomerReference__c = 'None';
            note.c2g__CreditNoteReason__c = 'Goods Returned';
            note.c2g__CreditNoteDescription__c = 'Goods returned from customer';
            note.c2g__CreditNoteStatus__c = 'In Progress';
            note.c2g__PrintStatus__c = 'Not Printed';
            note.c2g__Invoice__c = SIN.id;
            note.c2g__InvoiceDate__c = openPeriod.c2g__StartDate__c;
            note.c2g__Opportunity__c = opp.id;
            insert note;

            c2g__codaCreditNoteLineItem__c line = new c2g__codaCreditNoteLineItem__c();
            line.c2g__UnitPrice__c = 1;
            line.c2g__Quantity__c = 1;
            line.c2g__Product__c = taxableitem.PBSI__Product__c;
            line.c2g__CreditNote__c = note.id;
            line.c2g__OwnerCompany__c = Intellibed.id;
            insert line;

            //Post the Note
            c2g.CODAAPICommon.Reference ref2 = new c2g.CODAAPICommon.Reference();
            ref2.Id = note.Id;
            c2g.CODAAPISalesCreditNote_10_0.PostCreditNote(null, ref2);
    
        //End The Test

        Test.StopTest();

        } //End if Off
        
    } //End isTest static void WSTestSalesCreditNoteTools

} //End class WSTestSalesCreditNote Tools