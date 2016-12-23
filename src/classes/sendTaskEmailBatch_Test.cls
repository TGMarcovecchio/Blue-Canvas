@isTest 
private class sendTaskEmailBatch_Test {
    static testMethod void sendTaskEmailBatch_Test(){ 
        
       test.startTest();
       List<Messaging.SingleEmailMessage> lstMsgs;
       list<task>updateTask= new list<task>();            
       Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
       
       User u = new User(Alias = 'standt', Email='al@intellibed.com', 
       EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
       LocaleSidKey='en_US', ProfileId = p.Id, 
       TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
       
       User u1 = new User(Alias = 'standt', Email='colin@intellibed.com', 
       EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
       LocaleSidKey='en_US', ProfileId = p.Id, 
       TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.comTest');
       
       Lead l= new Lead();
       l.firstname='Test';
       l.lastname='name';
       l.Company='zipppp';
       l.Status='Open';
       
       Database.SaveResult resultLead = Database.insert(l, false);
       System.assertEquals(l.firstname, 'Test');
       System.assertNotEquals(l.firstname,'Demo');   
         
       Task t= new Task();   
       t.whoid=l.id;            
       t.subject = 'HCP Self-Purchased a Mattress - Execute SOP';
       t.status ='Not Started';    
       t.Priority='Normal';
       t.Escalation_Email_Status__c=null;
              
       Database.SaveResult resultTask = Database.insert(t, false);
       System.assertEquals(t.status, 'Not Started');
       System.assertNotEquals(t.Escalation_Email_Status__c,'Demo');   
       
       sendTaskEmailBatch.duration_between_two_date_times(datetime.now(), datetime.now().adddays(1));
       scheduleSendTaskEmailBatch sbm= new scheduleSendTaskEmailBatch();
       SchedulableContext sc;
       sbm.execute(sc);
       
       test.stopTest();
    }
    static testMethod void sendTaskEmailBatch_Test1(){ 
        
       test.startTest();
       List<Messaging.SingleEmailMessage> lstMsgs;
       list<task>updateTask= new list<task>();            
       Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
       
       User u = new User(Alias = 'standt', Email='al@intellibed.com', 
       EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
       LocaleSidKey='en_US', ProfileId = p.Id, 
       TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
       
       User u1 = new User(Alias = 'standt', Email='colin@intellibed.com', 
       EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
       LocaleSidKey='en_US', ProfileId = p.Id, 
       TimeZoneSidKey='America/Los_Angeles', UserName='colin@intellibed.com');
       
       Lead l= new Lead();
       l.firstname='Test';
       l.lastname='name';
       l.Company='zipppp';
       l.Status='Open';
       
       Database.SaveResult resultLead = Database.insert(l, false);
       System.assertEquals(l.firstname, 'Test');
       System.assertNotEquals(l.firstname,'Demo');   
         
       Task t= new Task();   
       t.whoid=l.id;            
       t.subject = 'SQL - Call Consumer';
       t.status ='Not Started';    
       t.Priority='Normal';
       t.Escalation_Email_Status__c='IntelliBEDUser';

       Database.SaveResult resultTask = Database.insert(t, false);
       System.assertEquals(t.Escalation_Email_Status__c, 'IntelliBEDUser');
       System.assertNotEquals(t.Escalation_Email_Status__c,'Demo');   
            
       sendTaskEmailBatch.duration_between_two_date_times(datetime.now(), datetime.now().adddays(1));
       scheduleSendTaskEmailBatch sbm= new scheduleSendTaskEmailBatch();
       SchedulableContext sc;
       sbm.execute(sc);
       
       test.stopTest();
    }    
}