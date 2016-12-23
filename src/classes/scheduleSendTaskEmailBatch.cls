/*
 * Author:      
 * Date:        September 18, 2014
 * Description: This class schedules the batch class to send mail.
 *
 * Change History
 * v1.0.0 September 18, 2014 New
*/
global class scheduleSendTaskEmailBatch implements Schedulable {
    global void execute(SchedulableContext sc) { 
        Id batchInstanceId = Database.executeBatch(new sendTaskEmailBatch (), 1);
    }
}