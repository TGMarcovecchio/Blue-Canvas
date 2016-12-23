/**********************************************************************
* Name:     KIDSServiceLogTrigger
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     17 Dec 2016
* ======================================================
* ======================================================
* Purpose:                                                            
* The new trigger on KIDS Service Log
* Utilizes the checkRecursive public class to control recursion as well as the new TriggerDispatcher and TriggerHandler                                      
*      
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       17 Dec 2016     TGM         Initial Development
***********************************************************************/
trigger KIDSServiceLogTrigger on KIDS_Service_Log__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) { //No before insert, before update, before delete, 
    
    if(checkRecursive.runOnce()){ //Need to deal with recursion 
        TriggerDispatcher.Run(new KIDSServiceLogHandler()); //Call The Trigger Handler via a Dispatcher
    }
}