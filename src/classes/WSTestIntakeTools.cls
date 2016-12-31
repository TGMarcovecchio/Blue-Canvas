/**********************************************************************
* Name:     WSTestIntakeTools
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     28 Dec 2016
* ======================================================
* ======================================================
* Purpose:                                                            
* Test Class for WSIntakeTools and related trigger
*                                                            
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       28 Dec 2016     TGM         Initial Development
***********************************************************************/
@isTest
private class WSTestIntakeTools {

    static testMethod void beforeInsertIntake_Test(){

    		/*
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
			}*/

	}

	static testMethod void createContactFromIntake_Test(){

		/*
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
				*/

	}

	static testMethod void createCasefromIntake_Test(){

		/*
		c.ContactId = i.Contact__c;
				c.AccountId = i.Account__c;
				c.Intake__c = i.id;
				c.Origin = 'Intake';
				c.Status = 'New';
				c.Priority = 'Medium';

		*/

	}

	static testMethod void createMetricFromIntake_Test(){

		/*
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
			*/

	}

	static testMethod void createEPfromIntake_Test(){

		/*
		npsp__Engagement_Plan__c ep = new npsp__Engagement_Plan__c(); //Create a new case

		ep.npsp__Engagement_Plan_Template__c = i.Engagement_Plan_Template__c;

		if(i.Engagement__c != NULL){

			ep.npsp__Case__c = i.Engagement__c;
			eps.add(ep);

		}else if(i.Contact__c != NULL){

			ep.npsp__Contact__c = i.Contact__c;
			eps.add(ep);

		}
		*/

	}

	static testMethod void updateMetricfromIntake_Test(){

		/*
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
				*/

	}
}