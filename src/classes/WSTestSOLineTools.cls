@isTest(SeeAllData=true)

class WSTestSOLineTools{

    @IsTest static void UnitTest1_SOLLineTax () 
    {

        //Grab your Custom Setting values
        WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
        Boolean  AllTriggersOff = settings.Turn_Off_All_APEX_Triggers__c;
        Boolean  ThisTriggerOff = settings.Turn_Off_SO_Line_Tax_Trigger__c;
      
        if(AllTriggersOff == FALSE && ThisTriggerOff == FALSE){
        
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

        //Create A Warehouse -- Not Used

        //Create A Location  -- Not Used

        //Create An Item Group -- Not Used

        //Create Item Masters  -- Not Used

        //Find Suitable Item Masters

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

        //Start The Test

        Test.StartTest();

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

            ////Update the Sales Order Lines

            line1.PBSI__Quantity_Needed__c = 2;
            uplns.add(line1);

            line2.PBSI__Price__c = 100;
            uplns.add(line2);

            line3.PBSI__Quantity_Needed__c = 3;
            uplns.add(line3);

            line4.PBSI__Taxable__c = false;
            uplns.add(line4);

            update uplns;

            String allfields = WSSOLineTools.AllFieldNames('Account');

        //End The Test

        Test.StopTest();

        }

    }
  
}