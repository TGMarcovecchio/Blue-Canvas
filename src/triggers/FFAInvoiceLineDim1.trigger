trigger FFAInvoiceLineDim1 on c2g__codaInvoiceLineItem__c (before insert, before update) {
    c2g__codaInvoiceLineItem__c[] lstI = new List<c2g__codaInvoiceLineItem__c>();
    
    if (Trigger.IsInsert) {
        for (c2g__codaInvoiceLineItem__c i : trigger.new) {
            if (i.Opportunity_Lead_Source__c != null) lstI.add(i);
        }
        if (!lstI.isEmpty()) WS_FFA_SIN_Tools.FFAInvoiceLineDimension1(lstI);
    }
    else if(Trigger.IsUpdate) {
        for (c2g__codaInvoiceLineItem__c i : trigger.new) {
            if (i.c2g__Dimension1__c <> trigger.oldmap.get(i.id).c2g__Dimension1__c) lstI.add(i);
        }
        if (!lstI.isEmpty()) WS_FFA_SIN_Tools.FFAInvoiceLineDimension1(lstI);
    }
}