/**********************************************************************
* Name:     WSTestTaskTools
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     28 Dec 2016
* ======================================================
* ======================================================
* Purpose:                                                            
* Test Class for WSTaskTools and related trigger
*                                                            
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       28 Dec 2016     TGM         Initial Development
***********************************************************************/
@isTest
private class WSTestTaskTools {

    static testMethod void nullTaskDates_Test() {

    	//Create A Contact
    	Contact c = new Contact();
    	c.FirstName = 'TEST';
    	c.LastName = 'TEST';
    	insert c;
    	String cid = c.id;

    	//Create An Engagement Plan Template
		npsp__Engagement_Plan_Template__c ep = new npsp__Engagement_Plan_Template__c();
		ep.Name = 'TEST';
		ep.npsp__Automatically_Update_Child_Task_Due_Date__c = TRUE;
		ep.npsp__Default_Assignee__c = 'Owner of Object for Engagement Plan';
		ep.npsp__Description__c = 'TEST';
		ep.npsp__Reschedule_To__c = 'Monday';
		ep.npsp__Skip_Weekends__c = TRUE;
		insert ep;
		String epid = ep.id;

		//Create An Engagement Plan Task Template
		npsp__Engagement_Plan_Task__c ept = new npsp__Engagement_Plan_Task__c();
		ept.Name = 'TEST';
		ept.npsp__Engagement_Plan_Template__c = epid;
		ept.npsp__Priority__c = 'Normal';
		ept.npsp__Status__c = 'Not Started';
		ept.npsp__Type__c = 'Meeting';
		insert ept;
		String eptid = ept.id;

		//Create An Engagement Plan for the Contact
		npsp__Engagement_Plan__c cep = new npsp__Engagement_Plan__c();
		cep.npsp__Engagement_Plan_Template__c = epid;
		cep.npsp__Contact__c = cid;
		insert cep;
		String cepid = cep.id;


		//Start The Test
    	Test.startTest();

    	//Create A Task Related to The Engagement Plan and an Engagement Plan Task Template
    	Task t = new Task();

    	t.ActivityDate = date.today();
    	t.WhoId = cid;
    	t.OwnerId = UserInfo.getUserId() ;
    	t.npsp__Engagement_Plan__c = cepid;
    	t.npsp__Engagement_Plan_Task__c = eptid;
    	t.Subject = 'Test of Null Date';

    	insert t;

    	//Stop The Test
    	Test.stopTest();

		
	}
}