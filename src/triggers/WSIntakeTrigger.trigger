trigger WSIntakeTrigger on Intake__c (before insert, after update) {

	Set<Id> iids = new Set<Id>();
	List<Intake__c> sos = new List<Intake__c>();

	 if(trigger.isAfter && trigger.isUpdate){

            for(Intake__c i : trigger.new){
                Intake__c oldi = trigger.oldMap.get(i.id);

                if(i.Metric__c == NULL){ //&& i.Contact__c != oldi.Contact__c i.Contact__c != NULL && 

                    sos.add(i);

                }
            }
        }

        if(!iids.isEmpty()){

        	WSIntakeTools.createMetricFromIntake(sos);
        }

}