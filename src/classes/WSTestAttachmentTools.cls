/**********************************************************************
* Name:     WSTestAttachmentTools
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     28 Dec 2016
* ======================================================
* ======================================================
* Purpose:                                                            
* Test Class for WSAttachementTools and related trigger
*                                                            
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       28 Dec 2016     TGM         Initial Development
***********************************************************************/
@isTest
private class WSTestAttachmentTools {

    static testMethod void cloneAttachmentsonMeeting_Test(){

		Contact cnt = new Contact();
		cnt.FirstName = 'Test';
		cnt.LastName = 'Test';
		insert cnt;
		String cntid = cnt.id;

		Meeting__c mtg = new Meeting__c();
		mtg.Name = 'TEST';
		mtg.Date_Time__c = datetime.now();
		mtg.Reparent_Attachment_To_ID__c = cntid;
		insert mtg;
		String mtgid = mtg.id;

		String thebody = 'TheBody';
		Blob theblob = Blob.valueOf(thebody);

		Attachment att = new Attachment();
		att.Body = theblob;
		att.Name = 'TestAttach';
		att.ParentId = mtgid;
		insert att;

		//Start Test
		Test.startTest();
			
			WSAttachementTools.cloneAttachementsonMeeting();

		//StopTest
		Test.stopTest();


	}
}