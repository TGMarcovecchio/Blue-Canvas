public with sharing class Util
{
  
  public void Recalculate(List<String> invoiceIds2, Map<String, Referral_Report_Card__c> invoiceMap)
  {
      list<c2g__codaInvoice__c> si1 = [select id,WS_Recalculate__c  from c2g__codaInvoice__c where id in : invoiceIds2 ];
      for(c2g__codaInvoice__c si : si1)
      {
          si.WS_Recalculate__c = false;
          
      }
      
      update si1;   
        
        
  }
  
   public void RecalculateNotes(List<String> invoiceIds2)
  {
      list<c2g__codaCreditNote__c> c1 = [select id from c2g__codaCreditNote__c where id in : invoiceIds2 ];
      for(c2g__codaCreditNote__c c : c1)
        {
          c.WS_Recalculate__c = false;
          
        }
        update c1;   
  }
}