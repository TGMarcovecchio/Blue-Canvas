trigger ValidateProgramNotNullWhenIncTypeEnrollment on Opportunity (before insert, before update) {
	if(Trigger.new[0].Income_Type__c == 'Enrollment' && Trigger.new[0].Program__c == null){
		Trigger.new[0].Program__c.addError('You must enter a value');
	}
}