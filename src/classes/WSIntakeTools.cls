public class WSIntakeTools {

	public static void createMetricFromIntake(Set<Id> iids) {

		Set<Id> nocnts = new Set<Id>(); //A set of Intake Ids with no contacts
		Map<Id,Id> noeng = new Map<Id,Id>(); //A map of Contact Id to Intake Id of Intake Ids with no Cases (Engagements)
		Map<Id,Id> casemap = new Map<Id,Id>(); //A map of Intake Id to Case Id
		Set<Id> newids = new Set<Id>(); //A set of New Ids
		Set<Id> caseids = new Set<Id>(); //A set of Case Ids

		List<Intake__c> ins = new List<Intake__c>(); //A list of Intakes
		List<Intake__c> iups = new List<Intake__c>(); //A list of Intakes to Update
		List<Intake__c> inoc = new List<Intake__c>(); //A list of Intakes with no Case (Engagement)
		List<Metrics__c> newmetrics = new List<Metrics__c>(); //A list of new metrics
		List<Case> newcases = new List<Case>(); //A list of cases

		SObjectType intaketype = Schema.getGlobalDescribe().get('Intake__c');
        Map<String,Schema.SObjectField> intakeFields = intakeType.getDescribe().fields.getMap(); //A Map of Fields on Payment

        Map<Id,Id> metmap = new Map<Id,Id>(); //A map of contact Id to metric Id

        string intakeselect = 'Select ';

        for(string pd : intakeFields.keyset()){
            intakeselect = intakeselect + intakeFields.get(pd) + ', ';
        }
        intakeselect = intakeselect.substring(0,intakeselect.length()-2);
        intakeselect = intakeselect + '';
        intakeselect = intakeselect + ' FROM Intake__c';

        try{
            ins = (Intake__c[])Database.query(intakeselect); //The list of Intakes
        }catch(Exception epr){
            system.debug('***********************ERROR Querying Intakes ***********************' + epr.getMessage());
        }

		for(Intake__c i : ins){

			Boolean CreateMetric = TRUE;

			//Intake__c i = (Intake__c)so;

			Metrics__c m = new Metrics__c();

			if(i.Contact__c != NULL){
				m.Contact__c  = i.Contact__c;

			}else{
				nocnts.add(i.id);
				CreateMetric = FALSE;
			}

			if(i.Engagement__c != NULL){
				m.Case__c = i.Engagement__c;
			}else{
				inoc.add(i);
			}

			m.Auto_Loans_Payment__c  = i.Auto_Loans_Payment__c;
			m.Banked_Status__c  = i.Banked_Status__c;
			m.Car_Insurance__c  = i.Car_Insurance__c;
			m.Cell_Phone__c  = i.Cell_Phone__c;
			m.Child_Care__c  = i.Child_Care__c;
			m.Child_Support_Alimony_expense__c  = i.Child_Support_and_or_Alimony__c;
			m.Child_Support_and_or_Alimony__c  = i.Child_Support__c;
			m.Clothing__c  = i.Clothing__c;
			m.Confidence_Financial_Future__c  = i.Financial_Future_Confidence__c;
			m.Contribution_to_College_Savings__c  = i.Total_College_Savings__c;
			m.Contribution_to_Emergency__c  = i.Total_Emergency__c;
			m.Contribution_to_General__c  = i.Total_General__c;
			m.Contribution_to_Holiday_Vacation__c  = i.Total_Holiday_Vacation__c;
			m.Contribution_to_IDA__c  = i.Total_IDA__c;
			m.Contribution_to_IRA__c  = i.Total_Retirement__c;
			m.Credit_Score__c  = i.Verified_Credit_Score__c;
			m.Date_information_collected__c  = date.newinstance(i.CreatedDate.year(), i.CreatedDate.month(), i.CreatedDate.day());
			m.Disability__c  = i.Disability__c;
			m.Employment_Income__c  = i.Formal_and_Informal_Employment__c;
			m.Entertainment__c  = i.Entertainment__c;
			m.Family_Friends_Loan_Payment__c  = i.Friends_Family_Loan__c;
			m.Food2__c  = i.Food__c;
			m.Health_Insurance__c  = i.Health_Insurance__c;
			m.Housing__c  = i.Housing__c;
			m.Intake__c  = TRUE;
			m.Liens__c  = i.Total_Tax_Liens_Garnishments__c;
			/*m.Metric_Status_Banked_Status__c  = 'Complete';
			m.Metric_Status_Credit__c  = 'Complete';
			m.Metric_Status_Expenses__c  = 'Complete';
			m.Metric_Status_Income__c  = 'Complete';
			m.Metric_Status_Post_Session__c  = 'Complete';
			m.Metric_Status__c  = 'Complete';*/
			m.Monthly_Payment_Other_Debt__c  = i.Other_Loans_Payment__c;
			m.Monthly_Payment_Real_Estate_Loan__c  = i.Real_Estate_Loans_Payment__c;
			m.Monthly_Payment_Revolving_Loans__c  = i.Revolving_Loans_Payments__c;
			m.Monthly_Payment_Secured_Installment_Loan__c  = i.Secured_Installment_Loans_Payment__c;
			m.Monthly_Payment_Student_Loans__c  = i.Student_Loans_Payment__c;
			m.Monthly_Payment_Unsecured_Installmt_Loan__c  = i.Unsecured_Installment_Loans_Payment__c;
			m.No_Credit_Score_Available__c  = i.No_Credit_Score_Available__c;
			m.Other_Income__c  = i.Other_Income__c;
			m.Other_Monthly_Expense__c  = i.Other_Monthly_Expense__c;
			m.Other_Monthly_Expenses_Explanation__c  = i.Other_Monthly_Expense_Explanation__c;
			m.Past_Due_Auto_Loans__c  = i.Total_Auto_Loans__c;
			m.Past_Due_Cell_Phone_Bills__c  = i.Total_Cell_Phone_Bills_Past_Due__c;
			m.Past_Due_Family_Friends_Loan__c  = i.Total_Friends_Family_Loans__c;
			m.Past_Due_Household_Bills__c  = i.Total_Household_Bills_Past_Due__c;
			m.Past_Due_Medical_Bill__c  = i.Total_Medical_Bills_Past_Due__c;
			m.Past_Due_Other_Bills__c  = i.Total_Other_Bills_Past_Due__c;
			m.Past_Due_Other_Loans__c  = i.Total_Other_Loans__c;
			m.Past_Due_Predatory_Loans__c  = i.Total_Predatory_Loans__c;
			m.Past_Due_Real_Estate_Loans__c  = i.Total_Real_Estate_Loans__c;
			m.Past_Due_Revolving_Loans__c  = i.Total_Revolving_Loans__c;
			m.Past_Due_Secured_Installment_Loans__c  = i.Total_Secured_Installment_Loans__c;
			m.Past_Due_Student_Loans__c  = i.Total_Student_Loans__c;
			m.Past_Due_Unsecured_Installment_Loans__c  = i.Total_Unsecured_Installment_Loans__c;
			m.Pension_Retirement_and_Investment__c  = i.Pension_Retirement_and_Investment__c;
			m.Predatory_Loans_Payment__c  = i.Predatory_Loans_Payment__c;
			m.SNAP__c  = i.SNAP__c;
			m.Self_Employment_Income__c  = i.Self_Employment__c;
			m.Social_Security__c  = i.Social_Security__c;
			m.TANF__c  = i.TANF__c;
			m.Tax_Liens_Garnishments__c  = i.Tax_Liens_Garnishments2__c;
			m.Transportation__c  = i.Transportation__c;
			m.Unemployment_Income__c  = i.Unemployment__c;
			m.Utilities__c  = i.Utilities_Other_Household_Expenditures__c;
			m.Veteran_s_Assistance_Survivor_s_Benefits__c  = i.Veteran_s_Assistance_Survivor_s_Benefits__c;
			m.WIC__c  = i.WIC__c;
			m.Warrants2__c  = i.Total_Warrants__c;
			m.Warrants__c  = i.Warrants2__c;
			m.Workman_s_Compensation__c  = i.Workman_s_Compensation__c;

			if(CreateMetric = TRUE){
				newmetrics.add(m);
			}

		}

		if(!newmetrics.isEmpty()){ //Only do something if the list of new metrics is not empty
			try{
				Database.SaveResult[] srs = Database.Insert(newmetrics,false); //Try  to insert the new metrics
				for(Database.SaveResult sr : srs){ //Cycle through the Save Results
					if(sr.isSuccess() == TRUE){ //Do something if the result is a success
						newids.add(sr.getId()); //Add the new Ids to a set of Ids
					}
				}
			}catch(Exception e){
				System.Debug('------------Error Inserting Metric from Intake------------'+e.getMessage());
			}
		}

		if(!newids.isEmpty()){//Only do something if the set of new ids is not empty
			List<Metrics__c> mets = [SELECT Id, Contact__c FROM Metrics__c WHERE Id IN: newids]; //The list of new metrics
			if(!mets.isEmpty()){ //Do something if the list of new metrics is not empty
				for(Metrics__c m : mets){ //Cycle through the list of metrics
					metmap.put(m.Contact__c, m.id); //Add values to the map
				}
			}
		}

		if(!inoc.isEmpty()){

			for(Intake__c inc : inoc){

				Case c = new Case();

				if(inc.Contact__c != NULL){
					c.ContactId = inc.Contact__c;
					c.AccountId = inc.Contact__r.AccountId;
				}

				c.Intake__c = inc.Id;
				c.Status = 'New';
				c.Origin = 'Intake';

				newcases.add(c);

			}

		}

		if(!newcases.isEmpty()){

			try{
				Database.SaveResult[] src = Database.Insert(newcases,false); //Try  to insert the new metrics
				for(Database.SaveResult sc : src){ //Cycle through the Save Results
					if(sc.isSuccess() == TRUE){ //Do something if the result is a success
						caseids.add(sc.getId()); //Add the new Ids to a set of Ids
					}
				}
			}catch(Exception e){
			System.Debug('------------Error Inserting Metric from Intake------------'+e.getMessage());
			}

		}

		if(!caseids.isEmpty()){//Only do something if the set of case ids is not empty
			List<Case> css = [SELECT Id, Intake__c FROM Case WHERE Id IN: caseids]; //The list of new cases
			if(!css.isEmpty()){ //Do something if the list of new metrics is not empty
				for(Case c : css){ //Cycle through the list of cases
					casemap.put(c.Intake__c, c.id); //Add values to the map
				}
			}
		}

		for(Intake__c i : ins){ //Cycle the the original list of Intakes

			Boolean addc = FALSE;
			Boolean addi = FALSE;

			if(metmap.get(i.Contact__c) != NULL && i.Metric__c == NULL){ //Only do somethign if there is a contact to metric map value
				i.Metric__c = metmap.get(i.Contact__c); //Update the metric reference on the intake using the contact map 
				addc = TRUE;
			}

			if(casemap.get(i.Id) != NULL && i.Engagement__c == NULL){
				i.Engagement__c = casemap.get(i.Id);
				addi = TRUE;
			}

			if(addc || addi){
				iups.add(i); //Add the intake to the list of metrics to be updated
			}

		}

		if(!iups.isEmpty()){ //Only do something if the list of Intakes to update is not empty
			try{
				Database.UpsertResult[] sru = Database.Upsert(iups,false); //Try  to update the Intakes
			}catch(Exception eu){
				System.Debug('------------Error Updating Intakes with the Metric------------'+eu.getMessage());
			}
		}

		if(!noeng.isEmpty()){


		}

	}

}