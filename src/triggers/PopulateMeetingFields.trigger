trigger PopulateMeetingFields on Meeting__c (before insert, before update) {
	
	Set<ID> idProg = new Set<ID>();
	Map<ID, Program__c> idNameProg; 
	
	for(Integer i = 0; i < Trigger.size; i++){
		if(Trigger.new[i].Program__c != null){	
			idProg.add(Trigger.new[i].Program__c);
		}					
	}
	
	idNameProg = new Map<ID, Program__c>([Select Id, Name From Program__c Where Id IN :idProg]);
	
	for(Integer i = 0; i < Trigger.size; i++){
			
		if(  Trigger.new[i].Program__c != null && 
			!Trigger.new[i].Name.startsWith(idNameProg.get(Trigger.new[i].Program__c).Name)){
			Trigger.new[i].Name = idNameProg.get(Trigger.new[i].Program__c).Name + ' - ' + Trigger.new[i].Name;		
		}					
	}
}