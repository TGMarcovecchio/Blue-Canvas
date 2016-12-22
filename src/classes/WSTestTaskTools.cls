@IsTest(SeeAllData=true)

class WSTestTaskTools{

	//Unit test for Set Sales Order Contact from Primary Opportunity Contact Role
	
    @IsTest static void UnitTestIntegraParser () {
    
		// Grab your Custom Setting values
	    WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
	    Boolean  AllTriggersOff = settings.Turn_Off_All_APEX_Triggers__c;
	    Boolean  ThisTriggerOff = settings.Turn_off_Task_Trigger__c;
	    Boolean  IntegraParserOff = settings.Turn_off_Integra_Task_Trigger__c;
	  
	    if(AllTriggersOff == FALSE && ThisTriggerOff == FALSE && IntegraParserOff == FALSE){

		    String body;
		    String body2;
		    String accid;

		    List<Task> tsks = new List<Task>();

		    body = 	'Phone number: (541) 306-1897' + '\n' + 
		    		'DDI/DID: 1111111111' + '\n' + 
		    		'DDI Name/DNIS: Test User' + '\n' +
		    		'Start Time : 10/29/2015 5:00:40 PM' + '\n' + 
					'End Time : 10/29/2015 5:01:35 PM' + '\n';

			body2 =	'DDI/DID: ' + '\n' +
					'DDI Name/DNIS: Test User' + '\n';
		    
		    //Create An Acount

		    try{ 

		    	Account acct = new Account();
		    	acct.Name = 'Integra Unity Test';
		    	insert acct;
		    	accid = acct.id;
			}
		    catch (Exception e) {
		        system.debug(e);
		    }

		    Test.StartTest(); //Start The Test

				Task to = new Task();
				to.Subject = 'Outbound Call from Unit Test';
				to.Type = 'Call';
				to.Description = body;
				to.Priority = 'Normal';
				to.WhatId = accid;
				to.ActivityDate = Date.today();
		        to.Status = 'Completed';

				tsks.add(to);

				Task ti = new Task();
				ti.Subject = 'Inbound Call from Unit Test';
				ti.Type = 'Call';
				ti.Description = body2;
				ti.Priority = 'Normal';
				ti.WhatId = accid;
				ti.ActivityDate = Date.today();
		        ti.Status = 'Completed';

				tsks.add(ti);

				try{
					if(!tsks.IsEmpty()){
						insert tsks;
					}
				}
		    	catch (Exception e) {
		        	system.debug(e);
		    	}

			Test.StopTest(); //Stop The Test
				
	    }//End Trigger On or Off
 	}//End Integra Parser

 	 @IsTest static void UnitTestResetBypass () {

 	 	Lead ld = new Lead();
 	 	ld.FirstName = 'TestReset';
 	 	ld.LastName = 'TestReset';
 	 	ld.Company = 'TestReset';
 	 	ld.Status = 'Open';
 	 	ld.LeadSource = 'Direct Sales';

 	 	insert ld;

		Task to = new Task();
		to.Subject = 'TestTaskTools';
		to.Type = 'Call';
		to.Description = 'Test Test Test';
		to.Priority = 'Normal';
		to.WhoId = ld.id;
		to.ActivityDate = Date.today();
	    to.Status = 'Completed';

	    insert to;

	    Database.LeadConvert lc = new Database.LeadConvert();
		lc.setLeadId(ld.id);

		Task tou = [SELECT Id, ByPassValidations__c, OwnerId, WhoId FROM Task WHERE Id =: to.id];
		tou.ByPassValidations__c = TRUE;
		update tou;

 	 }

 	  @IsTest static void UnitTestDeleteTask () {

 	 	Lead ld = new Lead();
 	 	ld.FirstName = 'TestReset';
 	 	ld.LastName = 'TestReset';
 	 	ld.Company = 'TestReset';
 	 	ld.Status = 'Open';
 	 	ld.LeadSource = 'Direct Sales';

 	 	insert ld;

		Task to = new Task();
		to.Subject = 'TestTaskTools';
		to.Type = 'Call';
		to.Description = 'Test Test Test';
		to.Priority = 'Normal';
		to.WhoId = ld.id;
		to.ActivityDate = Date.today();
	    to.Status = 'Completed';

		insert to;

	    // This code runs as the Sales user
		Profile p = [SELECT Id FROM Profile WHERE Name='Sales'];
		User u = new User(Alias = 'standt', Email='testsalesuser@intellibed.com',
		EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
		LocaleSidKey='en_US', ProfileId = p.Id,
		TimeZoneSidKey='America/Los_Angeles', UserName='testsalesuser@intellibed.com');

	    System.runAs(u) {
			delete to;
		}

 	  }

}//End WSTaskTools