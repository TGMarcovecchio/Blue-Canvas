global class WSFFJournalLineTools {

	public static void setDim13FFJournalLine(c2g__codaJournalLineItem__c[] lstJnlines) {

		
        Map<ID, ID> LineToJournal = new Map<ID,ID>(); //The Map of FF Journal Line Ids to their Journal Ids
        Map<ID, ID> JournalToSO = new Map<ID,ID>(); // The Map of FF Journal Ids to their Ascent Sales Order Ids
        Map<ID, ID> JournalToPay = new Map<ID, ID>();//The Map of FF Journal Ids to Customer Prepayment Ids
        Map<ID, ID> SOToOpp = new Map<ID,ID>(); //The Map of Ascent Sales Order Ids to their Opportunity Ids
        Map<ID,ID> PaymentToOpp = new Map<ID,ID>(); //The Map of Customer Prepayment Ids to Ascent Sales Order Ids
        Map<ID,String> OppToLeadSource = new Map<ID,String>(); //The Map of Opportunity Ids to their LeadSource value
        Map<ID,ID> OppToCampaign = new Map<ID,ID>(); //The Map of Opportunity Ids to their Primary Campaign Ids

        Map<String, ID> Dim1Map = new Map<String, ID>(); //The Map of FF Dimension 1 Names to their Ids
        Map<ID, ID> Dim3Map = new Map<ID,ID>(); //The Map of Campaign Ids to their FF Dimension3 Ids

        Set<ID> LineIds = new Set<ID>(); //The Set of FF Journal Line Ids
        Set<ID> JournalIds = new  Set<ID>(); //The Set of FF Journal Ids
        Set<ID> SOIds = new Set<ID>(); //The Set of Ascent Sales Order Ids
        Set<ID> OppIds = new Set<ID>(); //The Set of Opportunity Ids
        Set<ID> PaymentIds = new Set<ID>(); //The Set of Customer Prepayment Ids


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

        //Add the Journal Line Ids to a set, add the Journal Ids to a set, map the Line Id to their Journal Ids
        for(c2g__codaJournalLineItem__c line : lstJnLines){

        	LineIds.add(line.Id);
        	JournalIds.add(line.c2g__Journal__c);
            LineToJournal.put(line.Id,line.c2g__Journal__c);

        }

        //Generate a List of Journals from the Set of Journal Ids
 		List<c2g__codaJournal__c> lstJournals = [
 		SELECT Id, Ascent2FF__Production_Work_Order__c, Ascent2FF__Purchase_Order__c, Ascent2FF__RMA__c, Ascent2FF__Sales_Order__c, 
 		ConnectionReceivedId, ConnectionSentId, CreatedById, CreatedDate, From_SO_Lead_Source__c, IsDeleted, LastModifiedById, 
 		LastModifiedDate, Name, OwnerId, Payment__c, SystemModstamp, c2g__Credits__c,
 		c2g__Debits__c, c2g__DiscardReason__c, c2g__DualRate__c, c2g__ExternalId__c, c2g__IncomeScheduleGroup__c,
 		c2g__JournalCurrency__c, c2g__JournalDate__c, c2g__JournalDescription__c, c2g__JournalRate__c, c2g__JournalStatus__c, 
 		c2g__OriginalJournal__c, c2g__OverrideCurrency1__c, c2g__OverrideCurrency2__c, c2g__OverrideCurrency3__c, 
 		c2g__OverrideDebitValue1__c, c2g__OverrideDebitValue2__c, c2g__OverrideDebitValue3__c, c2g__OwnerCompany__c, c2g__Period__c, 
 		c2g__Reference__c, c2g__SourceJournal__c, c2g__Total__c, c2g__Transaction__c, c2g__Type__c, c2g__UnitofWork__c, c2g__Year__c, 
 		ffgl__DeriveCurrency__c, ffgl__DerivePeriod__c 
 		FROM c2g__codaJournal__c
 		WHERE Id IN: JournalIds
 		];

        //For the Journals in the list of Journals add the Payment Ids to a Set, map the Journal Ids to their Payment Ids
        //For the Journals in the list of Journals add the Sales Order Ids to a Set, map the Journal Ids to their Sales Order Ids
 		for(c2g__codaJournal__c journal : lstJournals){

 			if(journal.Payment__c != null){

 				PaymentIds.add(journal.Payment__c);
 				JournalToPay.put(journal.Id,journal.Payment__c);

 			}

 			if (journal.Ascent2FF__Sales_Order__c != null){

 				SOIds.add(journal.Ascent2FF__Sales_Order__c);
 				JournalToSO.put(journal.Id,journal.Ascent2FF__Sales_Order__c);

 			}

 		}

        //Generate the a list of Payments from the set of Payment Ids
 		List<Prepayment__c> lstPayments = [
 		SELECT Id, Account_Id__c, Amount__c, ConnectionReceivedId, ConnectionSentId, CreatedById, CreatedDate, Date_of_Payment__c, 
 		IsDeleted, LastModifiedById, LastModifiedDate, Method__c, Name, Opportunity__c, 
 		Opportunity_LeadSource__c, Origin__c, Processing_Fees__c, Reference__c, SystemModstamp 
 		FROM Prepayment__c
 		WHERE Id IN: PaymentIds
 		];

        //From the list of Payments add their Opportunity Ids to a set, Map the Payment Id to their Opportunity Ids
 		for(Prepayment__c payment : lstPayments){

 			OppIds.add(payment.Opportunity__c);
 			PaymentToOpp.put(payment.id, payment.Opportunity__c);
 		}

        //Generate a list of Sales Orders from the set of Sales Order Ids
 		List<PBSI__PBSI_Sales_Order__c> lstSalesOrders = [
 		SELECT Id, Amount_Due_on_SO__c, Ascent2FF__Company__c, Ascent2FF__Customer_Parent__c, Ascent2FF__Last_Shipment_Cost_From_Vendor__c, 
 		Ascent2FF__Last_Shipment_Cost_already_included__c, Ascent2FF__Misc_Charges_Already_Included__c, Ascent2FF__Proforma_Issued__c, 
 		ConnectionReceivedId, ConnectionSentId, CreatedById, CreatedDate, Discount_Reason__c, IsDeleted, LastActivityDate, LastModifiedById, 
 		LastModifiedDate, Mattress_Tracking_Number__c, Name, Opportunity_Lead_Source__c, OwnerId, 
 		PBSI__Actual_Shipping_Cost__c, PBSI__Address_Tracker__c, PBSI__BOL_Description__c, PBSI__BillingCity__c, PBSI__BillingCompany__c, PBSI__BillingCountry__c, 
 		PBSI__BillingState__c, PBSI__BillingStreet__c, PBSI__BillingZip__c, PBSI__Cleared_Date__c, PBSI__Comments__c, PBSI__Contact_Email__c, PBSI__Contact__c, 
 		PBSI__Created_From__c, PBSI__Customer_Purchase_Order__c, PBSI__Customer__c, PBSI__Days_Between_Scheduled_Shipments__c, PBSI__Delivery_ATTN_to_Phone__c, 
 		PBSI__Delivery_ATTN_to__c, PBSI__Delivery_Address_Type__c, PBSI__Delivery_Address_line2__c, PBSI__Delivery_Address_line_3__c, PBSI__Delivery_City__c, 
 		PBSI__Delivery_Company__c, PBSI__Delivery_Country__c, PBSI__Delivery_County__c, PBSI__Delivery_Postal_Code__c, PBSI__Delivery_State__c, 
 		PBSI__Delivery_Street__c, PBSI__Delivery_Streetnew__c, PBSI__Disable_Sales_Trade_Agreement__c, PBSI__Discount_Amount__c, PBSI__Due_Date__c, 
 		PBSI__External_ID__c, PBSI__Final_Order_Total4__c, PBSI__Final_Order_Total__c, PBSI__Final_Tax_Total__c, PBSI__Fixed_Cost_Shipping__c, 
 		PBSI__From_Location__c, PBSI__From_Quote__c, PBSI__From_RMA__c, PBSI__Gross_Weight__c, PBSI__Has_Drop_Ship_Lines__c, PBSI__Invoice_Date__c, 
 		PBSI__Invoiced_DIscount_Amount__c, PBSI__Lead_Source__c, PBSI__Misc_Charges__c, PBSI__Mode_of_Delivery__c, PBSI__Movement_Journal__c, 
 		PBSI__Net_Order_Total_4__c, PBSI__Net_Order_Total__c, PBSI__Number_Of_Lines__c, PBSI__Number_Of_Pending_Shipping_Lines__c, PBSI__Number_of_Shipments__c, 
 		PBSI__Order_Date__c, PBSI__Order_Discount__c, PBSI__Order_Subtotal4__c, PBSI__Order_Total__c, PBSI__Org_Exchange_Rate__c, PBSI__Opportunity__c,
 		PBSI__Packing_Category__c, PBSI__Packing_Date__c, PBSI__Picker__c, PBSI__PrecisioID__c, PBSI__Reason_for_Refund__c, 
 		PBSI__Refund_Amount__c, PBSI__Remaining_Shipments__c, PBSI__Sales_Tax__c, PBSI__Schedule_End_Date__c, PBSI__Schedule_Start_Date__c, PBSI__Ship_Location__c, 
 		PBSI__Shipping_Amount__c, PBSI__Shipping_Cost__c, PBSI__Shipping_Discount__c, PBSI__Shipping_Instructions__c, PBSI__Stage__c, PBSI__Staging_Location__c, 
 		PBSI__Staging_Movement_Journal__c, PBSI__Status__c, PBSI__Tax_Code__c, PBSI__Tax_on_Misc_Charges__c, PBSI__Tax_on_Shipping__c, PBSI__Terms_Conditions__c, 
 		PBSI__Total_Quant_To_Ship__c, PBSI__Total_Tax__c, PBSI__Tracking_Code__c, PBSI__Trade_Agreement__c, PBSI__Type__c, PBSI__User__c, PBSI__Weekday__c, 
 		PBSI__alt_Order_Total__c, PBSI__hasMJ__c, Primary_Campaign__c, Product_Delivered_Date__c, Shipping_Notes__c, Status_FFA_Tax_Text__c, 
 		Store_Accessories_needing_to_deliver__c, SystemModstamp, Test_Tax_Total__c, Total_Amount_Discounted__c, Total_Payment__c, toggle__c 
 		FROM PBSI__PBSI_Sales_Order__c
 		WHERE Id IN: SOIds
 		];

        //For the list of Sales Orders add their Opportunities to the set of Opportunity Ids, Map the Sales Order Ids to their Opportunity Ids
 		for(PBSI__PBSI_Sales_Order__c so : lstSalesOrders){

 			OppIds.add(so.PBSI__Opportunity__c);
 			SOToOpp.put(so.Id, so.PBSI__Opportunity__c);
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

        //For the Journal Lines Set their Dimension 1 and Dimension 3 Values using the established maps
        for(c2g__codaJournalLineItem__c lineup : lstJnlines){

            if(JournalToPay.get(lineup.c2g__Journal__c) != NULL){   //Use the Journal to Payment Relationship for the Line if the Journal has a Payment reference

                lineup.c2g__Dimension1__c = Dim1Map.get(OppToLeadSource.get(PaymentToOpp.get(JournalToPay.get(lineup.c2g__Journal__c))));
                lineup.c2g__Dimension3__c = Dim3Map.get(OppToCampaign.get(PaymentToOpp.get(JournalToPay.get(lineup.c2g__Journal__c))));

            }

            else if(JournalToSO.get(lineup.c2g__Journal__c) != NULL){  //Use the Journal to Sales Order Relationship for the Line if the Journal has a Sales Order reference

                lineup.c2g__Dimension1__c = Dim1Map.get(OppToLeadSource.get(SOToOpp.get(JournalToSO.get(lineup.c2g__Journal__c))));
                lineup.c2g__Dimension3__c = Dim3Map.get(OppToCampaign.get(SOToOpp.get(JournalToSO.get(lineup.c2g__Journal__c))));

            }


        }
		
	}

}