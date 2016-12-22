trigger FFAInvoiceDim1 on c2g__codaInvoice__c (before insert, before update) {
    c2g__codaInvoice__c[] lstI = new List<c2g__codaInvoice__c>();
    
    if (Trigger.IsInsert) {
        for (c2g__codaInvoice__c i : trigger.new) {
            if (i.Ascent2FF__Sales_Order__c != null) lstI.add(i);
        }
        if (!lstI.isEmpty()) WS_FFA_SIN_Tools.FFAInvoiceDimension1(lstI, false);
    }
    else if(Trigger.IsUpdate) {
        for (c2g__codaInvoice__c i : trigger.new) {
            if (i.Ascent2FF__Sales_Order__c <> trigger.oldmap.get(i.id).Ascent2FF__Sales_Order__c || i.c2g__Dimension1__c <> trigger.oldmap.get(i.id).c2g__Dimension1__c) lstI.add(i);
        }
        if (!lstI.isEmpty()) WS_FFA_SIN_Tools.FFAInvoiceDimension1(lstI, true);
    }
}