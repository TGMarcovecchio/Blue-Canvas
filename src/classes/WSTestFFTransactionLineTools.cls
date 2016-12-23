@IsTest(SeeAllData=true)

//http://help.financialforce.com/accounting-api/15X/CODAAPISalesCreditNote_10_0.htm

class WSTestFFTransactionLineTools {

	@IsTest static void unitTestsetDim13FFTranLine() {

		List<c2g__codaTransaction__c> transactions = new List<c2g__codaTransaction__c>(); //List of Transactions
		List<c2g__codaTransactionLineItem__c> lstTlines = new List<c2g__codaTransactionLineItem__c>(); //List of Transactions
		List<c2g__codaTransactionLineItem__c> updatelines = new List<c2g__codaTransactionLineItem__c>(); //List of Transactions

		List<c2g__codaInvoice__c> invoices = new List<c2g__codaInvoice__c>(); //List of SINs
		List<c2g__codaCreditNote__c> notes = new List<c2g__codaCreditNote__c>(); //List of SCRN

		//Find The FFA Company
		c2g__codaCompany__c Intellibed = [SELECT Id FROM c2g__codaCompany__c LIMIT 1];

        //Find A Period
          c2g__codaPeriod__c openPeriod = new c2g__codaPeriod__c();
            openPeriod = [
            SELECT Id, c2g__Closed__c, c2g__StartDate__c, c2g__PeriodNumber__c, c2g__PeriodGroup__c, c2g__EndDate__c
            FROM c2g__codaPeriod__c
            WHERE c2g__Closed__c =: FALSE AND c2g__PeriodNumber__c != '000'
            AND c2g__StartDate__c <= YESTERDAY AND c2g__EndDate__c >= YESTERDAY
            AND c2g__PeriodGroup__c != NULL
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

		
		//Find DIM 1
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

		//Find DIM 3
		//Get The List of Campaigns which have Dimension 3 Specified
        List<Campaign> lstCampaigns = [
        SELECT Id, Name, Dimension_3__c
        FROM Campaign
        WHERE Dimension_3__c != NUll
        LIMIT 1
        ];

        //Get the Account Record Type
        String accRecType = ([Select Id From RecordType  Where SobjectType = 'Account' and Name = 'Customer']).id;

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
        FFARate.c2g__StartDate__c = openPeriod.c2g__StartDate__c; //date.today();

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

        //Get an Item and Product
        PBSI__PBSI_Item__c taxableitem = new PBSI__PBSI_Item__c();
        taxableitem = [
        SELECT Id, PBSI__Taxable__c, PBSI__Not_Available_For_Sale__c, PBSI__Item_Type__c, PBSI__Product__c
        FROM PBSI__PBSI_Item__c
        WHERE PBSI__Product__c != NULL and PBSI__Taxable__c = true and PBSI__Not_Available_For_Sale__c = false AND PBSI__Item_Type__c = 'Item'
        LIMIT 1];

        //Create A PriceBook Entry for the Product
        Pricebook2 pb = [select Id, IsActive from PriceBook2 where IsStandard=True];
        PriceBookEntry pbe = new PricebookEntry (Pricebook2Id=pb.id, Product2Id=taxableitem.PBSI__Product__c, IsActive=true, UnitPrice=100.0);
        insert pbe;

		//Create A SIN Header
	    c2g__codaInvoice__c SIN = new c2g__codaInvoice__c();
        SIN.c2g__Period__c = openPeriod.Id;
        SIN.c2g__InvoiceDate__c = openPeriod.c2g__StartDate__c;
        SIN.c2g__Dimension1__c = lstDimension1[0].id;
        SIN.c2g__Dimension3__c = lstCampaigns[0].Dimension_3__c;
        //SIN.Ascent2FF__Sales_Order__c = so.id;
        SIN.c2g__Account__c = acc.id;
        SIN.c2g__InvoiceStatus__c = 'In Progress';
        insert SIN;

		// Insert Invoice line items
		List<c2g__codaInvoiceLineItem__c> invoiceLines = new List<c2g__codaInvoiceLineItem__c>();
		invoiceLines.add(
		new c2g__codaInvoiceLineItem__c(
		c2g__Invoice__c = SIN.Id,
		c2g__Product__c = taxableitem.PBSI__Product__c,
		c2g__Quantity__c = 10
		));
		invoiceLines.add(
		new c2g__codaInvoiceLineItem__c(
		c2g__Invoice__c = SIN.Id,
		c2g__Product__c = taxableitem.PBSI__Product__c,
		c2g__Quantity__c = 2
		));
		insert invoiceLines;

        //Start The Test
        Test.StartTest();

		// Post the Invoice
		c2g.CODAAPICommon.Reference ref = new c2g.CODAAPICommon.Reference();
		ref.Id = SIN.Id;
		c2g.CODAAPISalesInvoice_3_0.PostInvoice(null, ref);

        //Stop The Test
        Test.StopTest();
		
	}

		@IsTest static void unitTestsetDim13FFTranLine2() {

		List<c2g__codaTransaction__c> transactions = new List<c2g__codaTransaction__c>(); //List of Transactions
		List<c2g__codaTransactionLineItem__c> lstTlines = new List<c2g__codaTransactionLineItem__c>(); //List of Transactions
		List<c2g__codaTransactionLineItem__c> updatelines = new List<c2g__codaTransactionLineItem__c>(); //List of Transactions

		List<c2g__codaInvoice__c> invoices = new List<c2g__codaInvoice__c>(); //List of SINs
		List<c2g__codaCreditNote__c> notes = new List<c2g__codaCreditNote__c>(); //List of SCRN

		//Find The FFA Company
		c2g__codaCompany__c Intellibed = [SELECT Id FROM c2g__codaCompany__c LIMIT 1];

        //Find A Period
          c2g__codaPeriod__c openPeriod = new c2g__codaPeriod__c();
            openPeriod = [
            SELECT Id, c2g__Closed__c, c2g__StartDate__c, c2g__PeriodNumber__c, c2g__PeriodGroup__c, c2g__EndDate__c
            FROM c2g__codaPeriod__c
            WHERE c2g__Closed__c =: FALSE AND c2g__PeriodNumber__c != '000'
            AND c2g__StartDate__c <= YESTERDAY AND c2g__EndDate__c >= YESTERDAY
            AND c2g__PeriodGroup__c != NULL
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

		
		//Find DIM 1
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

		//Find DIM 3
		//Get The List of Campaigns which have Dimension 3 Specified
        List<Campaign> lstCampaigns = [
        SELECT Id, Name, Dimension_3__c
        FROM Campaign
        WHERE Dimension_3__c != NUll
        LIMIT 1
        ];

        //Get the Account Record Type
        String accRecType = ([Select Id From RecordType  Where SobjectType = 'Account' and Name = 'Customer']).id;

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
        FFARate.c2g__StartDate__c = openPeriod.c2g__StartDate__c; //date.today();

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

        //Get an Item and Product
        PBSI__PBSI_Item__c taxableitem = new PBSI__PBSI_Item__c();
        taxableitem = [
        SELECT Id, PBSI__Taxable__c, PBSI__Not_Available_For_Sale__c, PBSI__Item_Type__c, PBSI__Product__c
        FROM PBSI__PBSI_Item__c
        WHERE PBSI__Product__c != NULL and PBSI__Taxable__c = true and PBSI__Not_Available_For_Sale__c = false AND PBSI__Item_Type__c = 'Item'
        LIMIT 1];

        //Create A PriceBook Entry for the Product
        Pricebook2 pb = [select Id, IsActive from PriceBook2 where IsStandard=True];
        PriceBookEntry pbe = new PricebookEntry (Pricebook2Id=pb.id, Product2Id=taxableitem.PBSI__Product__c, IsActive=true, UnitPrice=100.0);
        insert pbe;

		//Create An Opportunity = Lead Source & Campaign = Dim 1 and Dim 3
		Opportunity opp = new Opportunity();
		//opp.PBSI__Sales_Order__c = so.id;
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


		//Create A SCRN Header
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
		//note.Ascent2FF__RMA__c = rma.id;
		insert note;

		c2g__codaCreditNoteLineItem__c line = new c2g__codaCreditNoteLineItem__c();
		line.c2g__UnitPrice__c = 1;
		line.c2g__Quantity__c = 1;
		line.c2g__Product__c = taxableitem.PBSI__Product__c;
		line.c2g__CreditNote__c = note.id;
		line.c2g__OwnerCompany__c = Intellibed.id;
        line.c2g__TaxCode1__c = FFATax.id;
		insert line;

        //Start The Test
        Test.StartTest();

		//Post the Note
		c2g.CODAAPICommon.Reference ref2 = new c2g.CODAAPICommon.Reference();
		ref2.Id = note.Id;
		c2g.CODAAPISalesCreditNote_10_0.PostCreditNote(null, ref2);

		//c2g.TransactionService.AccountingTransaction

        //Start The Test
        Test.StopTest();

		
	}

}