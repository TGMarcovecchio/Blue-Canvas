public class WSKIDSTools{

    //BLUE CANVAS DEMO

    public static void createPipeFile(Id ReportId){
    
        /*THIS IS A PLACE HOLDER FOR THE METHOD WITH EXAMPLE CODE. THIS CODE NEEDS TO BE REFACTORED*/
    
        List<Account > acclist = [Select id,name , CreatedDate , lastModifiedDate from Account limit 10]; //Define a list of accounts selected from the Account object limited to 10 records
        string header = 'Record Id, Name , Created Date, Modified Date \n';  //Define a string for the header of the final data
        string finalstr = header ; //Define a string for the final string and set it initially equal to the header string
        
        for(Account a: acclist)
        {
        string recordString = '"'+a.id+'","'+a.Name+'","'+a.CreatedDate+'","'+a.LastModifiedDate +'"\n';  //For each account in the list of accounts create a string representing the account
        finalstr = finalstr +recordString;  //Add the account string to the final string
        }
        
        Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment(); //Define a new attachement
        
        blob csvBlob = Blob.valueOf(finalstr); //Instantiate a blob from the final string
        string csvname= 'Account.csv'; //Create a string representing the filename
        csvAttc.setFileName(csvname); //Set the attachment filename 
        csvAttc.setBody(csvBlob); //Set the body of the attachment using the bloc
        
        Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage(); //Define a new message
        
        String[] toAddresses = new list<string> {'test@test.com'}; //Define a string for the to address for the message
        String subject ='Account CSV'; //Define a string for the subject for the message
        
        email.setSubject(subject); //Set the message subject
        email.setToAddresses( toAddresses ); //Set the to address
        email.setPlainTextBody('Account CSV '); //Set the plain text body of the message
        email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc}); //Set the file attachement for the message
        
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email}); //Send the message and assign the response to a variable r
    
    
    }

}