trigger creditCommissions on c2g__codaCreditNote__c (before insert, before update, after update) 
{
	WS_Custom_Admin_Settings__c atr = WS_Custom_Admin_Settings__c.getInstance();
	if(atr != null && atr.Turn_off_Commissions__c == false && atr.Turn_Off_All_APEX_Triggers__c == false)
	{
	  if(trigger.isafter)
	  {
	    List<String> creditIds = new List<String>();
	    List<String> creditids2 = new List<String>();
	    for(c2g__codaCreditNote__c c : Trigger.new)
	    {
	       if(c.c2g__CreditNoteStatus__c == 'Complete' && (c.c2g__CreditNoteStatus__c != Trigger.oldMap.get(c.id).c2g__CreditNoteStatus__c || (c.WS_Recalculate__c == true && c.WS_Recalculate__c != Trigger.oldMap.get(c.id).WS_Recalculate__c )))
	       {
	           creditIds.add(c.id);
	       } 
	       if(c.c2g__CreditNoteStatus__c == 'Complete' && c.WS_Recalculate__c == true && c.WS_Recalculate__c != Trigger.oldMap.get(c.id).WS_Recalculate__c )
	       {
	           creditids2.add(c.id);
	       }
	       
	    }
	    
	    if(creditIds.size()>0)
	    {
	         CommissionsHandler c = new CommissionsHandler();
	            c.CreditSalesInvoice(creditIds);
	    }
	    if(creditids2.size()>0)
	    {
	        Util u = new Util();
	          u.RecalculateNotes(creditids2);
	    }
	    
	  }
	  if(trigger.isbefore)
	  {
	  
	  
	    for(c2g__codaCreditNote__c c : Trigger.new)
	    {
	       if(c.c2g__CreditNoteStatus__c != 'Complete' && c.WS_Recalculate__c == true )
	       {
	           c.WS_Recalculate__c = false;
	       } 
	    }
	  
	  } 
	}
}