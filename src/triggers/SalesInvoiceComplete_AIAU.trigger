trigger SalesInvoiceComplete_AIAU on c2g__codaInvoice__c (before insert, before update, after update) {
    WS_Custom_Admin_Settings__c atr = WS_Custom_Admin_Settings__c.getInstance();
    if(Trigger.isafter){
        List<String> RecalculateSalesinvids = new List<String>();
        
            List<String> Salesinvids = new List<String>(); 
            List<c2g__codaInvoiceLineItem__c> il_list= new List<c2g__codaInvoiceLineItem__c>();
            List<c2g__codaInvoiceLineItem__c> il_listfilter= new List<c2g__codaInvoiceLineItem__c>();
            List<Referral_Report_Card__c> referralReportList = new List<Referral_Report_Card__c>();
            List<Gamification_Document__c> junctionList = new List<Gamification_Document__c>();
            
            //public boolean isactive = false;
            
            List<String> accountIdList = new List<String>();
            List<String> periodIdList = new List<String>();
            List<String> ItemGroupIdList = new List<String>();
            Map<String,String> itemMap = new Map<String,String>();

            /*for(Eligible_Item_Groups__c e: eg)
            {
                eigids.add(e.Item_Group_ids__c.Split(';',1));
            } */
        
            //isactive =atr.Is_active__c;
            List<PBSI__PBSI_Item_Group__c> pblist= [select id,name from PBSI__PBSI_Item_Group__c where Is_Eligible__c = true];
            
            for(PBSI__PBSI_Item_Group__c p: pblist){
                itemMap.put(p.Name,p.id);
            } 
            // System.debug('*****Eligible******'+eigids);
            for(c2g__codaInvoice__c s : trigger.new){

                if(s.Is_Referral_Eligible__c && s.c2g__InvoiceStatus__c =='Complete' && s.Referral_Partner_Id__c != null && s.Referral_Partner_Id__c != '' && s.Referral_Partner_Id__c.length() >= 15 ){
                    if(s.c2g__InvoiceStatus__c !=Trigger.oldMap.get(s.id).c2g__InvoiceStatus__c){
                        Salesinvids.add(s.id);
                    }
                    else if(s.Void__c !=Trigger.oldMap.get(s.id).Void__c){
                        Salesinvids.add(s.id);
                    }
                    else if(s.WS_Recalculate__c != Trigger.oldMap.get(s.id).WS_Recalculate__c  && s.WS_Recalculate__c == true && s.In_Referral_Report__c == false ){
                        Salesinvids.add(s.id);
                    }
                    else if(s.WS_Recalculate__c != Trigger.oldMap.get(s.id).WS_Recalculate__c  && s.WS_Recalculate__c == true && s.In_Referral_Report__c == true ){
                        RecalculateSalesinvids.add(s.id);
                    }
                }
            //Add Condition
            }
            
            if(atr!= null && atr.Turn_off_Referral_Reports__c == false && atr.Turn_Off_All_APEX_Triggers__c == false){
                
            il_list = [Select id, name, 
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
                                from c2g__codaInvoiceLineItem__c where c2g__Invoice__c in : Salesinvids  and Is_Eligible__c = true];
                                
            System.debug('*****lines******'+il_list);
            
            List<String> invoiceLineIds = new List<String>();
            List<String> invoiceIdsToBeUpdate = new List<String>();
            
            for(c2g__codaInvoiceLineItem__c  c : il_list ){
                invoiceLineIds.add(c.id);
            }
            
            List<Gamification_Document__c> ExistingJunctionList = [select id, 
                                                        Referral_Report__c,
                                                        Sales_Invoice_Line_Item__c from Gamification_Document__c where Sales_Invoice_Line_Item__c in: invoiceLineIds];
           
           
            for(c2g__codaInvoiceLineItem__c cil : il_list){
                il_listfilter.add(cil);
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
                                        Period__c in: periodIdList) ];
                                        
            System.debug('*****Reff******'+referralReportList);   
            System.debug('*****linefilter******'+il_listfilter.size()); 
            System.debug('*****linefilter******'+il_list.size());
              
            List<Referral_Report_Card__c> rList = new List<Referral_Report_Card__c>();
            
            for(c2g__codaInvoiceLineItem__c c : il_list){
                System.debug('*****insidefor******'); 
                boolean b = false;
                for(Referral_Report_Card__c r : referralReportList){
                    if( c.c2g__Invoice__r.Referral_Partner_Id__c != null && c.c2g__Invoice__r.Referral_Partner_Id__c.length() >= 15 ){
                        System.debug(c.c2g__Invoice__r.Referral_Partner_Id__c+'***Account***'+r.Account__c+'*******'+c.c2g__Product__r.Item_Group__c+'***itemgroup****'+r.Item_Group__c+'*******'+c.c2g__Invoice__r.c2g__Period__c+'***Period***'+r.Period__c+'*****insidefor******'); 
                        if(c.c2g__Invoice__r.Referral_Partner_Id__c == r.Account__c && c.c2g__Product__r.Item_Group__c == r.Item_Group__c && c.c2g__Invoice__r.c2g__Period__c == r.Period__c){
                            b = true;
                            invoiceIdsToBeUpdate.add(c.c2g__Invoice__c);
                            
                            if(junctionList.size()==0){
                                if(c.Is_Eligible__c){
                                    Gamification_Document__c g = new Gamification_Document__c();
                                    g.Sales_Invoice_Line_Item__c = c.id;
                                    g.Referral_Report__c = r.id;
                                    junctionList.add(g);
                                }
                            }
                            else{
                                boolean c1 = false;
                                for(Gamification_Document__c  j: junctionList){
                                    if(j.Sales_Invoice_Line_Item__c  == c.id && j.Referral_Report__c  == r.id){
                                        c1 = true;
                                        break;
                                    }
                                }
                                if(!c1 && c.Is_Eligible__c){
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
                if(!b){
                    System.debug('*****insideif!b******'); 
                    boolean b1=false;
                    for(Referral_Report_Card__c rr1 : rList){
                        
                        if( c.c2g__Invoice__r.Referral_Partner_Id__c != null && c.c2g__Invoice__r.Referral_Partner_Id__c.length() >= 15 ) {
                            System.debug('*****insideforif******'); 
                            if(c.c2g__Invoice__r.Referral_Partner_Id__c == rr1.Account__c && c.c2g__Product__r.Item_Group__c == rr1.Item_Group__c && c.c2g__Invoice__r.c2g__Period__c == rr1.Period__c){
                                b1=true;
                                boolean checkB = false;
                                for(String s : invoiceIdsToBeUpdate){
                                    if(c.c2g__Invoice__c == s){
                                        checkB = true;
                                        break;
                                    }
                                }
                                System.debug(c.c2g__Invoice__c+'**************** CheckB'+checkB);   
                                invoiceIdsToBeUpdate.add(c.c2g__Invoice__c);

                                if(junctionList.size()==0 && c.Is_Eligible__c){
                                    Gamification_Document__c g = new Gamification_Document__c();
                                    g.Sales_Invoice_Line_Item__c = c.id;
                                    g.Referral_Report__c = rr1.id;
                                    junctionList.add(g);
                                }
                                else{
                                    boolean c1 = false;
                                    for(Gamification_Document__c  j: junctionList){
                                        if(j.Sales_Invoice_Line_Item__c  == c.id && j.Referral_Report__c  == rr1.id){
                                            c1 = true;
                                            break;
                                        }
                                    }
                                    if(!c1 && c.Is_Eligible__c){
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
                    if(b1){
                        update rList;
                    }
                    if(!b1){
                        if( c.c2g__Invoice__r.Referral_Partner_Id__c != null && c.c2g__Invoice__r.Referral_Partner_Id__c.length() >= 15 ){
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
                            if(junctionList.size()==0 && c.Is_Eligible__c){
                                Gamification_Document__c g = new Gamification_Document__c();
                                g.Sales_Invoice_Line_Item__c = c.id;
                                g.Referral_Report__c = rr.id;
                                junctionList.add(g);
                            }
                            else{
                                boolean c1 = false;
                                for(Gamification_Document__c  j: junctionList){
                                    if(j.Sales_Invoice_Line_Item__c  == c.id && j.Referral_Report__c  == rr.id){
                                        c1 = true;
                                        break;
                                    }
                                }
                                if(!c1 && c.Is_Eligible__c){
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
            //  insert rList;
            System.debug('*****Reffinsert******'+rList);  
            update referralReportList;
            update ExistingJunctionList;
            List<c2g__codaInvoice__c> updateInvoices = [select id, In_Referral_Report__c from c2g__codaInvoice__c where id in:invoiceIdsToBeUpdate ];
            for(c2g__codaInvoice__c c : updateInvoices){
                c.In_Referral_Report__c = true;
            }
            update updateInvoices;
            List<Gamification_Document__c > toInsert = new List<Gamification_Document__c >();
            for(Gamification_Document__c  g: junctionList ){
                boolean b = false;
                for(Gamification_Document__c  eg : ExistingJunctionList ){
                    if(g.Sales_Invoice_Line_Item__c  == eg.Sales_Invoice_Line_Item__c && g.Referral_Report__c == eg.Referral_Report__c ){
                        b = true;
                        break;    
                    } 
                }
                if(!b)
                    toInsert.add(g);
                }
                System.debug('*****Reffinsert******'+toInsert);
                insert toInsert;    
                //update referralReportList;
            }           
            List<String> invoiceids = new List<String>();
            List<String> invoiceids2 = new List<String>();
            for(c2g__codaInvoice__c s : trigger.new){
                if((s.c2g__InvoiceStatus__c != Trigger.oldMap.get(s.id).c2g__InvoiceStatus__c || (s.WS_Recalculate__c !=Trigger.oldMap.get(s.id).WS_Recalculate__c && s.WS_Recalculate__c == true )) && s.c2g__InvoiceStatus__c =='Complete'){
                    invoiceids.add(s.id);
                }
                if(s.WS_Recalculate__c !=Trigger.oldMap.get(s.id).WS_Recalculate__c && s.WS_Recalculate__c == true){
                    invoiceids2.add(s.id);
                }
            }
        if(invoiceids.size()>0 && atr != null && atr.Turn_off_Commissions__c == false && atr.Turn_Off_All_APEX_Triggers__c == false){
            CommissionsHandler c = new CommissionsHandler();
            c.DebitSalesInvoice(invoiceids);
        }
        if(invoiceids2.size()>0 ){
            Map<String, Referral_Report_Card__c> invoiceRRCMap = new Map<String, Referral_Report_Card__c>();
            Util u = new Util();
            u.Recalculate(invoiceids2,invoiceRRCMap);
        }
        if(RecalculateSalesinvids.size() > 0 && atr != null && atr.Turn_off_Referral_Reports__c == false && atr.Turn_Off_All_APEX_Triggers__c == false){
            SalesInvoiceCompleteHandler SIC = new SalesInvoiceCompleteHandler();
            SIC.recalculateReferralReport(RecalculateSalesinvids);
        }
        
    }
/*if(trigger.isbefore)
{
        for(c2g__codaInvoice__c s : trigger.new)
        {
            if( s.c2g__InvoiceStatus__c !='Complete' && s.WS_Recalculate__c == true)
            {
               s.WS_Recalculate__c = false ;
            }
        }
}*/
}