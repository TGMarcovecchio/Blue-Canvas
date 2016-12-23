trigger WSIntakeTrigger on Intake__c (before insert, before update, after insert, after update) {

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

    }

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



}