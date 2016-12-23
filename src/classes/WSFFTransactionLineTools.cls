public class WSFFTransactionLineTools {

	//public static void setDim13FFTranLine(c2g__codaTransactionLineItem__c[] lstTlines) 
	public static void setDim13FFTranLine(Set<Id> lineids) {

		Set<Id> tranids = new Set<Id>(); //Set of Transaction Ids

		List<c2g__codaTransaction__c> transactions = new List<c2g__codaTransaction__c>(); //List of Transactions
		List<c2g__codaTransactionLineItem__c> lstTlines = new List<c2g__codaTransactionLineItem__c>(); //List of Transactions
		List<c2g__codaTransactionLineItem__c> updatelines = new List<c2g__codaTransactionLineItem__c>(); //List of Transactions

		List<c2g__codaInvoice__c> invoices = new List<c2g__codaInvoice__c>(); //List of SINs
		List<c2g__codaCreditNote__c> notes = new List<c2g__codaCreditNote__c>(); //List of SCRN

		Map<Id,String> trandocmap = new Map<Id,String>();//Map of Transation Id to Document Number
		Set<String> docnums = new Set<String>();//Set of Document Numbers SIN
		Set<String> scrnums = new Set<String>();//Set of Document Numbers SCR

		Map<String,Id> docdim1map = new Map<String,Id>(); //Map of Transaction Id to DIM 1 Id
		Map<String,Id> docdim3map = new Map<String,Id>(); //Map of Transaction Id to DIM 3 Id
		
		//SObjectType transdsc = Schema.getGlobalDescribe().get('c2g__codaTransaction__c'); //sObject Describe of c2g__codaTransaction__c
		//Map<String,Schema.SObjectField> transflds = transdsc.getDescribe().fields.getMap(); //A Map of Fields on c2g__codaTransaction__c

		//SObjectType tranitemdsc = Schema.getGlobalDescribe().get('c2g__codaTransactionLineItem__c'); //sObject Describe of c2g__codaTransactionLineItem__c
		//Map<String,Schema.SObjectField> tranitemfld = tranitemdsc.getDescribe().fields.getMap(); //A Map of Fields on c2g__codaTransactionLineItem__c


		/*/Query for the Lines
    	string tlselect = 'SELECT ';
        for(string tif : tranitemfld.keyset()){
           tlselect = tlselect + tranitemfld.get(tif) + ', ';
        }
	        tlselect = tlselect.substring(0,tlselect.length()-2);
	       	tlselect = tlselect + '';
	        tlselect = tlselect + 'FROM c2g__codaTransactionLineItem__c WHERE Id IN: lineids';*/

	   String tlselect = 'SELECT Id, c2g__Transaction__c, c2g__Dimension1__c, c2g__Dimension2__c, c2g__Dimension3__c FROM c2g__codaTransactionLineItem__c WHERE Id In: lineids';

		try{
			lstTlines = (c2g__codaTransactionLineItem__c[])Database.query(tlselect); //The list of Transaction Lines
		}catch(Exception els){
			system.debug('***********************ERROR Querying Transaction Lines ***********************' + els.getMessage());
		}

		//*

		//Build Set of Transaction Ids
		for(c2g__codaTransactionLineItem__c tli : lstTlines){
			tranids.add(tli.c2g__Transaction__c); //Add the Transaction Ids to the set of transids
		}

		//Query for the c2g__codaTransaction__c and related TransactionLineItems
		string tselect = 'SELECT Id, c2g__DocumentNumber__c FROM c2g__codaTransaction__c WHERE Id IN: tranids';

    	try{
			transactions = (c2g__codaTransaction__c[])Database.query(tselect); //The list of Transactions
    	}catch(Exception ets){
    		system.debug('***********************ERROR Querying Transactions ***********************' + ets.getMessage());
    	}

    	//For each transaction found do something
    	if(!transactions.isEmpty()){
	    	for(c2g__codaTransaction__c tf : transactions){

	    		if(tf.c2g__DocumentNumber__c != NULL && tf.c2g__DocumentNumber__c != '' && tf.c2g__DocumentNumber__c.left(3) == 'SIN'){//Do something if the document is a SIN
	    			trandocmap.put(tf.id,tf.c2g__DocumentNumber__c); //Add the Transaction Id and Doc Number to a Map
	    			docnums.add(tf.c2g__DocumentNumber__c); //Add the Doc Number to a set of Doc Numbers
	    		}else if(tf.c2g__DocumentNumber__c != NULL && tf.c2g__DocumentNumber__c != '' && tf.c2g__DocumentNumber__c.left(3) == 'SCR'){//Do something if the document is a SCRN

	    			//Handle Sales Credit Notes
	    			trandocmap.put(tf.id,tf.c2g__DocumentNumber__c); //Add the Transaction Id and Doc Number to a Map
	    			scrnums.add(tf.c2g__DocumentNumber__c); //Add the Doc Number to a set of Doc Numbers
	    		}
	    		else{
	    			trandocmap.put(tf.id,NULL);
	    		}

	    	}
    	}

    	//Query for Sales Invoices
    	string iselect = 'SELECT Id, Name, c2g__Dimension1__c, c2g__Dimension3__c, c2g__Dimension2__c FROM c2g__codaInvoice__c WHERE Name IN: docnums';

		try{
			invoices = (c2g__codaInvoice__c[])Database.query(iselect); //The list of related SINs
    	}catch(Exception es){
    		system.debug('***********************ERROR Querying SINS ***********************' + es.getMessage());
    	}

    	//Query for Sales Credit Notes
    	string cselect = 'SELECT Id, Name, c2g__Account__c, c2g__Invoice__c, c2g__Opportunity__c, Ascent2FF__RMA__c, c2g__Dimension1__c, c2g__Dimension3__c, c2g__Dimension2__c, c2g__Dimension4__c FROM c2g__codaCreditNote__c WHERE Name IN: scrnums';
    	try{
			notes = (c2g__codaCreditNote__c[])Database.query(cselect); //The list of related SINs
    	}catch(Exception esn){
    		system.debug('***********************ERROR Querying SCRNs ***********************' + esn.getMessage());
    	}


    	//Do something for the invoices
    	if(!invoices.isEmpty()){

    		for(c2g__codaInvoice__c i : invoices){ //Loop through the invoices

    			if(i.c2g__Dimension1__c != NULL){
    				docdim1map.put(i.name,i.c2g__Dimension1__c); //Add the transaction Id and Dim1 Id to the map
    			}else{
    				docdim1map.put(i.name,NULL);
    			}

    			if(i.c2g__Dimension3__c != NULL){
    				docdim3map.put(i.name,i.c2g__Dimension3__c); //Add the transaction Id and Dim3 Id to the map
    			}else{
    				docdim3map.put(i.name,NULL);
    			}
    		}

    	} //End if transactions !isEmpty()

    	//Do something for the notes
		if(!notes.isEmpty()){

    		for(c2g__codaCreditNote__c n : notes){ //Loop through the notes

    			if(n.c2g__Dimension1__c != NULL){
    				docdim1map.put(n.name,n.c2g__Dimension1__c); //Add the transaction Id and Dim1 Id to the map
    			}else{
    				docdim1map.put(n.name,NULL);
    			}

    			if(n.c2g__Dimension3__c != NULL){
    				docdim3map.put(n.name,n.c2g__Dimension3__c); //Add the transaction Id and Dim3 Id to the map
    			}else{
    				docdim3map.put(n.name,NULL);
    			}
    		}

    	} //End if transactions !isEmpty()



    	if(!lstTlines.isEmpty()){

    		for(c2g__codaTransactionLineItem__c ol : lstTlines){

    			if(trandocmap.get(ol.c2g__Transaction__c) != NULL){

	    			ol.c2g__Dimension1__c = docdim1map.get(trandocmap.get(ol.c2g__Transaction__c)); //Get the DIM 1 Value
	    			ol.c2g__Dimension3__c = docdim3map.get(trandocmap.get(ol.c2g__Transaction__c)); //Get the DIM 3 Value

	    			updatelines.add(ol); //Add the line to the list of lines to update

    			}
    		
    		}

    	} //End if trandim1map !isEmpty()

    	if(!updatelines.isEmpty()){

    		update updatelines;
    		
    	} //End if updatelines !isEmpty()

	} //End setDim13FFJournalLine

}