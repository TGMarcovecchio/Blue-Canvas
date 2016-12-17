global class WSSOLineTools {

    //Set the FFA Tax Code for Sales Order Line from the Ascent Tax Code on the Header

    public static void createSOLineHistory(PBSI__PBSI_Sales_Order_Line__c[] lstSOLs){  //Inserts a new price History Line for each SO Line in the list

        List<Sales_Order_Line_Historic_Price__c> lstSOLHists = new List<Sales_Order_Line_Historic_Price__c>(); //A list of Price History Lines to create

        for(PBSI__PBSI_Sales_Order_Line__c sol : lstSOLs){  //Loop through the list of Sales Order Lines

            Sales_Order_Line_Historic_Price__c solhp = new Sales_Order_Line_Historic_Price__c(); //Generate a new Price History Line

            solhp.Sales_Order_Line__c = sol.id;
            solhp.Unit_Price_2_Digit__c = sol.PBSI__ItemSalesPrice__c;  //Capture the 2 digit unit price from the Item Master
            solhp.Unit_Price_4_Digit__c = sol.ItemSalesPrice_4__c; //Captuer the 4 digit unit price from the Item Master
            solhp.Name = sol.Name + '-HISTPRICE';
            solhp.Price_Date__c = date.Today();
            solhp.Sales_Order__c = sol.PBSI__Sales_Order__c;
            solhp.Item_Lookup__c = sol.PBSI__Item__c;

            lstSOLHists.add(solhp); //Add the Price History record to the list to be created

        }

        try{

            if(!lstSOLHists.isEmpty()){

                insert lstSOLHists; //Insert the New SO Line Price History Lines
            }

            }catch(Exception e){

                system.Debug('***************Error Inserting SO Line Historic Price****************'+e);
            }

    }

    public static void updateSOLineHistory(PBSI__PBSI_Sales_Order_Line__c[] lstSOLs){  //Update Price History Lines for each SO Line

        List<Sales_Order_Line_Historic_Price__c> lstSOLHists = new List<Sales_Order_Line_Historic_Price__c>(); //A list of Price History Lines
        List<Sales_Order_Line_Historic_Price__c> upSOLHists = new List<Sales_Order_Line_Historic_Price__c>(); //A list of Price History Lines to update
        
        Set<Id> solids = new Set<Id>(); //A Set of Sales Order Line Ids
        Set<Id> itemids = new Set<Id>(); //A Set of Item Ids

        Map<Id,Id> itemmap = new Map<Id,Id>(); //A Map of Sales Order Line Id to Item Id
        Map<Id,Double> pricemap2 = new Map<Id,Double>(); //A Map of Item Id to Current 2 Decimal Listed Sales Price on the Item Master
        Map<Id,Double> pricemap4 = new Map<Id,Double>(); //A Map of Item Id to Current 4 Decimal Listed Sales Price on the Item Master

        List<PBSI__PBSI_Item__c> items = new List<PBSI__PBSI_Item__c>();

        for(PBSI__PBSI_Sales_Order_Line__c sol : lstSOLs){  //Loop through the list of Sales Order Lines

            solids.add(sol.id);
            itemmap.put(sol.id,sol.PBSI__Item__c);
            itemids.add(sol.PBSI__Item__c);

        }

        items = [SELECT Id, PBSI__salesprice__c,PBSI__salesprice4__c FROM PBSI__PBSI_Item__c WHERE Id IN: itemids];

        if(!items.isEmpty()){
            for(PBSI__PBSI_Item__c i : items){
                pricemap2.put(i.id,i.PBSI__salesprice__c);
                pricemap4.put(i.id,i.PBSI__salesprice4__c);
            }
        }

        lstSOLHists = [SELECT Id, Item_Lookup__c, Unit_Price_2_Digit__c, Price_Date__c, Sales_Order_Line__c FROM Sales_Order_Line_Historic_Price__c WHERE Sales_Order_Line__c IN: solids];

        if(!lstSOLHists.isEmpty()){
            for(Sales_Order_Line_Historic_Price__c hist : lstSOLHists){

                if(hist.Item_Lookup__c != itemmap.get(hist.Sales_Order_Line__c)){

                    //Do something if the item changed

                    hist.Item_Lookup__c = itemmap.get(hist.Sales_Order_Line__c);
                    hist.Unit_Price_2_Digit__c = pricemap2.get(itemmap.get(hist.Sales_Order_Line__c));
                    hist.Unit_Price_4_Digit__c = pricemap4.get(itemmap.get(hist.Sales_Order_Line__c));
                    hist.Price_Date__c = date.Today();

                    upSOLHists.add(hist);

                }

            }
        }

        if(!upSOLHists.isEmpty()){
            try{
                update upSOLHists;
            }catch(Exception eup){
                system.debug('**************** Error Updating Sales Order Line History ****************' + eup.getMessage());
            }
        }

    }    

    public static void trWSSOLineTaxCode(PBSI__PBSI_Sales_Order_Line__c[] lstSOLs){
    
    List<PBSI__PBSI_Sales_Order_Line__c> lstSOLUpdates = new List<PBSI__PBSI_Sales_Order_Line__c>(); //List of Sale Order Lines To Update
    
    Set<ID> soIDS = new Set<ID>(); //The Set of SO Ids
    Set<ID> astxcIDs = new Set<ID>(); //The Set of Ascent Tax Code Ids
    
    Map<ID, ID> mapAStoFF = new Map<ID, ID>(); //The Map of Ascent Tax Code Ids to their FFA Tax Code Records
    Map<ID, ID> mapTaxCode = new Map<ID, ID>(); //The Map of Sales Order Ids to their FFA Tax Code Records

    //Create the Ascent to FFA Tax Code Map
    for (PBSI__Tax_Code__c tax : 
        [SELECT Id, 
        FF_Tax_Code__c  //The FF Tax Code Field  
        FROM PBSI__Tax_Code__c  
        ORDER BY Id ]) {
            
        mapAStoFF.put(tax.Id, tax.FF_Tax_Code__c);
    }
        
    //Add SO Ids to Set
      for (PBSI__PBSI_Sales_Order_Line__c sl : lstSOLs) {
      soIDs.add(sl.PBSI__Sales_Order__c);
      }
        
    //Query SOs in SOId Set and Create A Map of SO Id to Ascent Tax Code Id
     for (PBSI__PBSI_Sales_Order__c so : 
        [SELECT Id, 
        PBSI__Tax_Code__c  //The Tax Code Field Value 
        FROM PBSI__PBSI_Sales_Order__c 
        WHERE Id IN :soIDS 
        ORDER BY Id ]) {
      
      mapTaxCode.put(so.Id, mapAStoFF.get(so.PBSI__Tax_Code__c));
    }
    
    //PBSI__Tax_Code__c taxcode; // define a variable 'taxcode' for Ascent Tax Code
  
   //For each Sales Order Line reference it's Ascent Tax Code Header Value and use the Map to find the FFA Tax Code then set the FFA Tax Code
    for (PBSI__PBSI_Sales_Order_Line__c sl2 : lstSOLs) {
        
        if (mapTaxCode.get(sl2.PBSI__Sales_Order__c) != null) {
        sl2.Ascent2FF__Tax_Code_1__c = mapTaxCode.get(sl2.PBSI__Sales_Order__c);  //Set the FFA Tax Code on the SO Line
        }
    }

    if(!lstSOLs.isEmpty()){

        WSSOLineTools.WSSOLineTaxRound(lstSOLs);
    }
    
    system.debug('dbgx:' + lstSOLs.size().format());
   
  }

  public static void WSSOLineTaxRound(PBSI__PBSI_Sales_Order_Line__c[] lstSOls){    //Correct the tax amounts on the lines via rounding methods to coincide with FFA tax calculation methods
  
    Set<id> codes = new Set <id>(); //A Set of FFA Tax Code Ids
    List<PBSI__PBSI_Sales_Order_Line__c> solines = new List<PBSI__PBSI_Sales_Order_Line__c>(); //A List of Ascent SO Lines
    Map<Id,double> rates = new Map<Id,Double>(); //A Map of the FFA Tax Code Ids to their Tax Rates

    //For the list of Sales Order Lines find their FFA Tax Code 1, 2 and 3 references. Add them to list of codes. Add the line to list of SO Lines
    
    for(PBSI__PBSI_Sales_Order_Line__c s : lstSOls){

        //if (s.PBSI__Taxable__c){

           if (s.Ascent2FF__Tax_Code_1__c <> null)
              codes.add(s.Ascent2FF__Tax_Code_1__c);
           if (s.Ascent2FF__Tax_Code_2__c <> null )
             codes.add(s.Ascent2FF__Tax_Code_2__c);
           if (s.Ascent2FF__Tax_Code_3__c <> null )
             codes.add(s.Ascent2FF__Tax_Code_3__c);

            //solines.add(s); 
        //}
    
    }    
    
    //Fill the rate map with the Id of the Tax Code and its corresponding rate
    if (codes.size() > 0){
           
            list<c2g__codaTaxRate__c> ratesr=[select id,c2g__StartDate__c,c2g__TaxCode__c,c2g__Rate__c 
                        from  c2g__codaTaxRate__c 
                        where c2g__TaxCode__c in:codes
                        and c2g__StartDate__c <= :system.today() 
                        order by c2g__StartDate__c desc];

            for (c2g__codaTaxRate__c tr:ratesr)

            if (rates.containsKey(tr.c2g__TaxCode__c) == false)
            rates.put(tr.c2g__TaxCode__c,tr.c2g__Rate__c);
       }
    
    //For the list of Sales Order Lines do some stuff related to taxes
    for (PBSI__PBSI_Sales_Order_Line__c s : lstSOLs){ 
    
            //If the Lines is Taxable calculate rates and values
            if (s.PBSI__Taxable__c == true){ 
                
                //if (s.ascent2ff__Tax_Code_1__c == null) {  //This condition can never exist. Ascent2FF is always set manually or by code
                    //s.ascent2ff__Tax_Rate_1__c=0;
                    //s.ascent2ff__Tax_Value_1__c=0;
                 //}

                if (s.ascent2ff__Tax_Code_2__c == null) {
                    s.ascent2ff__Tax_Rate_2__c=0;
                    s.ascent2ff__Tax_Value_2__c=0;
                }

                if (s.ascent2ff__Tax_Code_3__c == null) {
                    s.ascent2ff__Tax_Rate_3__c=0;
                    s.ascent2ff__Tax_Value_3__c=0;
                }

                //Check The Discount Amount and calculate the price at the line

                if (s.PBSI__Discount_Amount__c == null){
                    s.PBSI__Discount_Amount__c=0;
                }

                decimal price=(s.PBSI__Price__c - (s.PBSI__Price__c * ( s.PBSI__Discount__c +s.PBSI__Discount1__c ))/100)*s.pbsi__quantity_needed__C-s.PBSI__Discount_Amount__c;    
                                  
                //Check for the Tax Codes and set the Tax Value using the calculated price

                if (rates.containsKey(s.ascent2ff__Tax_Code_1__c)){
                     s.Ascent2FF__Tax_Rate_1__c=rates.get(s.ascent2ff__Tax_Code_1__c);
                }
              
                if (s.ascent2ff__Tax_Rate_1__c <> null){
                      s.ascent2ff__Tax_Value_1__c=((price*s.ascent2ff__Tax_Rate_1__c) /100).setScale(2,System.RoundingMode.HALF_UP); 
                }

                if (rates.containsKey(s.ascent2ff__Tax_Code_2__c)){
                     s.Ascent2FF__Tax_Rate_2__c=rates.get(s.ascent2ff__Tax_Code_2__c);
                }
                   
                if (s.ascent2ff__Tax_Rate_2__c <> null){
                      s.ascent2ff__Tax_Value_2__c=((price*s.ascent2ff__Tax_Rate_2__c) /100).setScale(2,System.RoundingMode.HALF_UP); 
                }

                if (rates.containsKey(s.ascent2ff__Tax_Code_3__c)){
                     s.ascent2ff__Tax_Rate_3__c=rates.get(s.ascent2ff__Tax_Code_3__c);
                }
                   
                if (s.ascent2ff__Tax_Rate_3__c <> null){
                      s.ascent2ff__Tax_Value_3__c=((price*s.ascent2ff__Tax_Rate_3__c) /100).setScale(2,System.RoundingMode.HALF_UP); 
                }
                         
            }

                 //If the Lines is not taxable then set the rates and values to 0

            if (s.PBSI__Taxable__c == false){

                    s.ascent2ff__Tax_Rate_1__c=0;
                    s.ascent2ff__Tax_Rate_2__c=0;
                    s.ascent2ff__Tax_Rate_3__c=0;
                    s.ascent2ff__Tax_Value_1__c=0;
                    s.ascent2ff__Tax_Value_2__c=0;
                    s.ascent2ff__Tax_Value_3__c=0;
            }

    } //Stop Cycling through the SO Lines

  } //End WSSOLineTaxRound
  
  //returns a comma seperated list of all the field names for an sObject
    public static string AllFieldNames(string stSObject) {
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        string st = '';
        
        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(stSObject).getDescribe().fields.getMap();
        for(Schema.SObjectField sfield : fieldMap.Values()) {
            schema.describefieldresult dfield = sfield.getDescribe();
            st = st + dfield.getname() + ', ';
        }
        if (st != '') {st = st.substring(0, (st.length() - 2));}
        
        return st;
    }
  }