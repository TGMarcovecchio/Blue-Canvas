/**********************************************************************
* Name:     WSTaskTrigger
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     28 Dec 2016
* ======================================================
* ======================================================
* Purpose:                                                            
* Custom Trigger on Task
*                                                            
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       28 Dec 2016     TGM         Initial Development
***********************************************************************/
trigger WSTaskTrigger on Task (before insert) {

	// Grab the WS Custom Admin Settings Values
    WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
    Boolean  TriggerOff = settings.Turn_Off_Task_Trigger__c;
    Boolean  AllTriggersOff = settings.Turn_Off_All_Triggers__c; //Only do something if TriggerOff is False
    
    if(TriggerOff == FALSE && AllTriggersOff == FALSE){

    	if(checkRecursive.runOnce()){

    		List<Task> newtasks = new List<Task>(); //A List of newly inserted tasks

    		if(trigger.isBefore && trigger.isInsert){

                for(Task t : trigger.new){

                        if(t.ActivityDate != NULL && (t.npsp__Engagement_Plan__c != NULL || t.npsp__Engagement_Plan_Task__c != NULL)){

                            newtasks.add(t);
                        }

                }

            }//End If Before Insert

            if(!newtasks.isEmpty()){

            	WSTaskTools.nullTaskDates(newtasks);

            }

    	} //End Check Recursive
       
    }//End if Trigger Off


}