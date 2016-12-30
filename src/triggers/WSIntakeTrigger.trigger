/**********************************************************************
* Name:     WSIntakeTrigger
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     28 Dec 2016
* ======================================================
* ======================================================
* Purpose:                                                            
* Custom Trigger on Intake
*                                                            
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       28 Dec 2016     TGM         Initial Development
***********************************************************************/
trigger WSIntakeTrigger on Intake__c (before insert, before update, after insert, after update) {

    // Grab your Custom Setting values
    WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
    Boolean  TriggerOff = settings.Turn_Off_Metric_Trigger__c;
    Boolean  AllTriggersOff = settings.Turn_Off_All_Triggers__c;

    if(TriggerOff==FALSE && ALLTriggersOff==FALSE){

        if(checkRecursive.runOnce()){

            List<Intake__c> iidn = new List<Intake__c>();
            Set<Id> iidc = new Set<Id>();
            Set<Id> iidu = new Set<Id>();

        	List<Intake__c> sos = new List<Intake__c>();

            if(trigger.isBefore && trigger.isInsert){

                for(Intake__c i : trigger.new){

                        if(i.Name == NULL || i.Name == 'Default'){

                            iidn.add(i);
                        }

                }

            }//End If Before Insert

            if(trigger.isBefore && trigger.isUpdate){

                for(Intake__c i : trigger.new){

                        Intake__c oldi = trigger.oldMap.get(i.id);

                        if(i.First_Name__c != oldi.First_Name__c || i.Last_Name__c != oldi.Last_Name__c || i.Name == 'Default'){

                            iidn.add(i);
                        
                        }

                }

            }

            if(trigger.isBefore && trigger.isUpdate){


            }

            if(trigger.isAfter && trigger.isInsert){

                for(Intake__c i : trigger.new){

                        if(i.Contact__c == NULL){

                            iidc.add(i.Id);
                        }

                }

            }

            if(trigger.isAfter && trigger.isUpdate){

                for(Intake__c iu : trigger.new){

                    iidu.add(iu.id);

                }

            }

            if(!iidn.isEmpty()){

                WSIntakeTools.beforeInsertIntake(iidn);

            }

            if(!iidc.isEmpty()){

                WSIntakeTools.createContactfromIntake(iidc);
            }

            if(!iidu.isEmpty()){

                WSIntakeTools.updateMetricfromIntake(iidu);

            }

        }//End Check Recursive

    }//End If Trigger Off

}