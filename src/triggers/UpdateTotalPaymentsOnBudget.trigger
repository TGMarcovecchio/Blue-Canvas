trigger UpdateTotalPaymentsOnBudget on Payments__c (after delete, after insert, after update) {
    
    Map<ID, Map<String, Double>> mapPayments = new Map<ID, Map<String, Double>>(); 
    Map<String, Double> mapPaymentsOnBudget = null;
        
    for(Integer i = 0; i < Trigger.size; i++){
         
        Double oldPayment = 0;
        Double newPayment = 0;
        ID idBudget = null;
          
        if(Trigger.isDelete){ 
         	idBudget = Trigger.old[i].Budget__c;
        }else{
        	idBudget = Trigger.new[i].Budget__c;
        }
        
        if(idBudget <> null){
        
	        if(mapPayments.containsKey(idBudget)){
	            mapPaymentsOnBudget = mapPayments.get(idBudget); 
	        }else{
	            mapPaymentsOnBudget = new Map<String, Double>();
	            mapPaymentsOnBudget.put('new', 0);
	            mapPaymentsOnBudget.put('old', 0);       
	        }
	                
	        if(Trigger.isInsert){
	            oldPayment = 0;
	            newPayment = Trigger.new[i].Payment_Amount__c;      
	        }else if(Trigger.isUpdate){
	            oldPayment = Trigger.old[i].Payment_Amount__c;
	            newPayment = Trigger.new[i].Payment_Amount__c;  
	        }else{
	            oldPayment = Trigger.old[i].Payment_Amount__c;
	            newPayment = 0; 
	        }
	        
	        mapPaymentsOnBudget.put('new', mapPaymentsOnBudget.get('new') + (newPayment==null?0:newPayment));
	        mapPaymentsOnBudget.put('old', mapPaymentsOnBudget.get('old') + (oldPayment==null?0:oldPayment));
	        
	        
	        mapPayments.put(idBudget, mapPaymentsOnBudget);          
        }
    }
    
    List<Budget__c> upBudgets = new List<Budget__c>(); 
    
    if(!mapPayments.isEmpty()){
        
        for(Budget__c budget: [Select Id, Total_Payments__c From Budget__c where Id IN :mapPayments.keySet()] ){
            
            budget.Total_Payments__c = (budget.Total_Payments__c == null?0:budget.Total_Payments__c) + (mapPayments.get(budget.Id)).get('new') - (mapPayments.get(budget.Id)).get('old');
            upBudgets.add(budget);
        }
    }
    
    if(!upBudgets.isEmpty()){
        update upBudgets;       
    }   
}