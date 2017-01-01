/**********************************************************************
* Name:     WSMetricsTrigger
* Author:   World-Class Industrial Network, LLC (www.winnets.com / support@winnets.com)
* Date:     30 October 2016
* ======================================================
* ======================================================
* Purpose:                                                            
* Trigger on Metric Object                                       
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       30 Oct 2016     TGM         Initial Development
***********************************************************************/
trigger WSMetricsTrigger on Metrics__c (after insert, before insert) { //after update requires recursion control

	// Grab your Custom Setting values
    WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
    Boolean  TriggerOff = settings.Turn_Off_Metric_Trigger__c;
    Boolean  AllTriggersOff = settings.Turn_Off_All_Triggers__c;

    if(TriggerOff==FALSE && ALLTriggersOff==FALSE){

        //if(checkRecursive.runOnce()){

            List<Metrics__c> newmetrics = new List<Metrics__c>(); //A List of Newly Inserted Metrics

        	Set<Id> mids = new Set<Id>();//A set of Metric Record Ids
            Set<Id> mids2 = new Set<Id>(); //A set of Metric Record Ids

            if(trigger.isInsert && trigger.isBefore){

                for(Metrics__c m : trigger.new){

                    if(m.Contact__c != NULL){
                        newmetrics.add(m); //Add the metrics to a list of new metrics
                    }

                }
            }

        	if(trigger.isInsert && trigger.isAfter){

    	    	for(Metrics__c m : trigger.new){

    	    		//if(m.Credit_Score__c != NULL && m.Change_In_Verified_Credit_Score__c == NULL){
    	    			mids.add(m.Id);
    	    		//}
        		}
        
        	}

            if(!newmetrics.isEmpty()){
                WSMetricTools.setmetricintial(newmetrics);
            }

            if(!mids.isEmpty()){
    			WSMetricTools.setmetricchange(mids);
            }

        //}//End Check Recursive

    }//End If Trigger Off

}