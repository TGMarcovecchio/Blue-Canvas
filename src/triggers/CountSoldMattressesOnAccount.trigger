/*
Trigger  : CountSoldMattressesOnAccount 
Associated Objects : Account and Referral Report Card
Details : * update the field of Account on update Referral Report Card and count the Quantity Roll Up of last six month.
Developed by : Saurabh
Company Name : Astrea IT Sercices
created date : 6 october 2015
*/

trigger CountSoldMattressesOnAccount on Referral_Report_Card__c (after insert, after update,after delete ) {
    
    Set<Id> AccountId = new Set<Id>();    // Set of account id.
    List<Account> acclist = new List<Account>();    // List of account record get from the updated Referral Report Card record.
    List<Account> accountUpdate  = new List<Account>();
        
    // Trigger execute on insert and update of record
    
    if(Trigger.isUpdate || Trigger.isInsert){
        for(Referral_Report_Card__c RRCrec : Trigger.new){
            AccountId.add(RRCrec.Account__c);
        }//[END OF TRIGGER NEW OR LOOP]
    }// [END OF IF ]
    
    // Trigger run after delete 
    if (Trigger.isDelete){
       
        for(Referral_Report_Card__c RRCrec : Trigger.old){
            AccountId.add(RRCrec.Account__c);
        }//[END OF TRIGGER OLD FOR LOOP ]
    
    }//[END OF IS DELETE ]
    
    // get all the records from the accoint id.
    if(AccountId != null && AccountId.size()>0){
       acclist = [select id ,CountSoldRefReport__c,(select id,AGE_Months__c,Quantity_Roll_Up__c,Period__r.name  from Referral_Reports__r where AGE_Months__c <=: 6 ) from Account where id in : AccountId]; 
    }
    
    // check if a Account list is  not empty and the iterate over each Account and check its related list record Referral Report Card and count the rool up field.
    if(acclist !=null && acclist.size()>0){
        for(Account ac : acclist ){
            ac.Mattresses_Sold_last_6_Months__c = 0;
            
            if(ac.Referral_Reports__r!=null && ac.Referral_Reports__r.size()>0){
                for(Referral_Report_Card__c  refrrpt : ac.Referral_Reports__r){
                    if(refrrpt.Quantity_Roll_Up__c != null)  
                        ac.Mattresses_Sold_last_6_Months__c = ac.Mattresses_Sold_last_6_Months__c + refrrpt.Quantity_Roll_Up__c;
                }
            }
            accountUpdate.add(ac);
        }//[END OF FOR ]
    }//[END OF IF]
    
    acclist.clear();
    if(accountUpdate!=null && accountUpdate.size()>0){
        update accountUpdate;        // update the account records.....
    }
}