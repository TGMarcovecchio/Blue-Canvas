trigger Gamification_Document_AT on Gamification_Document__c (after insert, after update) {
    if(trigger.isInsert || trigger.isUpdate){
        if(trigger.isAfter){
            
            
            system.debug('in the trigger logic');
            
            //List<Gamification_Document__c> referalList = [Select id, Referral_Report__c from Gamification_Document__c where Id IN: Trigger.newMap.keySet()];
            set<Id> referalIds = new set<Id>();
            
            for(Gamification_Document__c gamiRec : Trigger.new){
                referalIds.add(gamiRec.Referral_Report__c);
            }
            
            List<Gamification_Document__c> GamificationDocumentList = [Select Net_Value_Voided__c, 
                                                                            Net_Value__c,
                                                                            Sales_Invoice_Line_Item__r.c2g__Invoice__c,
                                                                            Referral_Report__c from Gamification_Document__c 
                                                                            where Referral_Report__c IN: referalIds];
                                                                            
            Map<String, String> RefInvoiceMap = new Map<String,String>();
            Map<String,Double> RefAmountMap = new Map<String,Double>();
            
            if(!GamificationDocumentList.isEmpty()){//Added by WIN
            
                for(Gamification_Document__c gamiDocRec : GamificationDocumentList){
                
                    if(RefInvoiceMap.get(gamiDocRec.Sales_Invoice_Line_Item__r.c2g__Invoice__c+''+gamiDocRec.Referral_Report__c) == null){
                        if(gamiDocRec.Net_Value_Voided__c != null && gamiDocRec.Net_Value_Voided__c != 0){
                            if(RefAmountMap.get(gamiDocRec.Referral_Report__c+'Void') == null){
                                RefAmountMap.put(gamiDocRec.Referral_Report__c+'Void', gamiDocRec.Net_Value_Voided__c);
                            }
                            else{
                                RefAmountMap.put(gamiDocRec.Referral_Report__c+'Void', RefAmountMap.get(gamiDocRec.Referral_Report__c+'Void')+gamiDocRec.Net_Value_Voided__c);
                            }
                        }
                        else{
                            if(RefAmountMap.get(gamiDocRec.Referral_Report__c+'Void') == null){
                                RefAmountMap.put(gamiDocRec.Referral_Report__c+'Void', 0);
                            }
                            else{
                                RefAmountMap.put(gamiDocRec.Referral_Report__c+'Void', RefAmountMap.get(gamiDocRec.Referral_Report__c+'Void')+0);
                            }
                        }
                        if(gamiDocRec.Net_Value__c != null && gamiDocRec.Net_Value__c != 0){
                            if(RefAmountMap.get(gamiDocRec.Referral_Report__c+'Net') == null){
                                RefAmountMap.put(gamiDocRec.Referral_Report__c+'Net', gamiDocRec.Net_Value__c);
                            }
                            else{
                                RefAmountMap.put(gamiDocRec.Referral_Report__c+'Net', RefAmountMap.get(gamiDocRec.Referral_Report__c+'Net')+gamiDocRec.Net_Value__c);
                            }
                        }
                        else{
                            if(RefAmountMap.get(gamiDocRec.Referral_Report__c+'Net') == null){
                                RefAmountMap.put(gamiDocRec.Referral_Report__c+'Net', 0);
                            }
                            else{
                                RefAmountMap.put(gamiDocRec.Referral_Report__c+'Net', RefAmountMap.get(gamiDocRec.Referral_Report__c+'Net')+0);
                            }
                        }
                        RefInvoiceMap.put(gamiDocRec.Sales_Invoice_Line_Item__r.c2g__Invoice__c+''+gamiDocRec.Referral_Report__c,'true');
                    }
                }
            }//Added by WIN
            
            List<Referral_Report_Card__c> listRefToUpdate = [Select Id, Net_Value_Voided_Roll_Up__c,Net_Value_Roll_Up__c from Referral_Report_Card__c where Id IN: referalIds];
            if(listRefToUpdate.size()>0){
                for(integer i=0;i<listRefToUpdate.size();i++){
                    if(RefAmountMap.get(listRefToUpdate[i].Id+'Void') != null){
                        listRefToUpdate[i].Net_Value_Voided_Roll_Up__c = RefAmountMap.get(listRefToUpdate[i].Id+'Void');
                    }
                    if(RefAmountMap.get(listRefToUpdate[i].Id+'Net') != null){
                        listRefToUpdate[i].Net_Value_Roll_Up__c = RefAmountMap.get(listRefToUpdate[i].Id+'Net');
                    }
                }
                update listRefToUpdate;
            }
        }
    }

}