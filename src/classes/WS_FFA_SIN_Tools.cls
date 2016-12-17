public class WS_FFA_SIN_Tools {
	
	
	public static void FFAInvoiceDimension1(c2g__codaInvoice__c[] trINV, boolean isUpdate) {
		string stTmp;
		boolean hasOLS = false; //OLS = Opportunity Lead Source
		Set<ID> sSINId = new Set<ID>();
		
		for (c2g__codaInvoice__c i: trINV) {
			if (i.Opportunity_Lead_Source__c != null) {
				hasOLS = true;
			}
		}
		if (!hasOLS) return;
		
		//get a list of the picklist values for the LeadSource field on Opportunity (Intellibed uses these as "Sales Channel")
		Schema.DescribeFieldResult fieldResult = Opportunity.LeadSource.getDescribe();
		PicklistEntry[] lstOppLeadSource = fieldResult.getPicklistValues();
		
		//get a list of the Dimension1 objects. These are also used by Intellibed as "Sales Channel"
		c2g__codaDimension1__c[] lstDIM1 = [SELECT Id, Name, c2g__ReportingCode__c FROM c2g__codaDimension1__c ORDER BY Name];
		
		//make a map of the picklist value to the matching Dimension1 object Id
		Map<string, ID> mLeadSrcToDIM1 = new Map<string, ID>();
		for (PicklistEntry p : lstOppLeadSource) {
			stTmp = p.getValue();
			for (c2g__codaDimension1__c d : lstDIM1) {
				if (stTmp == d.Name) {
					mLeadSrcToDIM1.put(stTmp, d.Id);
					break;
				}
			}
		}
		
		for (c2g__codaInvoice__c i: trINV) {
			if (mLeadSrcToDIM1.containsKey(i.Opportunity_Lead_Source__c)) {
				i.c2g__Dimension1__c = mLeadSrcToDIM1.get(i.Opportunity_Lead_Source__c);
				sSINId.add(i.Id);
			}
		}
		
		if (isUpdate) {
			c2g__codaInvoiceLineItem__c[] lstSINLines = [
				SELECT c2g__Invoice__c, c2g__Dimension1__c, c2g__Invoice__r.Opportunity_Lead_Source__c 
				FROM c2g__codaInvoiceLineItem__c 
				WHERE c2g__Invoice__c IN :sSINId 
				ORDER BY c2g__Invoice__c 
			];
			
			if (lstSINLines != null && !lstSINLines.isEmpty()) {
				for (c2g__codaInvoiceLineItem__c invl : lstSINLines) {
					invl.c2g__Dimension1__c = mLeadSrcToDIM1.get(invl.c2g__Invoice__r.Opportunity_Lead_Source__c);
				}
				
				update lstSINLines;
			}
		}
		
	}
	
	
	public static void FFAInvoiceLineDimension1(c2g__codaInvoiceLineItem__c[] trInvL) {
		string stTmp;
		boolean hasOLS = false; //OLS = Opportunity Lead Source
		
		for (c2g__codaInvoiceLineItem__c invl: trInvL) {
			if (invl.Opportunity_Lead_Source__c != null) {
				hasOLS = true;
			}
		}
		if (!hasOLS) return;
		
		//get a list of the picklist values for the LeadSource field on Opportunity (Intellibed uses these as "Sales Channel")
		Schema.DescribeFieldResult fieldResult = Opportunity.LeadSource.getDescribe();
		PicklistEntry[] lstOppLeadSource = fieldResult.getPicklistValues();
		
		//get a list of the Dimension1 objects. These are also used by Intellibed as "Sales Channel"
		c2g__codaDimension1__c[] lstDIM1 = [SELECT Id, Name, c2g__ReportingCode__c FROM c2g__codaDimension1__c ORDER BY Name];
		
		//make a map of the picklist value to the matching Dimension1 object Id
		Map<string, ID> mLeadSrcToDIM1 = new Map<string, ID>();
		for (PicklistEntry p : lstOppLeadSource) {
			stTmp = p.getValue();
			for (c2g__codaDimension1__c d : lstDIM1) {
				if (stTmp == d.Name) {
					mLeadSrcToDIM1.put(stTmp, d.Id);
					break;
				}
			}
		}
		
		for (c2g__codaInvoiceLineItem__c invl: trInvL) {
			if (mLeadSrcToDIM1.containsKey(invl.Opportunity_Lead_Source__c)) {
				invl.c2g__Dimension1__c = mLeadSrcToDIM1.get(invl.Opportunity_Lead_Source__c);
			}
		}
		
	}
	
	
	/*
	public static void FFAInvoiceDimension1_v2(c2g__codaInvoice__c[] trINV) {
	//this version doesn't rely on the Opportunity_Lead_Source__c formula fields to work
	
		string stTmp;
		
		Set<ID> sSOID = new Set<ID>();
		for (c2g__codaInvoice__c i: trINV) {
			if (i.Ascent2FF__Sales_Order__c != null) sSOID.add(i.Ascent2FF__Sales_Order__c);
		}
		if (sSOID.isEmpty()) return;
		
		PBSI__PBSI_Sales_Order__c[] lstSO = [
			SELECT Id, PBSI__Opportunity__r.LeadSource 
			FROM PBSI__PBSI_Sales_Order__c 
			WHERE Id IN :sSOID AND PBSI__Opportunity__r.LeadSource != null
		];
		if (lstSO.isEmpty() || lstSO == null) return;
		
		//get a list of the picklist values for the LeadSource field on Opportunity (Intellibed uses these as "Sales Channel")
		Schema.DescribeFieldResult fieldResult = Opportunity.LeadSource.getDescribe();
		PicklistEntry[] lstOppLeadSource = fieldResult.getPicklistValues();
		//lstOppLeadSource.sort();
		
		//get a list of the Dimension1 objects. These are also used by Intellibed as "Sales Channel"
		c2g__codaDimension1__c[] lstDIM1 = [SELECT Id, Name, c2g__ReportingCode__c FROM c2g__codaDimension1__c ORDER BY Name];
		
		//make a map of the picklist value to the matching Dimension1 object Id
		Map<string, ID> mLeadSrcToDIM1 = new Map<string, ID>();
		for (PicklistEntry p : lstOppLeadSource) {
			stTmp = p.getValue();
			for (c2g__codaDimension1__c d : lstDIM1) {
				if (stTmp == d.Name) {
					mLeadSrcToDIM1.put(stTmp, d.Id);
					break;
				}
			}
		}
		
		//make a Map of Sales Order IDs to their corresponding LeadSource Dimension1 ID
		Map<ID, ID> mSOtoDIM1 = new Map<ID, ID>();
		for (PBSI__PBSI_Sales_Order__c so : lstSO) {
			stTmp = so.PBSI__Opportunity__r.LeadSource;
			if (mLeadSrcToDIM1.containsKey(stTmp)) mSOtoDIM1.put(so.Id, mLeadSrcToDIM1.get(stTmp));
		}
		
		//set the Dimension1 field on the FFA invoices
		for (c2g__codaInvoice__c i: trINV) {
			if (mSOtoDIM1.containsKey(i.Ascent2FF__Sales_Order__c)) i.c2g__Dimension1__c = mSOtoDIM1.get(i.Ascent2FF__Sales_Order__c);
		}
	
	}
	*/
	
	
	@isTest (seeAllData=true)
	public static void FFAInvoiceDimension1_Test() {
		c2g__codaInvoice__c[] lstInv = [
			SELECT Opportunity_Lead_Source__c, c2g__Dimension1__c, c2g__Account__c 
			FROM c2g__codaInvoice__c 
			WHERE Opportunity_Lead_Source__c != null 
			LIMIT 1
		];
		
		WS_FFA_SIN_Tools.FFAInvoiceDimension1(lstInv, true);
		
		c2g__codaInvoice__c inv = lstInv[0].clone(false, true);
        inv.c2g__Account__c = lstInv[0].c2g__Account__c;
		try {
			insert inv;
		}
		catch (DmlException e) {
			system.debug('dbgx-1: ' + e);
		}
		
		inv = lstInv[0];
		inv.c2g__InvoiceDescription__c = 'test';
		try {
			update inv;
		}
		catch (DmlException e) {
			system.debug('dbgx-2: ' + e);
		}
	}
	
	
	@isTest (seeAllData=true)
	public static void FFAInvoiceLineDimension1_Test() {
		c2g__codaInvoiceLineItem__c[] lstInvL = [
			SELECT Opportunity_Lead_Source__c, c2g__Dimension1__c, c2g__Invoice__c, c2g__Product__c, c2g__DeriveUnitPriceFromProduct__c 
			FROM c2g__codaInvoiceLineItem__c 
			WHERE Opportunity_Lead_Source__c != null 
			LIMIT 1
		];
		
		WS_FFA_SIN_Tools.FFAInvoiceLineDimension1(lstInvL);
        
        c2g__codaInvoice__c[] lstInv = [
			SELECT Opportunity_Lead_Source__c, c2g__Dimension1__c, c2g__Account__c 
			FROM c2g__codaInvoice__c 
			WHERE Opportunity_Lead_Source__c != null 
			LIMIT 1
		];
		
		c2g__codaInvoice__c inv = lstInv[0].clone(false, true);
        inv.c2g__Account__c = lstInv[0].c2g__Account__c;
		try {
			insert inv;
		}
		catch (DmlException e) {
			system.debug('dbgx-3: ' + e);
		}
		
		c2g__codaInvoiceLineItem__c invl = lstInvL[0].clone(false, true);
        invl.c2g__Invoice__c = inv.Id;
        invl.c2g__Product__c = lstInvL[0].c2g__Product__c;
        invl.c2g__DeriveUnitPriceFromProduct__c = false;
        try {insert invl;}
        catch (DmlException e) {system.debug('dbgx-4: ' + e);}
		
	}


}