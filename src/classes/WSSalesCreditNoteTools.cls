public class WSSalesCreditNoteTools {
	
	//public WSSalesCreditNoteTools() {
		
	//}

	public static void setDim13FFSalesCreditNote(c2g__codaCreditNote__c[] lstnotes) {

		//c2g__codaCreditNote__c
		//c2g__codaCreditNoteLineItem__c
		
        Map<ID, ID> LineToNote = new Map<ID,ID>(); //The Map of FF Note Line Ids to their Note Ids

        Map<ID, ID> NoteToOpp = new Map<ID, ID>(); //The Map of the Note to the Opp
		
		Map<ID, ID> NoteToSIN = new Map<ID, ID>();//The Map of Note to SIN
		Map<ID,ID> SINToDim1 = new Map<ID,ID>(); //The Map of SIN to DIM 1
		Map<ID,ID> SINToDim3 = new Map<ID,ID>(); //The Map of SIN to DIM 3
        Map<ID,ID> SINToSO = new Map<ID,ID>(); //The Map of SIN to SO
        Map<ID,ID> SINtoOpp = new Map<ID,ID>(); //The Map of SIN to OPP

        Map<ID, ID> NotetoRMA = new Map<ID,ID>(); // The Map of Note to RMA
        Map<ID, ID> RMAtoSO = new Map<ID,ID>(); //The Map of RMA to SO
        Map<ID, ID> SOtoOpp = new Map<ID, ID>(); //The Map of SO to Opp

        Map<ID,String> OppToLeadSource = new Map<ID,String>(); //The Map of Opportunity Ids to their LeadSource value
        Map<ID,ID> OppToCampaign = new Map<ID,ID>(); //The Map of Opportunity Ids to their Primary Campaign Ids

        Map<String, ID> Dim1Map = new Map<String, ID>(); //The Map of FF Dimension 1 Names to their Ids
        Map<ID, ID> Dim3Map = new Map<ID,ID>(); //The Map of Campaign Ids to their FF Dimension3 Ids

        Set<ID> LineIds = new Set<ID>(); //The Set of FF Note Line Ids
        Set<ID> NoteIds = new  Set<ID>(); //The Set of FF Note Ids
        Set<ID> RMAIds = new Set<ID>(); //The Set of Ascent Sales Order Ids
        Set<ID> OppIds = new Set<ID>(); //The Set of Opportunity Ids
        Set<ID> SINIds = new Set<ID>(); //The Set of Customer Prepayment Ids
        Set<ID> SOIds = new Set<ID>(); //The Set of Sales Order Ids

        //List<c2g__codaCreditNote__c> lstNotes = new List<c2g__codaCreditNote__c>(); //The list of Credit Notes

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
        ];

        //Map the Campaign Id To Their Dimension 3 Id
        for(Campaign c : lstCampaigns){
            Dim3Map.put(c.Id, c.Dimension_3__c);
        }

        //Add the Note Line Ids to a set, add the Note Ids to a set, map the Line Id to their Note Ids
        for(c2g__codaCreditNote__c note : lstnotes){
        	NoteIds.add(note.Id);
        }

		/*SObjectType notedesc = Schema.getGlobalDescribe().get('c2g__codaCreditNote__c'); //sObject Describe of c2g__codaCreditNote__c
		Map<String,Schema.SObjectField> noteflds = notedesc.getDescribe().fields.getMap(); //A Map of Fields on c2g__codaCreditNote__c

		//Query for the c2g__codaCreditNote__c
    	string nselect = 'SELECT Id, ';
        for(string ntf : noteflds.keyset()){
           nselect = nselect + noteflds.get(ntf) + ', ';
        }        

        nselect = nselect.substring(0,nselect.length()-2);
       	nselect = nselect + '';
        nselect = nselect + ' FROM c2g__codaCreditNote__c WHERE Id IN: NoteIds';
		
		try{
			lstNotes = (c2g__codaCreditNote__c[])Database.query(nselect); //The list of c2g_codaNote__c
    	}catch(Exception ets){
    		system.debug('***********************ERROR Querying Credit Notes ***********************' + ets.getMessage());
    	}*/
 
        //For the Notes in the list of Notes add the Payment Ids to a Set, map the Note Ids to their Payment Ids
        //For the Notes in the list of Notes add the Sales Order Ids to a Set, map the Note Ids to their Sales Order Ids
 		for(c2g__codaCreditNote__c Note : lstNotes){

 			if(Note.c2g__Opportunity__c != NULL){
 				NoteToOpp.put(Note.Id,Note.c2g__Opportunity__c);
 				OppIds.add(Note.c2g__Opportunity__c);
 			}

 			if(Note.c2g__Invoice__c != null){
 				SINIds.add(Note.c2g__Invoice__c);
 				NoteToSIN.put(Note.Id,Note.c2g__Invoice__c);
 			}

 			if (Note.Ascent2FF__RMA__c != null){
 				RMAIds.add(Note.Ascent2FF__RMA__c);
 				NotetoRMA.put(Note.Id,Note.Ascent2FF__RMA__c);
 			}

 		}

        //Generate the a list of Invoices from the set of Invoice Ids
 		List<c2g__codaInvoice__c> lstInvoices = [
 		SELECT Id, c2g__Dimension1__c, c2g__Dimension3__c, c2g__Opportunity__c, Ascent2FF__Sales_Order__c
 		FROM c2g__codaInvoice__c
 		WHERE Id IN: SINIds
 		];

        //From the list of Invoices add Map the Invoice Id to their SIN Ids
 		for(c2g__codaInvoice__c invoice : lstInvoices){
 			SINToDim1.put(invoice.id, invoice.c2g__Dimension1__c);
 			SINToDim3.put(invoice.id, invoice.c2g__Dimension3__c);
            SINToSO.put(invoice.id,invoice.Ascent2FF__Sales_Order__c);
            if(invoice.Ascent2FF__Sales_Order__c != NULL){
                SOIds.add(invoice.Ascent2FF__Sales_Order__c);
            }
            SINtoOpp.put(invoice.id,invoice.c2g__Opportunity__c);
 		}

 		//Generate the list of RMAs from the set of RMA Ids
 		List<Case> lstCase = [
 		SELECT Id, PBSI__Sales_Order__c
 		FROM  Case
 		WHERE Id IN: RMAIds
 		];

 		for(Case rma : lstCase){
 			if(rma.PBSI__Sales_Order__c != NULL){
 				RMAtoSO.put(rma.Id, rma.PBSI__Sales_Order__c);
 				SOIds.add(rma.PBSI__Sales_Order__c);
 			}
 		}

 		//Generate the list of Sales Orders from the set of SOIds
 		List<PBSI__PBSI_Sales_Order__c> lstSalesOrders = [
 		SELECT Id, PBSI__Lead_Source__c, PBSI__Opportunity__c
 		FROM PBSI__PBSI_Sales_Order__c
 		WHERE Id IN: SOIds
 		];

 		for(PBSI__PBSI_Sales_Order__c so : lstSalesOrders){

 			if(so.PBSI__Opportunity__c != NULL){
 				OppIds.add(so.PBSI__Opportunity__c);
 				SOtoOpp.put(so.Id,so.PBSI__Opportunity__c);
 			}
 		}

        //Generate a List of Opportunities from the set of Opportunity Ids
        List<Opportunity> lstOpportunities = [
        SELECT Id, LeadSource, AccountId, CampaignId, Primary_Campaign_Name__c    
        FROM Opportunity
        WHERE Id IN: OppIds
        ];

        //For the Opportunities in the list of Opportunities map their Ids to their LeadSource and CampaignId
        for (Opportunity opp : lstOpportunities){
            OppToLeadSource.put(opp.id, opp.LeadSource);
            OppToCampaign.put(opp.id, opp.CampaignId);
        }

        //For the Note Lines Set their Dimension 1 and Dimension 3 Values using the established maps
        for(c2g__codaCreditNote__c noteup : lstnotes){

        	if(NoteToOpp.get(noteup.id) != NULL){
        		noteup.c2g__Dimension1__c = Dim1Map.get(OppToLeadSource.get(NoteToOpp.get(noteup.id)));
        		noteup.c2g__Dimension3__c = Dim3Map.get(OppToCampaign.get(NoteToOpp.get(noteup.id)));
        	}

            else if(NoteToSIN.get(noteup.id) != NULL){   //Use the Note to Payment Relationship for the Line if the Note has a Payment reference
                noteup.c2g__Dimension1__c = SINToDim1.get(NoteToSIN.get(noteup.id));
                noteup.c2g__Dimension3__c = SINToDim3.get(NoteToSIN.get(noteup.id));
            }

            else if(NotetoRMA.get(noteup.id) != NULL){  //Use the Note to Sales Order Relationship for the Line if the Note has a Sales Order reference
                
                noteup.c2g__Dimension1__c = Dim1Map.get(OppToLeadSource.get(SOtoOpp.get(RMAtoSO.get(NotetoRMA.get(noteup.id)))));
                noteup.c2g__Dimension3__c = Dim3Map.get(OppToCampaign.get(SOtoOpp.get(RMAtoSO.get(NotetoRMA.get(noteup.id)))));

                if(noteup.c2g__Opportunity__c == null  && SOtoOpp.get(RMAtoSO.get(NotetoRMA.get(noteup.id))) != null){

                	noteup.c2g__Opportunity__c = SOtoOpp.get(RMAtoSO.get(NotetoRMA.get(noteup.id))); // Set the Opportunity Id if it's null

                }else if(noteup.c2g__Opportunity__c == null && SOtoOpp.get(SINtoSO.get(NotetoSIN.get(noteup.id))) != null){

                    noteup.c2g__Opportunity__c = SOtoOpp.get(SINtoSO.get(NotetoSIN.get(noteup.id))); // Set the Opportunity Id if it's null

                }else if(noteup.c2g__Opportunity__c == null && SINtoOpp.get(NoteToSIN.get(noteup.id)) != null ){

                    noteup.c2g__Opportunity__c = SINtoOpp.get(NoteToSIN.get(noteup.id));
                }
            }


        }
		
	}
}