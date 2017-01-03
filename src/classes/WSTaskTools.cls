/**********************************************************************
* Name:     WSTaskTools
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     28 Dec 2016
* ======================================================
* ======================================================
* Purpose:                                                            
* Custom Class and Methods for operations on the Task Object
*                                                            
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       28 Dec 2016     TGM         Initial Development
***********************************************************************/
public with sharing class WSTaskTools {

	public static void nullTaskDates(List<Task> thetasks){

		for(Task t : thetasks){

			if(t.ActivityDate != NULL && (t.npsp__Engagement_Plan__c != NULL || t.npsp__Engagement_Plan_Task__c != NULL)){

				t.ActivityDate = NULL;
			}
		}
	}

}