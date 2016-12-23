public class WSMetricTools {

	public static void setmetricintial(List<Metrics__c> metrics){

		Set<Id> cntids = new Set<Id>(); //A Set of Contact Ids
		List<Contact> cnts = new List<Contact>(); //A List of Contacts
		Map<Id, Contact> cntmap = new Map <Id, Contact>(); //A Map of Contact Id to Contact Object
		Map<Id,Id> ctocmap = new Map<Id,Id>(); //A map of caseId to contactId
		List<Case> lstcases = new List<Case>(); //A List of Cases
		Set<Id> caseids = new Set<Id>();

		for(Metrics__c m : metrics){

			if(m.Case__c != NULL && m.Contact__c == NULL){
				caseids.add(m.Case__c); //Add the Case Id to the set of Case Ids
			}

			if(m.Contact__c != NULL){
				cntids.add(m.Contact__c); //Add the Contact Id to the set of Contact Ids
			}
			
		}

		lstcases = [Select Id, ContactId FROM Case Where Id IN: caseids];

		for(Case c : lstcases){

			if(c.ContactId != NULL){
				cntids.add(c.ContactId); //Add the Contact Id to the set of Contact Ids
				ctocmap.put(c.Id,c.ContactId); //Add the case Id and contact Id to a map
			}

		}

		cnts = [SELECT Id, Most_Recent_Income__c, Most_Recent_Expenses__c, Most_Recent_Debt__c, Most_Recent_Savings__c, Most_Recent_Verified_Credit_Score__c
				FROM Contact WHERE Id In: cntids];

		for(Contact c : cnts){

			cntmap.put(c.id, c);
		}

		for(Metrics__c m: metrics){

			if(m.Contact__c != NULL){ //Deal with Metrics with a contact

				m.Most_Recent_Income_Initial__c = cntmap.get(m.Contact__c).Most_Recent_Income__c;
				m.Most_Recent_Expense_Initial__c = cntmap.get(m.Contact__c).Most_Recent_Expenses__c;
				m.Most_Recent_Debt_Initial__c = cntmap.get(m.Contact__c).Most_Recent_Debt__c;
				m.Most_Recent_Savings_Initial__c = cntmap.get(m.Contact__c).Most_Recent_Savings__c;
				m.Most_Recent_Credit_Score_Initial__c = cntmap.get(m.Contact__c).Most_Recent_Verified_Credit_Score__c;
			
			}else if(m.Contact__c == NULL && m.Case__c != NULL && ctocmap.get(m.Case__c) != NULL){ //Deal with metrics with cases but no contacts

				String cntid = ctocmap.get(m.Case__c); //Determine the contact id from the case

				m.Contact__c = cntid;
				m.Most_Recent_Income_Initial__c = cntmap.get(cntid).Most_Recent_Income__c;
				m.Most_Recent_Expense_Initial__c = cntmap.get(cntid).Most_Recent_Expenses__c;
				m.Most_Recent_Debt_Initial__c = cntmap.get(cntid).Most_Recent_Debt__c;
				m.Most_Recent_Savings_Initial__c = cntmap.get(cntid).Most_Recent_Savings__c;
				m.Most_Recent_Credit_Score_Initial__c = cntmap.get(cntid).Most_Recent_Verified_Credit_Score__c;

			}
		}
	}

	public static void setmetricchange(Set<Id> mids){

		Double  tempChangeContr;
		Double  tempChangeCreditScore;
		Double  tempChangeMInc;
		Double  tempChangemxActual;
		Double  tempChangemxBudget;
		Double  tempChangePastDue;
		Double  tempChangeSavings;
		Double  tempChangeSSActual;
		Double  tempChangeSSBudget;
		Integer tempTime;

		Integer tempTimeContr;
		Integer tempTimeCreditScore;
		Integer tempTimeMInc;
		Integer tempTimemxActual;
		Integer tempTimemxBudget;
		Integer tempTimePastDue;
		Integer tempTimeSavings;
		Integer tempTimeSSActual;
		Integer tempTimeSSBudget;

		Boolean mupdate;

		

		Set<Id> cIds = new Set<Id>(); //A set of Contact Ids
		
		List<Metrics__c> metrics = new List<Metrics__c>(); //The list of newly inserted metrics
		List<Metrics__c> mupdates = new List<Metrics__c>(); //Llist of Metrics to Update
		List<Contact> cList = new List<Contact>(); //A list of Contacts
		List<Contact> cUps = new List<Contact>(); //A list of Contacts to Update
		
		Map<Id,Id> mtocmap = new Map<Id,Id>(); //A map of Metric Id to Contact Id
		//Map<Id,Date> ctodatemap = new Map<Id,Date>(); //A map of contact Id to Metric Date
		Map<Id,Metrics__c[]> ctomsmap = new Map<Id,Metrics__c[]>(); //Map of contact Ids to related Metrics
		Map<Id,Double> ctocredit = new Map<Id,Double>(); //Map of contact Id to Credit Change ... Delta_Credit_Score_Most_Recent__c
		Map<Id,Double> ctoincome = new Map<Id,Double>(); //Map of contact Id to Income Change ... Delta_Income_Most_Recent__c
		Map<Id,Double> ctosavings = new Map<Id,Double>(); //Map of contact Id to Savings Change ... Delta_Savings_Most_Recent__c
		Map<Id,Double> ctoexpense = new Map<Id,Double>(); //Map of contact Id to Expense Change ... Delta_Expense_Most_Recent__c
		Map<Id,Double> ctodebt = new Map<Id,Double>(); //Map of contact Id to Debt Change ... Delta_Debt_Most_Recent__c

		SObjectType metricType = Schema.getGlobalDescribe().get('Metrics__c'); //sObject Describe of Metric
		Map<String,Schema.SObjectField> mapMetricFields = metricType.getDescribe().fields.getMap(); //A Map of Fields on Metric

		//Query for the newly inserted Metrics
    	string metricselect = 'Select ';
        for(string md : mapMetricFields.keyset()){
            metricselect = metricselect + mapMetricFields.get(md) + ', ';
        }
        metricselect = metricselect.substring(0,metricselect.length()-2);
        metricselect = metricselect + '';
        metricselect = metricselect + ' FROM Metrics__c WHERE Id IN: mids';

       	try{
			metrics = (Metrics__c[])Database.query(metricselect); //The list of newly inserted Metrics
    	}catch(Exception epr){
    		system.debug('***********************ERROR Querying Newly Inserted Metrics ***********************' + epr.getMessage());
    	}

		//For each metric in the list of metrics generate at set of Contact Ids and a Map of Metric Id to Contact Ids
		for(Metrics__c m : metrics){

			cids.add(m.Contact__c);	//Add the contact Id to the set of Ids
			mtocmap.put(m.Id,m.Contact__c); //Populate the Metric Id to Contact Id Map
			//ctodatemap.put(m.Contact__c,m.Date_information_collected__c);
		}

		//For each Contact Id find the related list of Metrics sorted by date and add them to a map
		//Create the nested query stringe used to query for the contact and related list of metrics
    	string contactselect = 'SELECT Id, Delta_Credit_Score_Most_Recent__c, Delta_Income_Most_Recent__c, Delta_Savings_Most_Recent__c, Delta_Expense_Most_Recent__c, Delta_Debt_Most_Recent__c, (SELECT ';
        for(string mds : mapMetricFields.keyset()){
            contactselect = contactselect + mapMetricFields.get(mds) + ', ';
        }
        contactselect = contactselect.substring(0,contactselect.length()-2);
        contactselect = contactselect + '';
        contactselect = contactselect + ' FROM Metrics__r ORDER BY CreatedDate DESC) FROM Contact WHERE Id IN: cIds';

        //Execute the query for the contacts
        try{
			cList = (Contact[])Database.query(contactselect); //The list of contacts and related list of metrics
    	}catch(Exception erc){
    		system.debug('***********************ERROR Querying Contacts and Related LIst of Metrics ***********************' + erc.getMessage());
    	}

		//cList = [SELECT Id, (SELECT Id, Credit_Score__c, Date_information_collected__c, CreatedDate FROM Metrics__r WHERE Credit_Score__c != NULL ORDER BY CreatedDate DESC) FROM Contact WHERE Id IN: cIds];

		//For each contact id in the set retrieve the metric just prior to the most recent. if it's null set values to 0 if its not null calculate metric change and set map values
		for(Contact c : cList){

			if(c.Metrics__r != NULL){

				ctomsmap.put(c.Id,c.Metrics__r); //Populate the map of contact id to related metrics

			}

		}

		//For each metric in list of metrics specify update values

		for(Metrics__c mu : metrics){

			//String cntid;
			//List<Metrics__c> lcMetrics = new List<Metrics__c>(); //A list of metrics related to the current source contact
			//cntid = mu.Contact__c;

			tempChangeContr = NULL;
			tempChangeCreditScore = NULL;
			tempChangeMInc = NULL;
			tempChangemxActual = NULL;
			tempChangemxBudget = NULL;
			tempChangePastDue = NULL;
			tempChangeSavings = NULL;
			tempChangeSSActual = NULL;
			tempChangeSSBudget = NULL;

			tempTime = NULL;

			tempTimeContr = NULL;
			tempTimeCreditScore = NULL;
			tempTimeMInc = NULL;
			tempTimemxActual = NULL;
			tempTimemxActual = NULL;
			tempTimePastDue = NULL;
			tempTimeSavings = NULL;
			tempTimeSSActual = NULL;
			tempTimeSSBudget = NULL;

			if(ctomsmap.get(mu.Contact__c).size() > 1){

				//Integer prior = ctomsmap.get(mu.contact__c).indexOf(mu.Id);
				//mu.Change_In_Verified_Credit_Score__c = mu.Credit_Score__c - ctomsmap.get(mu.contact__c)[1].Credit_Score__c;
				//mu.Time_Since_Last_Verified_Credit_Score__c = ctomsmap.get(mu.contact__c)[1].Date_information_collected__c.daysBetween(mu.Date_information_collected__c);

				for(Metrics__c mx : ctomsmap.get(mu.contact__c)){//Evaluate the list of related metrics for this contact

					if(mx.Date_information_collected__c < mu.Date_information_collected__c){//Only consider the record if the Date the information collected was BEFORE the base record

						tempTime = mx.Date_information_collected__c.daysBetween(mu.Date_information_collected__c); //Number days between information collection

							//Check Savings Contributions
							if( tempChangeSavings == NULL && mu.Total_Savings_Contributions__c != mx.Total_Savings_Contributions__c && mx.Total_Savings_Contributions__c != NULL ){
								tempChangeSavings = mu.Total_Savings_Contributions__c-mx.Total_Savings_Contributions__c;
								tempTimeSavings = tempTime;
							}

							//Check Surplus and Shortfall Actual
							if( tempChangeSSActual == NULL && mu.Surplus_Shortfall_Actual__c != mx.Surplus_Shortfall_Actual__c && mx.Surplus_Shortfall_Actual__c != NULL ){
								tempChangeSSActual = mu.Surplus_Shortfall_Actual__c-mx.Surplus_Shortfall_Actual__c;
								tempTimeSSActual = tempTime;
							}

							//Check Surplus and Shortfall Budgeted
							if( tempChangeSSBudget == NULL && mu.Surplus_Shortfall_Budgeted__c != mx.Surplus_Shortfall_Budgeted__c && mx.Surplus_Shortfall_Budgeted__c != NULL ){
								tempChangeSSBudget = mu.Surplus_Shortfall_Budgeted__c-mx.Surplus_Shortfall_Budgeted__c;
								tempTimeSSBudget = tempTime;
							}

							//Check Contributions
							if( tempChangeContr == NULL && mu.Total_Contributions__c != mx.Total_Contributions__c && mx.Total_Contributions__c != NULL ){
								tempChangeContr = mu.Total_Contributions__c-mx.Total_Contributions__c;
								tempTimeContr = tempTime;
							}

							//Check Monthly Expenses Actual
							if( tempChangemxActual == NULL && mu.Total_Monthly_Expenses_Actual__c != mx.Total_Monthly_Expenses_Actual__c && mx.Total_Monthly_Expenses_Actual__c != NULL ){
								tempChangemxActual = mu.Total_Monthly_Expenses_Actual__c-mx.Total_Monthly_Expenses_Actual__c;
								tempTimemxActual = tempTime;
							}

							//Check Monthly Expenses Budgeted
							if( tempChangemxBudget == NULL && mu.Total_Monthly_Expenses_Budgeted__c != mx.Total_Monthly_Expenses_Budgeted__c && mx.Total_Monthly_Expenses_Budgeted__c != NULL ){
								tempChangemxBudget = mu.Total_Monthly_Expenses_Budgeted__c-mx.Total_Monthly_Expenses_Budgeted__c;
								tempTimemxBudget = tempTime;
							}

							//Check Credit Score
							if( tempChangeCreditScore == NULL && mu.Credit_Score__c != mx.Credit_Score__c && mx.Credit_Score__c != NULL && mu.Credit_Score__c != NULL ){
								tempChangeCreditScore = mu.Credit_Score__c-mx.Credit_Score__c;
								tempTimeCreditScore = tempTime;
							}

							//Check Monthly Income
							if( tempChangeMInc == NULL && mu.Total_Monthly_Income__c != mx.Total_Monthly_Income__c && mx.Total_Monthly_Income__c != NULL ){
								tempChangeMInc = mu.Total_Monthly_Income__c-mx.Total_Monthly_Income__c;
								tempTimeMInc = tempTime;
							}

							//Check Past Due
							if( tempChangePastDue == NULL && mu.Total_Past_Due__c != mx.Total_Past_Due__c && mx.Total_Past_Due__c != NULL ){
								tempChangePastDue = mu.Total_Past_Due__c-mx.Total_Past_Due__c;
								tempTimePastDue = tempTime;
							}

					}

				}

				//if values need to be update change them and indicate that the metric should be updated
				if(tempChangeCreditScore != NULL){
					mu.Change_In_Verified_Credit_Score__c = tempChangeCreditScore;
					mu.Time_Since_Last_Verified_Credit_Score__c = tempTimeCreditScore;
					ctocredit.put(mu.Contact__c, tempChangeCreditScore);
					mupdate = TRUE;
				}

				if(tempChangeSavings != NULL){
					mu.Change_in_DEP_Total_Savings__c = tempChangeSavings;
					mu.Time_Since_Last_Total_Savings__c = tempTimeSavings;
					ctosavings.put(mu.Contact__c, tempChangeSavings);
					mupdate = TRUE;
				}

				if(tempChangeSSActual != NULL){
					mu.Change_in_Surplus_Shortfall_Actual__c = tempChangeSSActual;
					mu.Time_Since_Last_SS_Actual__c = tempTimeSSActual;
					mupdate = TRUE;
				}

				if(tempChangeSSBudget != NULL){
					mu.Change_in_Surplus_Shortfall_Budget__c = tempChangeSSBudget;
					mu.Time_Since_Last_SS_Budget__c = tempTimeSSBudget;
					mupdate = TRUE;					
				}

				if(tempChangeContr != NULL){
					mu.Change_In_Total_Contributions__c = tempChangeContr;
					mu.Time_Since_Last_Contributions__c = tempTimeContr;
					mupdate = TRUE;
				}

				if(tempChangemxActual != NULL){
					mu.Change_In_Total_Monthly_Expense_Actual__c = tempChangemxActual;
					mu.Time_Since_Last_Monthly_Expense_Actual__c = tempTimemxActual;
					ctoexpense.put(mu.Contact__c, tempChangemxActual);
					mupdate = TRUE;
				}

				if(tempChangemxBudget != NULL){
					mu.Change_in_Total_Monthly_Expense_Budget__c = tempChangemxBudget;
					mu.Time_Since_Last_Monthly_Expense_Budget__c = tempTimemxBudget;
					mupdate = TRUE;				
				}

				if(tempChangeMInc != NULL){
					mu.Change_In_Total_Monthly_Income__c = tempChangeMInc;
					mu.Time_Since_Last_Monthly_Income__c = tempTimeMInc;
					ctoincome.put(mu.Contact__c, tempChangeMInc);
					mupdate = TRUE;
				}
				
				if(tempChangePastDue != NULL){
					mu.Change_in_Total_Past_Due__c = tempChangePastDue;
					mu.Time_Since_Last_Past_Due__c = tempTimePastDue;
					ctodebt.put(mu.Contact__c, tempChangePastDue);
					mupdate = TRUE;
				}

				//}else{
					//mu.Change_In_Verified_Credit_Score__c = NULL;
					//mu.Time_Since_Last_Verified_Credit_Score__c = NULL;
				//}

				if(mupdate == TRUE){
					mupdates.add(mu); //Add the metric to the list of metrics to update only if something needs to be updated
				}

			}
		}

		if(!clist.isEmpty()){ //Operation on the list of contacts and determine if Deltas need to be updated

			for(Contact cl : clist){

				Boolean cupdate = FALSE;

				if(ctocredit.get(cl.Id) != NULL){
					cl.Delta_Credit_Score_Most_Recent__c = ctocredit.get(cl.Id);
					cupdate = TRUE;
				}

				if(ctoincome.get(cl.Id) != NULL){
					cl.Delta_Income_Most_Recent__c = ctoincome.get(cl.Id);
					cupdate = TRUE;
				}

				if(ctosavings.get(cl.Id) != NULL){
					cl.Delta_Savings_Most_Recent__c = ctosavings.get(cl.Id);
					cupdate = TRUE;
				}

				if(ctoexpense.get(cl.Id) != NULL){
					cl.Delta_Expense_Most_Recent__c = ctoexpense.get(cl.id);
					cupdate = TRUE;
				}

				if(ctodebt.get(cl.Id) != NULL){
					cl.Delta_Debt_Most_Recent__c = ctodebt.get(cl.id);
					cupdate = TRUE;
				}

				if(cupdate = TRUE){
					cUps.add(cl);
				}

			}//End or(Contact cl : clist){

		}//End if(!clist.isEmpty())

		//Update the metric records

		if(!mupdates.isEmpty()){
			try{
				update mupdates; //Update the metric records
			}catch(Exception e){
				System.Debug('------------Error Updating Metrics-----------'+e);
			}
		}

		if(!cUps.isEmpty()){
			try{
				update cUps; 
			}catch(Exception ec){
				System.Debug('------------Error Update Contacts with Deltas----------'+ec);
			}
		}

	}

}