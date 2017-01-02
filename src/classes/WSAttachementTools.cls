/**********************************************************************
* Name:     WSAttachmentTools
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     28 Dec 2016
* ======================================================
* ======================================================
* Purpose:                                                            
* Class for Attachment related methods
*                                                            
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       28 Dec 2016     TGM         Initial Development
***********************************************************************/
public class WSAttachementTools {

	public static void cloneAttachementsonMeeting() {

		Set<Id> mids = new Set<Id>();
		Map<Id,Id> remap =new Map<Id,Id>();
		List<Meeting__c> meetings = [SELECT Id, Reparent_Attachment_To_ID__c FROM Meeting__c WHERE Reparent_Attachment_To_ID__c != NULL];
		List<Attachment> newwatts = new List<Attachment>();

		for(Meeting__c m : meetings){
		mids.add(m.id);
		remap.put(m.id,m.Reparent_Attachment_To_ID__c);
		}

		List<Attachment> atts = [SELECT SystemModstamp, ParentId, OwnerId, Name, 
            LastModifiedDate, LastModifiedById, IsPrivate, IsDeleted, 
            Id, Description, CreatedDate, CreatedById, 
            ContentType, BodyLength, Body 
        FROM Attachment 
        WHERE ParentId IN: mids];

		for(Attachment thea : atts){

			Attachment tempAtt = new Attachment();

    		tempAtt=thea.clone(false,false);
    		tempAtt.parentId = remap.get(thea.parentId);

			newwatts.add(tempAtt);

		}

		insert newwatts;
		
	}
}