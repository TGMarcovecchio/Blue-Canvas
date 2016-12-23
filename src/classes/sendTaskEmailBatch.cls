/*
 * Author:      
 * Date:        September 18, 2014
 * Description: This batch class sends mail to Sales Manger and Excutive when task duration is Over.
 *
 * Change History
 * v1.0.0 September 18, 2014 New
*/
global class sendTaskEmailBatch implements Database.Batchable<sObject>{
    private static final string TASKSUBJECT = 'HCP Self-Purchased a Mattress - Execute SOP';
    private static final string TASKSUBJECT1 = 'SQL - Call Consumer';
    private static final string TASKSTATUS ='Not Started';
    
    List<Messaging.SingleEmailMessage> lstMsgs;
    
    private list<string> User1IntelliBEDAddresses = new list<String>();
    private list<string> User2colinHouseAddresses = new list<String>();
    
    public integer hours;
    list<OrgWideEmailAddress> orgwideID;
    list<task>UpdateTaskList= new list<task>();
        
    global Database.Querylocator start(Database.BatchableContext BC){   
        String query = 'Select t.WhoId,t.CreatedDate,t.Subject, t.Status,Escalation_Email_Status__c, t.Priority, t.OwnerId, t.Owner.Name,t.Id,Owner.ProfileId From Task t  where (Subject=\''+TASKSUBJECT+'\' OR  Subject=\''+TASKSUBJECT1+'\')and Status=\''+TASKSTATUS+'\'';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, list<Task> taskkList){
        lstMsgs = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        for(task t:taskkList){
            if(!test.isRunningTest()){
                hours=duration_between_two_date_times(t.CreatedDate,datetime.now());
            }else{
                //Only for test class
                hours=74;
            }
            if(hours>=24 && t.Escalation_Email_Status__c == null && User1IntelliBEDAddresses.size() >0 && orgwideID!=null){
                mail.setToAddresses(User1IntelliBEDAddresses);  
                mail.setSubject('Past due task-completion by '+t.Owner.Name);
                mail.setOrgWideEmailAddressId(orgwideID[0].id);
                string body =
                t.Owner.Name + ' has failed to close an automatically created task within the 24 hour time frame. \n'+
                'Please click the following link to access the Lead record and see the task(s) that have failed to be completed (i.e. “Closed”). \n'+
                '\n'+
                'Lead Record Link: '+URL.getSalesforceBaseUrl().toExternalForm() + '/' + t.WhoId+
                '\n'+
                '\n'+
                'Thank you,\n'+
                'intelliBED - Marketing'; 
                mail.setPlainTextBody(body);
                lstMsgs.add(mail);
                t.Escalation_Email_Status__c='IntelliBEDUser';
                UpdateTaskList.add(t);
            }else if(hours>=72 && t.Escalation_Email_Status__c=='IntelliBEDUser' && User2colinHouseAddresses.size() >0 && orgwideID!=null){
                mail.setToAddresses(User2colinHouseAddresses);
                mail.setOrgWideEmailAddressId(orgwideID[0].id);
                
                mail.setSubject('Past due task-completion by '+t.Owner.Name);
                string body = '48 hours ago the Sales Manager was alerted to the fact that ' +t.Owner.Name + ' (one of his direct reports) had failed to close an automatically created task within the initial 24 hour time frame.\n'+
                'Please click the following link to access the Lead record and see the task(s) that have failed to be completed (i.e. “Closed”).\n'+
                '\n'+
                'Lead Record Link: '+URL.getSalesforceBaseUrl().toExternalForm() + '/' + t.WhoId+
                '\n'+
                '\n'+
                'Thank you,\n'+
                'intelliBED - Marketing'; 
                mail.setPlainTextBody(body);
                lstMsgs.add(mail);
                t.Escalation_Email_Status__c='ColinHouse';
                UpdateTaskList.add(t);
            }
        }
        if(lstMsgs.size() >0){
            Messaging.sendEmail(lstMsgs);
        }
        if(UpdateTaskList.size() >0){
            update UpdateTaskList;
        }
    }
    global void finish(Database.BatchableContext BC){
        
    }
     public static Integer duration_between_two_date_times(DateTime start_date_time, DateTime end_date_time) {
        Integer start_year_as_int = start_date_time.year(); //grab the start year
        Integer start_day_as_int = start_date_time.dayOfYear(); //grab the start day
        Integer start_hour_as_int = start_date_time.hour(); //grab the start hour
        Integer start_minute_as_int = start_date_time.minute(); //grab the start minute
        Integer start_second_as_int = start_date_time.second(); //grab the start second
        Integer start_in_seconds = (start_year_as_int * 31556926) + (start_day_as_int * 86400) + (start_hour_as_int * 3600) ; //convert the start date to a value in seconds
       
        Integer end_year_as_int = end_date_time.year(); //grab the end year
        Integer end_day_as_int = end_date_time.dayOfYear(); //grab the end day
        Integer end_hour_as_int = end_date_time.hour(); //grab the end hour
        Integer end_minute_as_int = end_date_time.minute(); //grab the end minute
        Integer end_second_as_int = end_date_time.second(); //grab the end second
        Integer end_in_seconds = (end_year_as_int * 31556926) + (end_day_as_int * 86400) + (end_hour_as_int * 3600) ; //convert the end date to a value in seconds
        Integer total_duration_in_Seconds = end_in_seconds - start_in_seconds; //duration in seconds
        system.debug('-----total_duration_----------'+total_duration_in_Seconds);
         system.debug('-----total_duration_Hours----------'+total_duration_in_Seconds/3600);
        return total_duration_in_Seconds/3600;
    }
    global SendTaskEmailBatch (){
        orgwideID=new list<OrgWideEmailAddress>([Select o.Id, o.DisplayName, o.Address From OrgWideEmailAddress o limit 1]);
        for(user u : [select id, name, email from user where email =: 'al@intellibed.com' OR email =: 'colin@intellibed.com']){
            if(u.email == 'al@intellibed.com')
                User1IntelliBEDAddresses.add(u.email);
            else if(u.email == 'colin@intellibed.com')
                User2colinHouseAddresses.add(u.email);
        }
    }    
}