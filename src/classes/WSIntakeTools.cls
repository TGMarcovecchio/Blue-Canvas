/**********************************************************************
* Name:     WSIntakeTools
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     28 Dec 2016
* ======================================================
* ======================================================
* Purpose:                                                            
* Class for Intake__c related methods
*                                                            
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       28 Dec 2016     TGM         Initial Development
***********************************************************************/
public class WSIntakeTools {

	public static void beforeInsertIntake(List<Intake__c> ins){

		for(Intake__c i : ins){

			String tempname;

			tempname='';

			if(i.First_Name__c != NULL && i.Last_Name__c != NULL){

				tempname = i.First_Name__c + ' ' + i.Last_Name__c;

			}else if(i.First_Name__c == NULL && i.Last_Name__c != NULL){

				tempname = i.Last_Name__c;

			}else if(i.First_Name__c != NULL && i.Last_Name__c == NULL){

				tempname = i.First_Name__c;

			}else if(i.First_Name__c == NULL && i.Last_Name__c == NULL){

				tempname = 'Unknown Intake by ' + UserInfo.getName();
			}

			if(i.Name == NULL || i.Name == '' || i.Name == 'Default' || i.Name == String.valueOf(i.Id)){

				i.Name = tempname;

			}else if(i.Name != NULL && i.Name !='' && i.Name != tempname){

				i.Name = tempname;
			}
		}
	}

	public static void createContactfromIntake(Set<Id> iids){

		List<Intake__c> ins = new List<Intake__c>(); //A List of Intakes
		List<Intake__c> iups = new List<Intake__c>(); //A List of Intakes to Update

		List<Contact> newcontacts = new List<Contact>(); //A List of New Contacts To Create
		List<Contact> contacts = new List<Contact>(); //A List of Newly Created Contacts

		Set<Id> newids = new Set<Id>(); //A Set of ids for newly inserted contacts
		Map<Id,Contact> intakemap = new Map<Id,Contact>(); //A Map of Intake Ids to Contact Ids

		SObjectType intaketype = Schema.getGlobalDescribe().get('Intake__c');
        Map<String,Schema.SObjectField> intakeFields = intakeType.getDescribe().fields.getMap(); //A Map of Fields on Payment

        Map<Id,Id> metmap = new Map<Id,Id>(); //A map of contact Id to metric Id

        string intakeselect = 'Select ';

        for(string pd : intakeFields.keyset()){
            intakeselect = intakeselect + intakeFields.get(pd) + ', ';
        }
        intakeselect = intakeselect.substring(0,intakeselect.length()-2);
        intakeselect = intakeselect + '';
        intakeselect = intakeselect + ' FROM Intake__c WHERE Id IN: iids';

        try{
            ins = (Intake__c[])Database.query(intakeselect); //The list of Intakes
        }catch(Exception epr){
            system.debug('***********************ERROR Querying Intakes ***********************' + epr.getMessage());
        }

		for(Intake__c i : ins){

			if(i.Contact__c == NULL){

				Contact c = new Contact();
		 	
				c.Birthdate = i.Birthdate__c;
				c.Disputes__c = i.Disputes__c;
				c.Employment_Status__c = i.Employment_Status__c;
				c.Ethnicity__c = i.Ethnicity__c;
				c.First_Banked_Status__c = i.Banked_Status__c;
				c.First_Banked_Status_Date__c = date.newinstance(i.CreatedDate.year(),i.CreatedDate.month(),i.CreatedDate.day()); //date.newinstance(dT.year(), dT.month(), dT.day())
				c.First_Credit_History_Date__c = date.newinstance(i.CreatedDate.year(),i.CreatedDate.month(),i.CreatedDate.day());
				c.First_Debt__c = i.Total_Debt__c;
				c.First_Debt_Date__c = date.newinstance(i.CreatedDate.year(),i.CreatedDate.month(),i.CreatedDate.day());
				c.First_Expenses__c = i.Total_Monthly_Expenses__c;
				c.First_Expenses_Date__c = date.newinstance(i.CreatedDate.year(),i.CreatedDate.month(),i.CreatedDate.day());
				c.First_Fin_Future_Confidence__c = i.Financial_Future_Confidence__c;
				c.First_Fin_Future_Confidence_Date__c = date.newinstance(i.CreatedDate.year(),i.CreatedDate.month(),i.CreatedDate.day());
				c.First_Income__c = i.Total_Income__c;
				c.First_Income_Date__c = date.newinstance(i.CreatedDate.year(),i.CreatedDate.month(),i.CreatedDate.day());
				c.First_Savings__c = i.Total_Savings__c;
				c.First_Savings_Date__c = date.newinstance(i.CreatedDate.year(),i.CreatedDate.month(),i.CreatedDate.day());
				c.First_Self_reported_Credit_Score__c = i.Self_Rated_Credit_Score__c;
				c.First_Verified_Credit_Score__c = i.Verified_Credit_Score__c;
				c.Gender__c = i.Gender__c;
				c.Head_of_Household__c = i.Head_of_Household__c;
				c.HH_Size__c = i.Number_of_Household_Residents__c;
				c.HomePhone = i.Home_Phone__c;
				c.Information_Correct__c = i.Information_Correct__c;
				c.Intake__c = i.id;
				c.Looking_for_work__c = i.Looking_for_Work__c;
				c.Member_Since__c = i.Member_Since__c;
				c.Native_or_preferred_language__c = i.Other_Preferred_Language__c;
				c.No_Credit_Score_Available__c = i.No_Credit_Score_Available__c;
				c.npe01__AlternateEmail__c = i.Alternate_Email__c;
				c.npe01__HomeEmail__c = i.Personal_Email__c;
				c.npe01__Preferred_Email__c = i.Preferred_Email__c;
				c.npe01__PreferredPhone__c = i.Preferred_Phone__c;
				c.npe01__Primary_Address_Type__c = i.Mailing_Address_Type__c;
				c.npe01__Secondary_Address_Type__c = i.Physical_Address_Type__c;
				c.npe01__WorkEmail__c = i.Work_Email__c;
				c.npe01__WorkPhone__c = i.Work_Phone__c;
				c.OtherPhone = i.Other_Phone__c;
				c.Place_of_work__c = i.Place_s_of_Work__c;
				c.Preferred_Language__c = i.Preferred_Language__c;
				c.Race__c = i.Race__c;
				c.SLCCU_Member__c = i.SLCCU_Member__c;
				c.Source_Engagement__c = i.Engagement__c;
				c.Source_Intake__c = i.Id;
				c.Type_of_work__c = i.Type_of_Work__c;
				c.U_S_Citizen__c = i.U_S_Citizen__c;
				c.Veteran__c = i.Veteran__c;
				c.FirstName = i.First_Name__c;
				c.LastName = i.Last_Name__c;
				c.MailingCity = i.Mailing_City__c;
				c.MailingState = i.Mailing_State__c;
				c.MailingStreet = i.Mailing_Street__c;
				c.MailingPostalCode = i.Mailing_Zip_Code__c;
				c.MobilePhone = i.Mobile_Phone__c;
				c.OtherCity = i.Physical_City__c;
				c.OtherState = i.Physical_State__c;
				c.OtherStreet = i.Physical_Street__c;
				c.OtherPostalCode = i.Physical_Zip_Code__c;

				newcontacts.add(c);

			}//End if i.Contact__c == NULL

		}//End for Intake__c i: ins

		if(!newcontacts.isEmpty()){ //Only do something if the list of new contacts is not empty
			try{
				Database.SaveResult[] srs = Database.Insert(newcontacts,false); //Try  to insert the new contacts
				for(Database.SaveResult sr : srs){ //Cycle through the Save Results
					if(sr.isSuccess() == TRUE){ //Do something if the result is a success
						newids.add(sr.getId()); //Add the new Ids to a set of Ids
					}
				}
			}catch(Exception e){
				System.Debug('------------Error Inserting New Contacts from Intakes ------------'+e.getMessage());
			}
		}

		if(!newids.isEmpty()){

			contacts = [SELECT Id, Intake__c, AccountId FROM Contact WHERE Id IN: newids];

		}

		if(!contacts.isEmpty()){

			for(Contact c : contacts){

				intakemap.put(c.Intake__c,c); //Populate the Intake to Contact ID Map

			}

		}

		for(Intake__c iu : ins){

			iu.Contact__c = intakemap.get(iu.id).id;
			iu.Account__c = intakemap.get(iu.id).AccountId;
			iups.add(iu);

		}

		if(!iups.isEmpty()){ //Only do something if the list of intakes to update is not empty
			try{
				Database.UpsertResult[] srs = Database.Upsert(iups,false); //Try  to upsert the Intakes
			}catch(Exception e){
				System.Debug('------------Error Upserting Intakes with Contact Ids ------------'+e.getMessage());
			}
		}


		createCasefromIntake(iids); //Move to Creating Engagements / Cases 

	}

	public static void createCasefromIntake(Set<Id> iids){

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
        intakeselect = intakeselect + ' FROM Intake__c WHERE Id IN: iids';

        try{
            ins = (Intake__c[])Database.query(intakeselect); //The list of Intakes
        }catch(Exception epr){
            system.debug('***********************ERROR Querying Intakes ***********************' + epr.getMessage());
        }

		for(Intake__c i : ins){

			if(i.Engagement__c == NULL){

				Case c = new Case(); //Create a new case

				c.ContactId = i.Contact__c;
				c.AccountId = i.Account__c;
				c.Intake__c = i.id;
				c.Origin = 'Intake';
				c.Status = 'New';
				c.Priority = 'Medium';
				//c.Type = 'Intake';
				//c.Reason = 'Intake';

				newcases.add(c); //Add the case to the list of cases to be created

			} //End if i.Engagement__C == NULL

		} //End for Intake__c i : ins

		if(!newcases.isEmpty()){ //Only do something if the list of new cases is not empty
			try{
				Database.SaveResult[] srs = Database.Insert(newcases,false); //Try  to insert the new cases
				for(Database.SaveResult sr : srs){ //Cycle through the Save Results
					if(sr.isSuccess() == TRUE){ //Do something if the result is a success
						newids.add(sr.getId()); //Add the new Ids to a set of Ids
					}
				}
			}catch(Exception e){
				System.Debug('------------Error Inserting Case from Intake------------'+e.getMessage());
			}
		}

		List<Case> cases = [SELECT Id, Intake__c FROM Case WHERE Id IN: newids]; //Select the list of newly created Cases

		if(!cases.isEmpty()){
			for(Case cs : cases){
				casemap.put(cs.Intake__c, cs.id); //Populate the map of Intake Ids to Case Ids
			}
		}

		for(Intake__c i : ins){
			i.Engagement__c = casemap.get(i.id); //Retrive the Case Id and set the reference on Intake
			iups.add(i);
		}

		if(!iups.isEmpty()){

			try{
			Database.UpsertResult[] sri = Database.Upsert(iups,false); //Try and update the intakes
			}catch(Exception eiu){
				System.Debug('-------------- Error Updating Intakes ----------------'+eiu.getMessage());
			}
		}

		createMetricFromIntake(iids); //Move to Creating Intakes 

	}

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
        intakeselect = intakeselect + ' FROM Intake__c WHERE Id IN: iids';

        try{
            ins = (Intake__c[])Database.query(intakeselect); //The list of Intakes
        }catch(Exception epr){
            system.debug('***********************ERROR Querying Intakes ***********************' + epr.getMessage());
        }

		for(Intake__c i : ins){

			Boolean CreateMetric = TRUE;

			//Intake__c i = (Intake__c)so; .... need to remove a field on Metric to add this reference

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

		for(Intake__c i : ins){ //Cycle the the original list of Intakes

			Boolean addc = FALSE;
			Boolean addi = FALSE;

			if(metmap.get(i.Contact__c) != NULL && i.Metric__c == NULL){ //Only do somethign if there is a contact to metric map value
				i.Metric__c = metmap.get(i.Contact__c); //Update the metric reference on the intake using the contact map 
				addc = TRUE;
			}

			/*if(casemap.get(i.Id) != NULL && i.Engagement__c == NULL){
				i.Engagement__c = casemap.get(i.Id);
				addi = TRUE;
			}*/

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

		createEPfromIntake(iids); //Move to creating Engagement Plans

	}

	public static void createEPfromIntake(Set<Id> iids){

		List<npsp__Engagement_Plan__c> eps = new List<npsp__Engagement_Plan__c>();

		List<Intake__c> ins = new List<Intake__c>(); //A list of Intakes

		SObjectType intaketype = Schema.getGlobalDescribe().get('Intake__c');
        Map<String,Schema.SObjectField> intakeFields = intakeType.getDescribe().fields.getMap(); //A Map of Fields on Payment

        Map<Id,Id> metmap = new Map<Id,Id>(); //A map of contact Id to metric Id

        string intakeselect = 'Select ';

        for(string pd : intakeFields.keyset()){
            intakeselect = intakeselect + intakeFields.get(pd) + ', ';
        }
        intakeselect = intakeselect.substring(0,intakeselect.length()-2);
        intakeselect = intakeselect + '';
        intakeselect = intakeselect + ' FROM Intake__c WHERE Id IN: iids';

        try{
            ins = (Intake__c[])Database.query(intakeselect); //The list of Intakes
        }catch(Exception epr){
            system.debug('***********************ERROR Querying Intakes ***********************' + epr.getMessage());
        }

		for(Intake__c i : ins){

			if(i.Engagement_Plan_Template__c != NULL){

				npsp__Engagement_Plan__c ep = new npsp__Engagement_Plan__c(); //Create a new case

				ep.npsp__Engagement_Plan_Template__c = i.Engagement_Plan_Template__c;

				if(i.Engagement__c != NULL){

					ep.npsp__Case__c = i.Engagement__c;
					eps.add(ep);

				}else if(i.Contact__c != NULL){

					ep.npsp__Contact__c = i.Contact__c;
					eps.add(ep);

				}

			}

			if(!eps.isEmpty()){

				try{
					Database.SaveResult[] sru = Database.Insert(eps,false); //Try to insert the Engagement Plans
				}catch(Exception eu){
					System.Debug('------------Error Inserting Engagement Plans form Intakes ------------'+eu.getMessage());
				}

			}

		}


	}

	public static void updateMetricfromIntake(Set<Id> iids){ //Update the metric associated to an intake when the intake changes

		Set<Id> mids = new Set<Id>(); //Metric Ids

		List<Intake__c> intakes = new List<Intake__c>(); //The List of Intakes
		List<Metrics__c> metrics = new List<Metrics__c>(); //The List of Metrics
		List<Metrics__c> mups = new List<Metrics__c>(); //The List of Metrics to Update

		Map<Id, Intake__c> themap = new Map<Id, Intake__c>(); //A Map of Metric Id to the Parent Intake Object

		//FIND THE INTAKES
		SObjectType intaketype = Schema.getGlobalDescribe().get('Intake__c');
        Map<String,Schema.SObjectField> intakeFields = intakeType.getDescribe().fields.getMap(); //A Map of Fields on Payment

        string intakeselect = 'Select ';

        for(string pd : intakeFields.keyset()){
            intakeselect = intakeselect + intakeFields.get(pd) + ', ';
        }
        intakeselect = intakeselect.substring(0,intakeselect.length()-2);
        intakeselect = intakeselect + '';
        intakeselect = intakeselect + ' FROM Intake__c WHERE Id IN: iids';

        try{
            intakes = (Intake__c[])Database.query(intakeselect); //The list of Intakes
        }catch(Exception epr){
            system.debug('***********************ERROR Querying Intakes ***********************' + epr.getMessage());
        }

        //GATHER THE METRIC IDS
        if(!intakes.isEmpty()){

        	for(Intake__c it : intakes){

        		mids.add(it.Metric__c); //Populate the set
        		themap.put(it.Metric__c,it); //Populate the map

        	}

	        //FIND THE RELATE METRICS
			SObjectType metrictype = Schema.getGlobalDescribe().get('Metrics__c');
	        Map<String,Schema.SObjectField> metricFields = metrictype.getDescribe().fields.getMap(); //A Map of Fields on Payment

	        string metricselect = 'Select ';

	        for(string pm : metricFields.keyset()){
	            metricselect = metricselect + metricFields.get(pm) + ', ';
	        }
	        metricselect = metricselect.substring(0,metricselect.length()-2);
	        metricselect = metricselect + '';
	        metricselect = metricselect + ' FROM Metrics__c WHERE Id IN: mids';

	        try{
	            metrics = (Metrics__c[])Database.query(metricselect); //The list of Intakes
	        }catch(Exception epr){
	            system.debug('***********************ERROR Querying Metrics ***********************' + epr.getMessage());
	        }

    	}

    	//CYCLE THROUGH THE METRICS AND COMPARE THEM TO THEIR PARENT INTAKES
    	if(!metrics.isEmpty()){

    		for(Metrics__c m : metrics){

    			Boolean updatem = FALSE;

    			Intake__c i = themap.get(m.id);

				if(m.Auto_Loans_Payment__c  != i.Auto_Loans_Payment__c){
				     m.Auto_Loans_Payment__c  = i.Auto_Loans_Payment__c;
				      updatem = TRUE;
				}


				if(m.Banked_Status__c  != i.Banked_Status__c){
				     m.Banked_Status__c  = i.Banked_Status__c;
				      updatem = TRUE;
				}


				if(m.Car_Insurance__c  != i.Car_Insurance__c){
				     m.Car_Insurance__c  = i.Car_Insurance__c;
				      updatem = TRUE;
				}


				if(m.Cell_Phone__c  != i.Cell_Phone__c){
				     m.Cell_Phone__c  = i.Cell_Phone__c;
				      updatem = TRUE;
				}


				if(m.Child_Care__c  != i.Child_Care__c){
				     m.Child_Care__c  = i.Child_Care__c;
				      updatem = TRUE;
				}


				if(m.Child_Support_Alimony_expense__c  != i.Child_Support_and_or_Alimony__c){
				     m.Child_Support_Alimony_expense__c  = i.Child_Support_and_or_Alimony__c;
				      updatem = TRUE;
				}


				if(m.Child_Support_and_or_Alimony__c  != i.Child_Support__c){
				     m.Child_Support_and_or_Alimony__c  = i.Child_Support__c;
				      updatem = TRUE;
				}


				if(m.Clothing__c  != i.Clothing__c){
				     m.Clothing__c  = i.Clothing__c;
				      updatem = TRUE;
				}


				if(m.Confidence_Financial_Future__c  != i.Financial_Future_Confidence__c){
				     m.Confidence_Financial_Future__c  = i.Financial_Future_Confidence__c;
				      updatem = TRUE;
				}


				if(m.Contribution_to_College_Savings__c  != i.Total_College_Savings__c){
				     m.Contribution_to_College_Savings__c  = i.Total_College_Savings__c;
				      updatem = TRUE;
				}


				if(m.Contribution_to_Emergency__c  != i.Total_Emergency__c){
				     m.Contribution_to_Emergency__c  = i.Total_Emergency__c;
				      updatem = TRUE;
				}


				if(m.Contribution_to_General__c  != i.Total_General__c){
				     m.Contribution_to_General__c  = i.Total_General__c;
				      updatem = TRUE;
				}


				if(m.Contribution_to_Holiday_Vacation__c  != i.Total_Holiday_Vacation__c){
				     m.Contribution_to_Holiday_Vacation__c  = i.Total_Holiday_Vacation__c;
				      updatem = TRUE;
				}


				if(m.Contribution_to_IDA__c  != i.Total_IDA__c){
				     m.Contribution_to_IDA__c  = i.Total_IDA__c;
				      updatem = TRUE;
				}


				if(m.Contribution_to_IRA__c  != i.Total_Retirement__c){
				     m.Contribution_to_IRA__c  = i.Total_Retirement__c;
				      updatem = TRUE;
				}


				if(m.Credit_Score__c  != i.Verified_Credit_Score__c){
				     m.Credit_Score__c  = i.Verified_Credit_Score__c;
				      updatem = TRUE;
				}


				if(m.Date_information_collected__c  != date.newinstance(i.CreatedDate.year(), i.CreatedDate.month(), i.CreatedDate.day())){
				     m.Date_information_collected__c  = date.newinstance(i.CreatedDate.year(), i.CreatedDate.month(), i.CreatedDate.day());
				      updatem = TRUE;
				}


				if(m.Disability__c  != i.Disability__c){
				     m.Disability__c  = i.Disability__c;
				      updatem = TRUE;
				}


				if(m.Employment_Income__c  != i.Formal_and_Informal_Employment__c){
				     m.Employment_Income__c  = i.Formal_and_Informal_Employment__c;
				      updatem = TRUE;
				}


				if(m.Entertainment__c  != i.Entertainment__c){
				     m.Entertainment__c  = i.Entertainment__c;
				      updatem = TRUE;
				}


				if(m.Family_Friends_Loan_Payment__c  != i.Friends_Family_Loan__c){
				     m.Family_Friends_Loan_Payment__c  = i.Friends_Family_Loan__c;
				      updatem = TRUE;
				}


				if(m.Food2__c  != i.Food__c){
				     m.Food2__c  = i.Food__c;
				      updatem = TRUE;
				}


				if(m.Health_Insurance__c  != i.Health_Insurance__c){
				     m.Health_Insurance__c  = i.Health_Insurance__c;
				      updatem = TRUE;
				}


				if(m.Housing__c  != i.Housing__c){
				     m.Housing__c  = i.Housing__c;
				      updatem = TRUE;
				}


				if(m.Intake__c  != TRUE){
				     m.Intake__c  = TRUE;
				      updatem = TRUE;
				}


				if(m.Liens__c  != i.Total_Tax_Liens_Garnishments__c){
				     m.Liens__c  = i.Total_Tax_Liens_Garnishments__c;
				      updatem = TRUE;
				}


				if(m.Monthly_Payment_Other_Debt__c  != i.Other_Loans_Payment__c){
				     m.Monthly_Payment_Other_Debt__c  = i.Other_Loans_Payment__c;
				      updatem = TRUE;
				}


				if(m.Monthly_Payment_Real_Estate_Loan__c  != i.Real_Estate_Loans_Payment__c){
				     m.Monthly_Payment_Real_Estate_Loan__c  = i.Real_Estate_Loans_Payment__c;
				      updatem = TRUE;
				}


				if(m.Monthly_Payment_Revolving_Loans__c  != i.Revolving_Loans_Payments__c){
				     m.Monthly_Payment_Revolving_Loans__c  = i.Revolving_Loans_Payments__c;
				      updatem = TRUE;
				}


				if(m.Monthly_Payment_Secured_Installment_Loan__c  != i.Secured_Installment_Loans_Payment__c){
				     m.Monthly_Payment_Secured_Installment_Loan__c  = i.Secured_Installment_Loans_Payment__c;
				      updatem = TRUE;
				}


				if(m.Monthly_Payment_Student_Loans__c  != i.Student_Loans_Payment__c){
				     m.Monthly_Payment_Student_Loans__c  = i.Student_Loans_Payment__c;
				      updatem = TRUE;
				}


				if(m.Monthly_Payment_Unsecured_Installmt_Loan__c  != i.Unsecured_Installment_Loans_Payment__c){
				     m.Monthly_Payment_Unsecured_Installmt_Loan__c  = i.Unsecured_Installment_Loans_Payment__c;
				      updatem = TRUE;
				}


				if(m.No_Credit_Score_Available__c  != i.No_Credit_Score_Available__c){
				     m.No_Credit_Score_Available__c  = i.No_Credit_Score_Available__c;
				      updatem = TRUE;
				}


				if(m.Other_Income__c  != i.Other_Income__c){
				     m.Other_Income__c  = i.Other_Income__c;
				      updatem = TRUE;
				}


				if(m.Other_Monthly_Expense__c  != i.Other_Monthly_Expense__c){
				     m.Other_Monthly_Expense__c  = i.Other_Monthly_Expense__c;
				      updatem = TRUE;
				}


				if(m.Other_Monthly_Expenses_Explanation__c  != i.Other_Monthly_Expense_Explanation__c){
				     m.Other_Monthly_Expenses_Explanation__c  = i.Other_Monthly_Expense_Explanation__c;
				      updatem = TRUE;
				}


				if(m.Past_Due_Auto_Loans__c  != i.Total_Auto_Loans__c){
				     m.Past_Due_Auto_Loans__c  = i.Total_Auto_Loans__c;
				      updatem = TRUE;
				}


				if(m.Past_Due_Cell_Phone_Bills__c  != i.Total_Cell_Phone_Bills_Past_Due__c){
				     m.Past_Due_Cell_Phone_Bills__c  = i.Total_Cell_Phone_Bills_Past_Due__c;
				      updatem = TRUE;
				}


				if(m.Past_Due_Family_Friends_Loan__c  != i.Total_Friends_Family_Loans__c){
				     m.Past_Due_Family_Friends_Loan__c  = i.Total_Friends_Family_Loans__c;
				      updatem = TRUE;
				}


				if(m.Past_Due_Household_Bills__c  != i.Total_Household_Bills_Past_Due__c){
				     m.Past_Due_Household_Bills__c  = i.Total_Household_Bills_Past_Due__c;
				      updatem = TRUE;
				}


				if(m.Past_Due_Medical_Bill__c  != i.Total_Medical_Bills_Past_Due__c){
				     m.Past_Due_Medical_Bill__c  = i.Total_Medical_Bills_Past_Due__c;
				      updatem = TRUE;
				}


				if(m.Past_Due_Other_Bills__c  != i.Total_Other_Bills_Past_Due__c){
				     m.Past_Due_Other_Bills__c  = i.Total_Other_Bills_Past_Due__c;
				      updatem = TRUE;
				}


				if(m.Past_Due_Other_Loans__c  != i.Total_Other_Loans__c){
				     m.Past_Due_Other_Loans__c  = i.Total_Other_Loans__c;
				      updatem = TRUE;
				}


				if(m.Past_Due_Predatory_Loans__c  != i.Total_Predatory_Loans__c){
				     m.Past_Due_Predatory_Loans__c  = i.Total_Predatory_Loans__c;
				      updatem = TRUE;
				}


				if(m.Past_Due_Real_Estate_Loans__c  != i.Total_Real_Estate_Loans__c){
				     m.Past_Due_Real_Estate_Loans__c  = i.Total_Real_Estate_Loans__c;
				      updatem = TRUE;
				}


				if(m.Past_Due_Revolving_Loans__c  != i.Total_Revolving_Loans__c){
				     m.Past_Due_Revolving_Loans__c  = i.Total_Revolving_Loans__c;
				      updatem = TRUE;
				}


				if(m.Past_Due_Secured_Installment_Loans__c  != i.Total_Secured_Installment_Loans__c){
				     m.Past_Due_Secured_Installment_Loans__c  = i.Total_Secured_Installment_Loans__c;
				      updatem = TRUE;
				}


				if(m.Past_Due_Student_Loans__c  != i.Total_Student_Loans__c){
				     m.Past_Due_Student_Loans__c  = i.Total_Student_Loans__c;
				      updatem = TRUE;
				}


				if(m.Past_Due_Unsecured_Installment_Loans__c  != i.Total_Unsecured_Installment_Loans__c){
				     m.Past_Due_Unsecured_Installment_Loans__c  = i.Total_Unsecured_Installment_Loans__c;
				      updatem = TRUE;
				}


				if(m.Pension_Retirement_and_Investment__c  != i.Pension_Retirement_and_Investment__c){
				     m.Pension_Retirement_and_Investment__c  = i.Pension_Retirement_and_Investment__c;
				      updatem = TRUE;
				}


				if(m.Predatory_Loans_Payment__c  != i.Predatory_Loans_Payment__c){
				     m.Predatory_Loans_Payment__c  = i.Predatory_Loans_Payment__c;
				      updatem = TRUE;
				}


				if(m.SNAP__c  != i.SNAP__c){
				     m.SNAP__c  = i.SNAP__c;
				      updatem = TRUE;
				}


				if(m.Self_Employment_Income__c  != i.Self_Employment__c){
				     m.Self_Employment_Income__c  = i.Self_Employment__c;
				      updatem = TRUE;
				}


				if(m.Social_Security__c  != i.Social_Security__c){
				     m.Social_Security__c  = i.Social_Security__c;
				      updatem = TRUE;
				}


				if(m.TANF__c  != i.TANF__c){
				     m.TANF__c  = i.TANF__c;
				      updatem = TRUE;
				}


				if(m.Tax_Liens_Garnishments__c  != i.Tax_Liens_Garnishments2__c){
				     m.Tax_Liens_Garnishments__c  = i.Tax_Liens_Garnishments2__c;
				      updatem = TRUE;
				}


				if(m.Transportation__c  != i.Transportation__c){
				     m.Transportation__c  = i.Transportation__c;
				      updatem = TRUE;
				}


				if(m.Unemployment_Income__c  != i.Unemployment__c){
				     m.Unemployment_Income__c  = i.Unemployment__c;
				      updatem = TRUE;
				}


				if(m.Utilities__c  != i.Utilities_Other_Household_Expenditures__c){
				     m.Utilities__c  = i.Utilities_Other_Household_Expenditures__c;
				      updatem = TRUE;
				}


				if(m.Veteran_s_Assistance_Survivor_s_Benefits__c  != i.Veteran_s_Assistance_Survivor_s_Benefits__c){
				     m.Veteran_s_Assistance_Survivor_s_Benefits__c  = i.Veteran_s_Assistance_Survivor_s_Benefits__c;
				      updatem = TRUE;
				}


				if(m.WIC__c  != i.WIC__c){
				     m.WIC__c  = i.WIC__c;
				      updatem = TRUE;
				}


				if(m.Warrants2__c  != i.Total_Warrants__c){
				     m.Warrants2__c  = i.Total_Warrants__c;
				      updatem = TRUE;
				}


				if(m.Warrants__c  != i.Warrants2__c){
				     m.Warrants__c  = i.Warrants2__c;
				      updatem = TRUE;
				}


				if(m.Workman_s_Compensation__c  != i.Workman_s_Compensation__c){
				     m.Workman_s_Compensation__c  = i.Workman_s_Compensation__c;
				      updatem = TRUE;
				}


				if(m.Workman_s_Compensation__c!=i.Workman_s_Compensation__c){
				     m.Workman_s_Compensation__c=i.Workman_s_Compensation__c;
				      updatem = TRUE;
				}

				if(updatem == TRUE){

					mups.add(m);

				}

    		}//End for Metric__c m in metrics

    		if(!mups.isEmpty()){

				try{
					Database.UpsertResult[] sru = Database.Upsert(mups,false); //Try  to update the Metrics
				}catch(Exception eu){
					System.Debug('------------Error Updating Metrics from Intake Change------------'+eu.getMessage());
				}

    		}

    	}//End if !metrics.isEmpty()

	}//End updateMetricfromIntake

}