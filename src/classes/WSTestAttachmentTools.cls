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

		Facilitator__c fct = new Facilitator__c();
		fct.Name = 'TEST TEST';
		insert fct;
		String fctid = fct.id;

		Facility__c f = new Facility__c();
		f.Name = 'Test';
		insert f;
		String fid = f.id;

		Program__c prg = new Program__c();
		prg.Name = 'Test';
		prg.Class_Start_Date_Time__c = DateTime.Now();
		prg.Facilitator__c = fctid;
		prg.Facility__c = fid;
		insert prg;
		String prgid = prg.id;

		Meeting__c mtg = new Meeting__c();
		mtg.Name = 'TEST';
		mtg.Date_Time__c = DateTime.Now();
		mtg.Reparent_Attachment_To_ID__c = cntid;
		mtg.Program__c = prgid;
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