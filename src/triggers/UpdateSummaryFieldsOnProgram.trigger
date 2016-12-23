trigger UpdateSummaryFieldsOnProgram on Opportunity (after delete, after insert, after update) {

	Map<ID, Map<String, Double>> mapPrograms = new Map<ID, Map<String, Double>>(); 
    Map<String, Double> mapProgram = null;
        
    for(Integer i = 0; i < Trigger.size; i++){
     
     	Double oldTotalIncomeEnrollment = 0;
        Double newTotalIncomeEnrollment = 0;
        
        Double oldTotalIncomeDonation = 0;
        Double newTotalIncomeDonation = 0;
        
        Double numberOfParticipantsPaid = 0;
        
        if( !Trigger.isDelete && Trigger.new[i].Program__c != null){
        	 
	        if(mapPrograms.containsKey(Trigger.new[i].Program__c)){
	            mapProgram = mapPrograms.get(Trigger.new[i].Program__c); 
	        }else{
	            mapProgram = new Map<String, Double>();
	            mapProgram.put('new_Enrollment', 0);
	            mapProgram.put('old_Enrollment', 0);       
	            mapProgram.put('new_Donation'  , 0);
	            mapProgram.put('old_Donation'  , 0);
	            mapProgram.put('numberOfParticipantsPaid'  , 0);
	        }
	                
	        if(Trigger.isInsert || (Trigger.isUpdate && Trigger.old[i].Program__c == null )){
	        	Double newAmount = (Trigger.new[i].Amount == null)?0:Trigger.new[i].Amount;
	        		        	
	        	if(Trigger.new[i].Income_Type__c == 'Enrollment'){	        		
	        		newTotalIncomeEnrollment = newAmount;	        		
	        		if(Trigger.new[i].StageName == 'Fully Paid'){numberOfParticipantsPaid = 1;}
	        			        		
	        	}else if (Trigger.new[i].Income_Type__c == 'Donation'){	        			        	
	        		newTotalIncomeDonation = newAmount;	        		
	        	}	        	      
	        }else if(Trigger.isUpdate){
	        		        		        	
	        	if( Trigger.old[i].Income_Type__c <> Trigger.new[i].Income_Type__c){ // Changed IncomeType
	        		Double newAmount = (Trigger.new[i].Amount == null)?0:Trigger.new[i].Amount;
	        		Double oldAmount = (Trigger.old[i].Amount == null)?0:Trigger.old[i].Amount;
	        		
	        		// New
	        		if(Trigger.new[i].Income_Type__c == 'Enrollment'){	        		
	        			newTotalIncomeEnrollment = newAmount;	        			
	        			if(Trigger.new[i].StageName == 'Fully Paid'){numberOfParticipantsPaid = 1;}	        					        			        		
	        		}else if (Trigger.new[i].Income_Type__c == 'Donation'){	        			        	
	        			newTotalIncomeDonation = newAmount;	        			
	        		}
	        		        		
	        		// Old
	        		if(Trigger.old[i].Income_Type__c == 'Enrollment'){	        		
	        			oldTotalIncomeEnrollment = oldAmount;	        		
	        		}else if (Trigger.old[i].Income_Type__c == 'Donation'){	        			        	
	        			oldTotalIncomeDonation = oldAmount;	        		
	        		}       			
	        		
	        		if(Trigger.old[i].Income_Type__c == 'Enrollment' && Trigger.old[i].StageName == 'Fully Paid'){        		
	        			numberOfParticipantsPaid = -1;
	        		}
	        					
	        	}else if (Trigger.old[i].Amount <> Trigger.new[i].Amount){ // Changed Amount
	        		Double newAmount = (Trigger.new[i].Amount == null)?0:Trigger.new[i].Amount;
	        		Double oldAmount = (Trigger.old[i].Amount == null)?0:Trigger.old[i].Amount;
	        		
	        		if(Trigger.new[i].Income_Type__c == 'Enrollment'){	        		
	        			newTotalIncomeEnrollment = newAmount;
	        			oldTotalIncomeEnrollment = oldAmount;
	        		}else if (Trigger.new[i].Income_Type__c == 'Donation'){	        			        	
	        			newTotalIncomeDonation = newAmount;	        		
	        			oldTotalIncomeDonation = oldAmount;
	        		}	        		
	        	}else if (Trigger.old[i].StageName <> Trigger.new[i].StageName){ // Changed StageName
	        		if(Trigger.new[i].StageName == 'Fully Paid' && Trigger.new[i].Income_Type__c == 'Enrollment'){
	        				numberOfParticipantsPaid = 1;
	        		}else if(Trigger.old[i].StageName == 'Fully Paid' && Trigger.old[i].Income_Type__c == 'Enrollment'){        		
	        			numberOfParticipantsPaid = -1;
	        		}      		
	        	}       	  
	        }
	        
	        mapProgram.put('new_Enrollment', mapProgram.get('new_Enrollment') + newTotalIncomeEnrollment);
	        mapProgram.put('old_Enrollment', mapProgram.get('old_Enrollment') + oldTotalIncomeEnrollment);       
	        mapProgram.put('new_Donation', mapProgram.get('new_Donation') + newTotalIncomeDonation);
	        mapProgram.put('old_Donation', mapProgram.get('old_Donation') + oldTotalIncomeDonation);
	        
	        mapProgram.put('numberOfParticipantsPaid', mapProgram.get('numberOfParticipantsPaid') + numberOfParticipantsPaid);
	        
	        mapPrograms.put(Trigger.new[i].Program__c, mapProgram);
	            
        }else if ( (Trigger.isUpdate || Trigger.isDelete) && Trigger.old[i].Program__c <> null ){ // unsetter Program
        	
        	if(mapPrograms.containsKey(Trigger.old[i].Program__c)){
	            mapProgram = mapPrograms.get(Trigger.old[i].Program__c); 
	        }else{
	            mapProgram = new Map<String, Double>();
	            mapProgram.put('new_Enrollment', 0);
	            mapProgram.put('old_Enrollment', 0);       
	            mapProgram.put('new_Donation'  , 0);
	            mapProgram.put('old_Donation'  , 0);
	            mapProgram.put('numberOfParticipantsPaid'  , 0);
	        }
	        
			Double oldAmount = (Trigger.old[i].Amount == null)?0:Trigger.old[i].Amount;	        	
        	
        	if(Trigger.old[i].Income_Type__c == 'Enrollment'){	        		
	        		oldTotalIncomeEnrollment = oldAmount;
	        		if(Trigger.old[i].StageName == 'Fully Paid'){numberOfParticipantsPaid = -1;}	        		
	        }else if (Trigger.old[i].Income_Type__c == 'Donation'){	        			        	
	        		oldTotalIncomeDonation = oldAmount;	        		
	        }
	        
	        mapProgram.put('new_Enrollment', mapProgram.get('new_Enrollment') + newTotalIncomeEnrollment);
	        mapProgram.put('old_Enrollment', mapProgram.get('old_Enrollment') + oldTotalIncomeEnrollment);       
	        mapProgram.put('new_Donation', mapProgram.get('new_Donation') + newTotalIncomeDonation);
	        mapProgram.put('old_Donation', mapProgram.get('old_Donation') + oldTotalIncomeDonation);
	        mapProgram.put('numberOfParticipantsPaid', mapProgram.get('numberOfParticipantsPaid') + numberOfParticipantsPaid);
	        	        
	        mapPrograms.put(Trigger.old[i].Program__c, mapProgram);
        }
    }     
    
    List<Program__c> upPrograms = new List<Program__c>(); 
    
    if(!mapPrograms.isEmpty()){
        
        for(Program__c program: [Select Id, Total_Income_from_Participants__c, Total_Income_from_Donations__c, Number_of_Participants_Paid__c From Program__c where Id IN :mapPrograms.keySet()] ){
            
            program.Total_Income_from_Participants__c = (program.Total_Income_from_Participants__c == null?0:program.Total_Income_from_Participants__c) 
            											+ (mapPrograms.get(program.Id)).get('new_Enrollment') - (mapPrograms.get(program.Id)).get('old_Enrollment');
            program.Total_Income_from_Donations__c = (program.Total_Income_from_Donations__c == null?0:program.Total_Income_from_Donations__c) 
            											+ (mapPrograms.get(program.Id)).get('new_Donation') - (mapPrograms.get(program.Id)).get('old_Donation');
            program.Number_of_Participants_Paid__c = (program.Number_of_Participants_Paid__c == null?0:program.Number_of_Participants_Paid__c) 
            											+ (mapPrograms.get(program.Id)).get('numberOfParticipantsPaid');
            
            upPrograms.add(program);
        }
    }
    
    if(!upPrograms.isEmpty()){
    	update upPrograms;
    }
    
}