/**********************************************************************
* Name:     KIDSServiceLogEntryTrigger
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     17 Dec 2016
* ======================================================
* ======================================================
* Purpose:                                                            
* The new trigger on KIDS Service Log Entry
* Utilizes the checkRecursive public class to control recursion as well as the new TriggerDispatcher and TriggerHandler                                      
*      
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       17 Dec 2016     TGM         Initial Development
***********************************************************************/
trigger KIDSServiceLogEntryTrigger on KIDS_Service_Log_Entry__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

	if(checkRecursive.runOnce()){ //Need to deal with recursion 
        TriggerDispatcher.Run(new KIDSServiceLogEntryHandler()); //Call The Trigger Handler via a Dispatcher
    }

}