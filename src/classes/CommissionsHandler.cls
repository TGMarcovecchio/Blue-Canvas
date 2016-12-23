public class CommissionsHandler
{
    String debitId = [select id from RecordType where name = 'Debit' limit 1].id;
    String creditId = [select id from RecordType where name = 'Credit' limit 1].id;
        
    public void DebitSalesInvoice(List<String> invoiceIds)
    {
        List<Commission__c> commissionList = new List<Commission__c>();
        
        delete [select id from Commission__c where Invoice__c in:invoiceIds ];
        List<c2g__codaInvoice__c> invoiceList = [select Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Account.Grand_ParentAccount__c,Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Account.parentid,Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c,Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Sales_Person_2__c, id, Ascent2FF__Sales_Order__c ,Ascent2FF__Sales_Order__r.PBSI__Opportunity__c,Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Sales_Person_1__c from c2g__codaInvoice__c where id in: invoiceIds];
        
        Map<String, Account> accountMap = new Map<String, Account>();
        List<String> partnerIds = new List<String>();
        
        for(c2g__codaInvoice__c c : invoiceList )
        {
            if(c.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c != null && c.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c.length() >=15 )
            {
                partnerIds.add(c.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c );
            }
        }
        
        for(Account a : [select id, Grand_ParentAccount__c, ParentId from Account where id in: partnerIds])
        {
            accountMap.put(a.id, a);
        }
        
        for(c2g__codaInvoice__c i : invoiceList )
        {
        System.debug(i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Sales_Person_1__c+' ************** '+i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__c);
            if(i.Ascent2FF__Sales_Order__c != null && i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__c != null)
            {
                if(i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Sales_Person_1__c != null)
                {
                    Commission__c c = new Commission__c();
                    c.Role__c = 'Primary';
                    c.Invoice__c = i.id;
                    c.Opportunity__c = i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__c;
                    c.Sales_Person__c = i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Sales_Person_1__c;
                    c.OwnerId = i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Sales_Person_1__c;
                    c.RecordTypeid = debitId;
                    
                    commissionList.add(c);
                }
                
                if(i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Sales_Person_2__c != null)
                {
                    Commission__c c = new Commission__c();
                    c.Role__c = 'Secondary';
                    c.Invoice__c = i.id;
                    c.Opportunity__c = i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__c;
                    c.Sales_Person__c = i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Sales_Person_2__c ;
                    c.OwnerId = i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Sales_Person_2__c;
                    c.RecordTypeid = debitId;
                    
                    commissionList.add(c);
                }
                
                if(i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c != null && i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c.length() >= 15)
                {
                    Commission__c c = new Commission__c();
                    c.Role__c = 'Primary';
                    c.Invoice__c = i.id;
                    c.Opportunity__c = i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__c;
                    c.Referral_Partner__c = i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c ;
                    c.RecordTypeid = debitId;
                    
                    commissionList.add(c);
                }
                        
                if(i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c != null && accountMap.get(convertId(i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c)) !=null && accountMap.get(convertId(i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c)).parentid != null && i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c.length() >= 15  )
                {
               
                   
                    Commission__c c = new Commission__c();
                    c.Role__c = 'Secondary';
                    c.Invoice__c = i.id;
                    c.Opportunity__c = i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__c;
                    c.Referral_Partner__c = accountMap.get(convertId(i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c)).parentid ;
                    c.RecordTypeid = debitId;
                    
                    commissionList.add(c);
                }
                
                if(i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c != null && accountMap.get(convertId(i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c)) !=null &&  accountMap.get(convertId(i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c)).Grand_ParentAccount__c!= null && i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c.length() >= 15)
                {
                    Commission__c c = new Commission__c();
                    c.Role__c = 'Tertiary';
                    c.Invoice__c = i.id;
                    c.Opportunity__c = i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__c;
                    c.Referral_Partner__c = accountMap.get(convertId(i.Ascent2FF__Sales_Order__r.PBSI__Opportunity__r.Referral_Partner_Id__c)).Grand_ParentAccount__c;
                    c.RecordTypeid = debitId;
                    
                    commissionList.add(c);
                }
            }
        }
        
        System.debug('************** '+commissionList );
        insert commissionList ;
        System.debug('************** '+commissionList );
    }
    
    public void CreditSalesInvoice(List<String> creditIds)
    {
        List<Commission__c> commissionList = new List<Commission__c>();
        List<c2g__codaCreditNote__c> creditList= [select id, c2g__Opportunity__c, c2g__Opportunity__r.Referral_Partner_Id__c,c2g__Opportunity__r.Sales_Person_2__c,c2g__Opportunity__r.Sales_Person_1__c  from c2g__codaCreditNote__c where id in: creditIds];
        delete [select id from Commission__c where Credit_Note__c in: creditIds ];
        Map<String, Account> accountMap = new Map<String, Account>();
        List<String> partnerIds = new List<String>();
        
        for(c2g__codaCreditNote__c c : creditList )
        {
            if(c.c2g__Opportunity__r.Referral_Partner_Id__c != null && c.c2g__Opportunity__r.Referral_Partner_Id__c.length() >= 15 )
            {
                partnerIds.add(c.c2g__Opportunity__r.Referral_Partner_Id__c );
            }
        }
        
        for(Account a : [select id, Grand_ParentAccount__c, ParentId from Account where id in: partnerIds])
        {
            accountMap.put(a.id, a);
        }
        
        for(c2g__codaCreditNote__c i : creditList )
        {
           
           if(i.c2g__Opportunity__c != null)
            {
            
                if(i.c2g__Opportunity__r.Sales_Person_1__c != null)
                {
                    Commission__c c = new Commission__c();
                    c.Role__c = 'Primary';
                    c.Credit_Note__c = i.id;
                    c.Opportunity__c = i.c2g__Opportunity__c;
                    c.Sales_Person__c = i.c2g__Opportunity__r.Sales_Person_1__c;
                    c.OwnerId = i.c2g__Opportunity__r.Sales_Person_1__c;
                    c.RecordTypeid = creditId;
                    
                    commissionList.add(c);
                }
                
                if(i.c2g__Opportunity__r.Sales_Person_2__c != null)
                {
                    Commission__c c = new Commission__c();
                    c.Role__c = 'Secondary';
                    c.Credit_Note__c = i.id;
                    c.Opportunity__c = i.c2g__Opportunity__c;
                    c.Sales_Person__c = i.c2g__Opportunity__r.Sales_Person_2__c ;
                    c.OwnerId = i.c2g__Opportunity__r.Sales_Person_2__c;
                    c.RecordTypeid = creditId;
                    
                    commissionList.add(c);
                }
                
                if(i.c2g__Opportunity__r.Referral_Partner_Id__c != null && i.c2g__Opportunity__r.Referral_Partner_Id__c.length() >= 15)
                {
                    Commission__c c = new Commission__c();
                    c.Role__c = 'Primary';
                    c.Credit_Note__c = i.id;
                    c.Opportunity__c = i.c2g__Opportunity__c;
                    c.Referral_Partner__c = i.c2g__Opportunity__r.Referral_Partner_Id__c ;
                    c.RecordTypeid = creditId;
                    
                    commissionList.add(c);
                }
                
                if(i.c2g__Opportunity__r.Referral_Partner_Id__c != null && i.c2g__Opportunity__r.Referral_Partner_Id__c.length() >= 15 && accountMap.get(convertId(i.c2g__Opportunity__r.Referral_Partner_Id__c)) != null && accountMap.get(convertId(i.c2g__Opportunity__r.Referral_Partner_Id__c)).parentid != null)
                {
                   Commission__c c = new Commission__c();
                    c.Role__c = 'Secondary';
                    c.Credit_Note__c = i.id;
                    c.Opportunity__c = i.c2g__Opportunity__c;
                    c.Referral_Partner__c = accountMap.get(convertId(i.c2g__Opportunity__r.Referral_Partner_Id__c)).parentid ;
                    c.RecordTypeid = creditId;
                    
                    commissionList.add(c);
                }
                
                if(i.c2g__Opportunity__r.Referral_Partner_Id__c != null && i.c2g__Opportunity__r.Referral_Partner_Id__c.length() >= 15  && accountMap.get(convertId(i.c2g__Opportunity__r.Referral_Partner_Id__c)) != null && accountMap.get(convertId(i.c2g__Opportunity__r.Referral_Partner_Id__c)).Grand_ParentAccount__c!= null)
                {
                 Commission__c c = new Commission__c();
                    c.Role__c = 'Tertiary';
                    c.Credit_Note__c = i.id;
                    c.Opportunity__c = i.c2g__Opportunity__c;
                    c.Referral_Partner__c = accountMap.get(convertId(i.c2g__Opportunity__r.Referral_Partner_Id__c)).Grand_ParentAccount__c;
                    c.RecordTypeid = creditId;
                    
                    commissionList.add(c);
                }
            }
        }
        
        System.debug('************** '+commissionList );
        insert commissionList ;
        System.debug('************** '+commissionList );
    }
    
    
    
    public String convertId(String recId)
        {
        if(recId != null && recId.length() != 18)
        {
            string suffix = '';
            integer flags;
            try
            {
                for (integer i = 0; i < 3; i++) 
                {
                    flags = 0;
                    for (integer j = 0; j < 5; j++) 
                    {
                        string c = recId.substring(i * 5 + j,i * 5 + j + 1);
                        system.debug(c+'########HELLO C###########');
                        if (c.toUpperCase().equals(c) && c >= 'A' && c <= 'Z') 
                        {
                            flags = flags + (1 << j);
                        }
                    }
                    if (flags <= 25) 
                    {
                        suffix += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.substring(flags,flags+1);
                    }
                    else
                    {
                        suffix += '012345'.substring(flags - 26, flags-25);
                    }
                }
            }
            catch(Exception exc)
            {
                
            }
            if(recId!=null)
            {
            String outputId = recId+suffix;
            system.debug(outputId+'#######HI OUTPUT#####');
            return outputId;
            }
            else
            return null;
            }
            else 
            return recId;
        }
        
        
    
}