@IsTest(SeeAllData=true)

class WSTestFFJournalLineTools{

  //Unit test for createCampaignDimension3
  
    @IsTest static void UnitTestsetDim13FFJournalLine(){

    	// Grab your Custom Setting values
	    WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
	    Boolean  TriggerOff = settings.Turn_Off_Journal_Line_Trigger__c;
	    Boolean  AllTriggersOff = settings.Turn_Off_All_APEX_Triggers__c;

	    //Only do something if TriggerOff is False
	    if(TriggerOff == FALSE && AllTriggersOff == FALSE){

	    	Set<ID> acctIds = new Set<ID>();
	    	Set<ID> soIds = new Set<ID>();
	    	Set<ID> payIds = new Set<ID>();
	    	Set<ID> oppIds = new Set<ID>();

	    	Map<ID,ID> jrnlTopay = new Map<ID,ID>(); //Journal Id to Payment Id Map
	    	Map<ID,ID> jrnlToso = new Map<ID,ID>(); //Journal Id to SO Id Map
	    	Map<ID,ID> payToopp = new Map<ID,ID>(); //Payment Id to Opportunity Id Map
	    	Map<ID,ID> soToopp = new Map<ID,ID>(); //Sales Order Id to Opportunity Id Map
	    	Map<ID,ID> oppToacct = new Map<ID,ID>(); //Opportunity Id to Account Id Map

	    	List<c2g__codaJournal__c> lstJournal = new List<c2g__codaJournal__c>(); //A List of FF Journals

	    	//Pick an Account
	    	Account lineAcct = new Account();
	    	lineAcct  = [
	    	SELECT Id, Name, PBSI__Precisio_Type__c
	    	FROM Account
	    	WHERE PBSI__Precisio_Type__c = : 'Customer'
	    	LIMIT 1];

	    	//Pick a Campaign
	    	Campaign newCamp = new Campaign();
	    	newCamp = [
	    	SELECT Id, Name, IsActive
	    	FROM Campaign
	    	WHERE IsActive =: true
	    	LIMIT 1];

	    	//Pick A Bank Account
	    	c2g__codaBankAccount__c newBank = new c2g__codaBankAccount__c();
	    	newBank = [
	    	SELECT Id, Name, Payment_Origin_Mapping__c, c2g__GeneralLedgerAccount__c
	    	FROM c2g__codaBankAccount__c
	    	WHERE Payment_Origin_Mapping__c =: 'Amazon.com'
	    	LIMIT 1];

	    	//Find the GL Account for Processing Fee
	    	c2g__codaGeneralLedgerAccount__c newGLFee = new c2g__codaGeneralLedgerAccount__c();
	    	newGLFee = [
	    	SELECT Id, Name, c2g__TrialBalance1__c, c2g__TrialBalance2__c, c2g__TrialBalance3__c
	    	FROM c2g__codaGeneralLedgerAccount__c
	    	WHERE c2g__TrialBalance1__c = : 'Profit & Loss' AND c2g__TrialBalance2__c =: 'Operating Expenses' AND c2g__TrialBalance3__c = : 'Processing Fees'
	    	LIMIT 1];

	    	//Find A Period
	    	c2g__codaPeriod__c openPeriod = new c2g__codaPeriod__c();
	    	openPeriod = [
	    	SELECT Id, c2g__Closed__c
	    	FROM c2g__codaPeriod__c
	    	WHERE c2g__Closed__c =: FALSE
	    	LIMIT 1];


	    	//Create an Opportunity
	    	Opportunity newopp = new Opportunity();

	    	newopp.name = 'Test';
	    	newopp.closeDate = date.today();
	    	newopp.CampaignId = newCamp.Id;
	    	newopp.Purchase_Method__c = 'store';
	    	newopp.AccountId = lineAcct.Id;
	    	newopp.StageName = 'ClosedWon';
	    	newopp.LeadSource = 'Medical Show';

	    	insert newopp;

		   	List<PBSI__PBSI_Sales_Order_Line__c> lstlns = new List<PBSI__PBSI_Sales_Order_Line__c>();
	        List<PBSI__PBSI_Sales_Order_Line__c> uplns = new List<PBSI__PBSI_Sales_Order_Line__c>();

	        //Get The Consumer Account Record Type Id

	        String accRecType = ([Select Id From RecordType  Where SobjectType = 'Account' and Name = 'Customer']).id;
	        String conRecType = ([Select Id From RecordType  Where SobjectType = 'Contact' and Name = 'Customer']).id;

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
	        taxcodes.add(FFATax);

	        c2g__codaTaxCode__c FFATax2 = new c2g__codaTaxCode__c();

	        FFATax2.Name = 'Test2';
	        FFATax2.c2g__Description__c = 'Test2';
	        FFATax2.c2g__GeneralLedgerAccount__c = GLATax.id;
	        FFATax2.c2g__TaxGroup__c = '';
	        FFATax2.c2g__UnitOfWork__c = 1;
	        taxcodes.add(FFATax2);

	        insert taxcodes;

	        //Create A FFA Tax Rate

	        c2g__codaTaxRate__c FFARate = new c2g__codaTaxRate__c();

	        FFARate.c2g__TaxCode__c = FFATax.id;
	        FFARate.c2g__Rate__c = 10.00;
	        FFARate.c2g__UnitOfWork__c = 1;
	        FFARate.c2g__StartDate__c = date.today();

	        insert FFARate;

	        c2g__codaTaxRate__c FFARate2 = new c2g__codaTaxRate__c();

	        FFARate2.c2g__TaxCode__c = FFATax2.id;
	        FFARate2.c2g__Rate__c = 10.00;
	        FFARate2.c2g__UnitOfWork__c = 1;
	        FFARate2.c2g__StartDate__c = date.today();

	        insert FFARate2;

	        //Create Two Ascent Tax Codes

	        PBSI__Tax_Code__c AscTax = new PBSI__Tax_Code__c();

	        AscTax.Name = 'Test';
	        AscTax.FF_Tax_Code__c = FFATax.id;
	        AscTax.PBSI__Start_Date__c = date.today();
	        AscTax.PBSI__End_Date__c = date.today()+1;
	        AscTax.PBSI__Description__c = 'Test';
	        AscTax.PBSI__Tax_Rate__c = 10.0;

	        insert AscTax;

	        PBSI__Tax_Code__c AscTax2 = new PBSI__Tax_Code__c();

	        AscTax2.Name = 'Test2';
	        AscTax2.FF_Tax_Code__c = FFATax2.id;
	        AscTax2.PBSI__Start_Date__c = date.today();
	        AscTax2.PBSI__End_Date__c = date.today()+1;
	        AscTax2.PBSI__Description__c = 'Test2';
	        AscTax2.PBSI__Tax_Rate__c = 10.0;

	        insert AscTax2;

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

		    PBSI__PBSI_Item__c taxableitem = new PBSI__PBSI_Item__c();

	        taxableitem = [
	        SELECT Id, PBSI__Taxable__c, PBSI__Not_Available_For_Sale__c, PBSI__Item_Type__c
	        FROM PBSI__PBSI_Item__c
	        WHERE PBSI__Taxable__c = true and PBSI__Not_Available_For_Sale__c = false AND PBSI__Item_Type__c = 'Item'
	        LIMIT 1];

	        PBSI__PBSI_Item__c nontaxableitem = new PBSI__PBSI_Item__c();

	        nontaxableitem = [
	        SELECT Id, PBSI__Taxable__c, PBSI__Not_Available_For_Sale__c, PBSI__Item_Type__c
	        FROM PBSI__PBSI_Item__c
	        WHERE PBSI__Taxable__c = false AND PBSI__Not_Available_For_Sale__c = false AND PBSI__Item_Type__c = 'Item'
	        LIMIT 1
	        ];


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
	        
	        //Create Sales Order Lines
	        
	        PBSI__PBSI_Sales_Order_Line__c line1 = new PBSI__PBSI_Sales_Order_Line__c();
	        PBSI__PBSI_Sales_Order_Line__c line2 = new PBSI__PBSI_Sales_Order_Line__c();
	        PBSI__PBSI_Sales_Order_Line__c line3 = new PBSI__PBSI_Sales_Order_Line__c();
	        PBSI__PBSI_Sales_Order_Line__c line4 = new PBSI__PBSI_Sales_Order_Line__c();

	        line1.PBSI__Sales_Order__c = so.id;
	        line1.PBSI__TransactionType__c ='Sale';
	        line1.PBSI__Item__c = taxableitem.id;
	        line1.PBSI__Quantity_Needed__c = 1;
	        line1.PBSI__Price__c = 10;
	        line1.Ascent2FF__Tax_Code_1__c = null; //Insert a taxable line with no tax codes
	        lstlns.add(line1);

	        line2.PBSI__Sales_Order__c = so.id;
	        line2.PBSI__TransactionType__c = 'Sale';
	        line2.PBSI__Item__c = nontaxableitem.id;
	        line2.PBSI__Quantity_Needed__c = 1;
	        line2.PBSI__Price__c = 10;
	        line2.Ascent2FF__Tax_Code_1__c = null;
	        line2.Ascent2FF__Tax_Code_2__c = null;
	        line2.Ascent2FF__Tax_Code_3__c = null;
	        line2.PBSI__Taxable__c = false;
	        lstlns.add(line2);

	        line3.PBSI__Sales_Order__c = so.id;
	        line3.PBSI__TransactionType__c ='Sale';
	        line3.PBSI__Item__c = taxableitem.id;
	        line3.PBSI__Quantity_Needed__c = 1;
	        line3.PBSI__Price__c = 10;
	        line3.Ascent2FF__Tax_Code_1__c = FFATax.id;
	        line3.Ascent2FF__Tax_Code_2__c = FFATax.id;
	        line3.Ascent2FF__Tax_Code_3__c = FFATax.id;
	        lstlns.add(line3);

	        line4.PBSI__Sales_Order__c = so.id;
	        line4.PBSI__TransactionType__c ='Sale';
	        line4.PBSI__Item__c = nontaxableitem.id;
	        line4.PBSI__Quantity_Needed__c = 1;
	        line4.PBSI__Price__c = 10;
	        line4.Ascent2FF__Tax_Code_1__c = null;
	        line4.Ascent2FF__Tax_Code_2__c = null;
	        line4.Ascent2FF__Tax_Code_3__c = null;
	        line4.PBSI__Taxable__c = false;
	        line4.PBSI__Discount_Amount__c = null;
	        lstlns.add(line4);

	        insert lstlns;

	    	//Create A Customer PrePayment
	    	Prepayment__c newPay = new Prepayment__c();

	    	newPay.Opportunity__c = newopp.id;
	    	newPay.Amount__c = 100;
	    	newPay.Origin__c = 'Amazon.com';
	    	newPay.Date_of_Payment__c = date.today();

	    	insert newPay;

	    	//Create A Journal for the New Payment
	    	c2g__codaJournal__c newJournal = new c2g__codaJournal__c();

	    	newJournal.Payment__c = newPay.id;
	    	newJournal.c2g__JournalDate__c = date.today();
	    	newJournal.c2g__JournalDescription__c = 'Payment Processing Fee';
	    	newJournal.c2g__JournalStatus__c = 'In Progress';
	    	newJournal.c2g__Reference__c = lineAcct.Name;
	    	newJournal.c2g__Type__c = 'Manual Journal';
	    	newJournal.Ascent2FF__Sales_Order__c = so.id;

	    	insert newJournal;

	    	//Update The Journal Reference on the PrePayment
	    	newPay.Journal__c = newJournal.Id;
	    	update newPay;

	    	//Create The Journal Credit Line
	    	c2g__codaJournalLineItem__c newCreditLine = new c2g__codaJournalLineItem__c();

	    	newCreditLine.c2g__BankAccount__c = newBank.Id;
	    	newCreditLine.c2g__GeneralLedgerAccount__c = newGLFee.id;
	    	newCreditLine.c2g__Journal__c = newJournal.id;
	    	newCreditLine.c2g__LineType__c = 'Bank Account';
	    	newCreditLine.c2g__Value__c = 1;

	    	insert newCreditLine;

	    	//Create The Journal Debit Line
	    	c2g__codaJournalLineItem__c newDebitLine = new c2g__codaJournalLineItem__c();

	    	newDebitLine.c2g__BankAccount__c = newBank.Id;
	    	newDebitLine.c2g__GeneralLedgerAccount__c = newBank.c2g__GeneralLedgerAccount__c;
	    	newDebitLine.c2g__Journal__c = newJournal.id;
	    	newDebitLine.c2g__LineType__c = 'Bank Account';
	    	newDebitLine.c2g__Value__c = -1;

	    	insert newDebitLine;

	    	//Add the Journal to the List of Journals
	    	lstJournal.add(newJournal);

	    	//Create and insert a new Journal Line
			for(c2g__codaJournal__c jrnl : lstJournal){
		        
		        //Add A Test Journal Line
		        c2g__codaJournalLineItem__c newLine = new c2g__codaJournalLineItem__c();

		        newLine.c2g__Journal__c = jrnl.id;
		       	newLine.c2g__GeneralLedgerAccount__c = GLAar.Id;
		        newline.c2g__Account__c = lineAcct.id;
		        newLine.c2g__DebitCredit__c = 'Debit';
		        newLine.c2g__OwnerCompany__c = jrnl.c2g__OwnerCompany__c;
		        newLine.c2g__LineType__c = 'Account - Customer';

	        	insert newLine;

    		}
		}
    }
}