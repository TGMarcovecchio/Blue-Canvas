public class WSIntakeTools {

	public static void createMetricFromIntake(List<Intake__c> ins) {

		for(Intake__c i : ins){

		//Intake__c i = (Intake__c)so;

		Metrics__c m = new Metrics__c();

		m.Contact__c  = i.Id;

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

		try{
			insert m;
			String mid;
			mid = m.id;
		}catch(Exception e){
			System.Debug('------------Error Inserting Metric from Intake------------'+e.getMessage());
		}

	}
	
	}
}