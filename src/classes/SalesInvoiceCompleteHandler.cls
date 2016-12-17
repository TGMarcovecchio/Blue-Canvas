public with sharing class SalesInvoiceCompleteHandler 
{
    List<Referral_Report_Card__c> referralReportList = new List<Referral_Report_Card__c>();
    
    public void recalculateReferralReport(List<String> invoiceIds)
    {
        System.debug('***** Invoice Ids ******* '+invoiceIds);
        
        List<c2g__codaInvoiceLineItem__c> il_list = [Select id, name, 
                             // Ascent2FF__Sales_Order__c,
                             // Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Name_text__c,
                             // Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c,
                              c2g__Invoice__c,
                              c2g__Quantity__c,
                              
                              c2g__Invoice__r.c2g__Account__c,
                              c2g__Invoice__r.c2g__Period__c,
                              Item_Group__c,c2g__NetValue__c,
                              c2g__Product__r.Item_Group__c,
                              c2g__Invoice__r.Void__c,
                              c2g__Invoice__r.c2g__NetTotal__c,
                              c2g__Invoice__r.In_Referral_Report__c,
                              Is_Eligible__c,
                              c2g__Invoice__r.Referral_Partner_Id__c
                              from c2g__codaInvoiceLineItem__c where c2g__Invoice__c in : invoiceIds  and Is_Eligible__c = true];
                              
         System.debug('***** Invoice Line Item Size ******* '+il_list.size());  
                            
         List<String> invoiceLineIds = new List<String>();
         Map<String, String> lineReferralMap = new Map<String, String>();
         List<String> referralIds = new List<String>();
         
         for(c2g__codaInvoiceLineItem__c  c : il_list )
         {
              invoiceLineIds.add(c.id);
         } 
         
         List<Gamification_Document__c> ExistingJunctionList = [select id, 
                                                        Referral_Report__c,
                                                        Sales_Invoice_Line_Item__c from Gamification_Document__c where Sales_Invoice_Line_Item__c in: invoiceLineIds];
           
         System.debug('***** Gamification List ******* '+ExistingJunctionList); 
         for(Gamification_Document__c g : ExistingJunctionList)
         {
            lineReferralMap.put(g.Sales_Invoice_Line_Item__c, g.Referral_Report__c);
            
         } 
         
         List<String> accountIdList = new List<String>();
         List<String> periodIdList = new List<String>();
         List<String> ItemGroupIdList = new List<String>();
              
          for(c2g__codaInvoiceLineItem__c cil : il_list)
          {
                        accountIdList.add(cil.c2g__Invoice__r.Referral_Partner_Id__c);
                        periodIdList.add(cil.c2g__Invoice__r.c2g__Period__c);
                        ItemGroupIdList.add(cil.c2g__Product__r.Item_Group__c);
                        
          }
            
        referralReportList = [select id,
                                            Account__c,
                                            Item_Group__c,
                                            Period__c
                                            from Referral_Report_Card__c where 
                                            Account__c in: accountIdList AND (
                                            Item_Group__c in: ItemGroupIdList OR
                                            Period__c in: periodIdList)];   
        
        for(c2g__codaInvoiceLineItem__c c : il_list)
        {
            for(Referral_Report_Card__c r : referralReportList)
            {
                if(lineReferralMap.get(c.id) == r.id)
                {
                    System.debug(r+'***** Inside If ******* '+c);
            
                }
            }
        }   
        
         update referralReportList;
         
         delete ExistingJunctionList;
         
         calculateFromLines(il_list);
           
    }
    
    public void calculateFromLines(List<c2g__codaInvoiceLineItem__c> il_list)
    {
        List<Gamification_Document__c> junctionList = new List<Gamification_Document__c>();
        List<String> invoiceIdsToBeUpdate = new List<String>();
         List<Referral_Report_Card__c> rList = new List<Referral_Report_Card__c>();
         List<Gamification_Document__c> ExistingJunctionList = new List<Gamification_Document__c>();
        for(c2g__codaInvoiceLineItem__c c : il_list)
                {
                    System.debug('*****insidefor******');  
                    boolean b = false;
                    for(Referral_Report_Card__c r : referralReportList)
                    {
                         if( c.c2g__Invoice__r.Referral_Partner_Id__c != null && c.c2g__Invoice__r.Referral_Partner_Id__c.length() >= 15 )
                        {
                        if(c.c2g__Invoice__r.Referral_Partner_Id__c == r.Account__c && c.c2g__Product__r.Item_Group__c == r.Item_Group__c && c.c2g__Invoice__r.c2g__Period__c == r.Period__c)
                        {
                            b = true;
                            invoiceIdsToBeUpdate.add(c.c2g__Invoice__c);
                          
                           
                           if(junctionList.size()==0)
                           {
                               if(c.Is_Eligible__c)
                               {
                                   Gamification_Document__c g = new Gamification_Document__c();
                                   g.Sales_Invoice_Line_Item__c = c.id;
                                   g.Referral_Report__c = r.id;
                                   junctionList.add(g);
                               }
                           }
                           else
                           {
                           boolean c1 = false;
                           for(Gamification_Document__c  j: junctionList)
                           {
                               if(j.Sales_Invoice_Line_Item__c  == c.id && j.Referral_Report__c  == r.id)
                               {
                                   c1 = true;
                                   break;
                               }
                           }
                           if(!c1 && c.Is_Eligible__c)
                           {
                                Gamification_Document__c g = new Gamification_Document__c();
                               g.Sales_Invoice_Line_Item__c = c.id;
                               g.Referral_Report__c = r.id;
                               junctionList.add(g);
                           }
                           }
                           
                            break;
                        }
                        }
                    }
                    if(!b)
                    {
                        System.debug('*****insideif!b******'); 
                        boolean b1=false;
                        for(Referral_Report_Card__c rr1 : rList)
                        {
                                
                        
                        
                             if( c.c2g__Invoice__r.Referral_Partner_Id__c != null && c.c2g__Invoice__r.Referral_Partner_Id__c.length() >= 15 )  
                            {
                            System.debug('*****insideforif******'); 
                            if(c.c2g__Invoice__r.Referral_Partner_Id__c == rr1.Account__c && c.c2g__Product__r.Item_Group__c == rr1.Item_Group__c && c.c2g__Invoice__r.c2g__Period__c == rr1.Period__c)
                            {
                                b1=true;
                                boolean checkB = false;
                                    for(String s : invoiceIdsToBeUpdate)
                                    {
                                        if(c.c2g__Invoice__c == s)
                                        {
                                            checkB = true;
                                            break;
                                        }
                                    }
                                 System.debug(c.c2g__Invoice__c+'**************** CheckB'+checkB);   
                                invoiceIdsToBeUpdate.add(c.c2g__Invoice__c);
                                
                                                                                              
                                  if(junctionList.size()==0 && c.Is_Eligible__c)
                           {
                               Gamification_Document__c g = new Gamification_Document__c();
                               g.Sales_Invoice_Line_Item__c = c.id;
                               g.Referral_Report__c = rr1.id;
                               junctionList.add(g);
                           }
                           else
                           {
                           boolean c1 = false;
                           for(Gamification_Document__c  j: junctionList)
                           {
                               if(j.Sales_Invoice_Line_Item__c  == c.id && j.Referral_Report__c  == rr1.id)
                               {
                                   c1 = true;
                                   break;
                               }
                           }
                           if(!c1 && c.Is_Eligible__c)
                           {
                                Gamification_Document__c g = new Gamification_Document__c();
                               g.Sales_Invoice_Line_Item__c = c.id;
                               g.Referral_Report__c = rr1.id;
                               junctionList.add(g);
                           }
                           }
                           
                              //rList.add(rr1);
                              system.debug('*********rr1*******'+rList);
                            }
                            }
                            
                            
                            
                        }
                        if(b1)
                        {
                            update rList;
                        }
                        if(!b1)
                        {
                          if( c.c2g__Invoice__r.Referral_Partner_Id__c != null && c.c2g__Invoice__r.Referral_Partner_Id__c.length() >= 15 )  
                            {
                                System.debug('*****insideelse******'); 
                                Referral_Report_Card__c rr = new Referral_Report_Card__c();
                                rr.Account__c=c.c2g__Invoice__r.Referral_Partner_Id__c;
                                //rr.Account__c=c.c2g__Invoice__r.c2g__Account__c;
                                //rr.Item_Group__c=itemMap.get(c.Item_Group__c);
                                rr.Item_Group__c=c.c2g__Product__r.Item_Group__c;
                                rr.Period__c=c.c2g__Invoice__r.c2g__Period__c;
                               
                                invoiceIdsToBeUpdate.add(c.c2g__Invoice__c);
                                insert rr;
                                System.debug(invoiceIdsToBeUpdate+'**************** invoiceIdsToBeUpdate');   
                                  if(junctionList.size()==0 && c.Is_Eligible__c)
                           {
                               Gamification_Document__c g = new Gamification_Document__c();
                               g.Sales_Invoice_Line_Item__c = c.id;
                               g.Referral_Report__c = rr.id;
                               junctionList.add(g);
                           }
                           else
                           {
                           boolean c1 = false;
                           for(Gamification_Document__c  j: junctionList)
                           {
                               if(j.Sales_Invoice_Line_Item__c  == c.id && j.Referral_Report__c  == rr.id)
                               {
                                   c1 = true;
                                   break;
                               }
                           }
                           if(!c1 && c.Is_Eligible__c)
                           {
                                Gamification_Document__c g = new Gamification_Document__c();
                               g.Sales_Invoice_Line_Item__c = c.id;
                               g.Referral_Report__c = rr.id;
                               junctionList.add(g);
                           }
                           }
                           
                                rList.add(rr);
                                system.debug('********rr********'+rList);
                            
                          }
                        }
                        
                    }
                        
                        
                        
                }
                
                update referralReportList;
              
               List<Gamification_Document__c > toInsert = new List<Gamification_Document__c >();
               for(Gamification_Document__c  g: junctionList )
               {
               boolean b = false;
                   for(Gamification_Document__c  eg : ExistingJunctionList )
                   {
                      if(g.Sales_Invoice_Line_Item__c  == eg.Sales_Invoice_Line_Item__c && g.Referral_Report__c == eg.Referral_Report__c )
                      {
                          b = true;
                          break;    
                      } 
                   }
                   
                   if(!b)
                   toInsert.add(g);
               }
               
               insert toInsert;
    }
}