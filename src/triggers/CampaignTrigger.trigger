/**********************************************************************
* Name:     CampaignTrigger
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     17 Dec 2016
* ======================================================
* ======================================================
* Purpose:                                                            
* The new trigger on Linvio Payment (pymt__PaymentX__c)
* Utilizes the checkRecursive public class to control recursion as well as the new TriggerDispatcher and TriggerHandler                                      
*      
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       17 Dec 2016     TGM         Initial Development
***********************************************************************/
trigger CampaignTrigger on Campaign (before insert, before update, before delete, after insert, after update, after delete, after undelete) { //No before insert, before update, before delete, 
    
    if(checkRecursive.runOnce()){ //Need to deal with recursion 
        TriggerDispatcher.Run(new CampaignTriggerHandler()); //Call The Trigger Handler via a Dispatcher
    }
}