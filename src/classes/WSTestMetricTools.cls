/**********************************************************************
* Name:     WSTestMetricTools
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     28 Dec 2016
* ======================================================
* ======================================================
* Purpose:                                                            
* Test Class for WSMetricTools and related trigger
*                                                            
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       28 Dec 2016     TGM         Initial Development
***********************************************************************/
@isTest
private class WSTestMetricTools {

    static testMethod void setmetricchange_Test() {

    Double dbl = 10.5;
    Integer ing = 10;
    Integer cs = 400;
    Integer rf = 2;

    Account ac = new Account();
    Contact ct = new Contact();
    Metrics__c m = new Metrics__c();
    Metrics__c m2 = new Metrics__c();

    ac.Name = 'Test Account';
    insert ac;
    String acid = ac.Id;

    ct.FirstName = 'FirstTest';
    ct.LastName = 'LastTest';
    ct.AccountId = acid;
    insert ct;
    String ctid = ct.id;

    m.Contact__c = ct.id;
    m.Name = 'Test Metric 1';
    m.Date_Information_collected__c = date.Today();
    m.Client_Testimonial__c = 'Testimonial Text';

	m.Child_Support_and_or_Alimony__c = dbl;
	m.Disability__c = dbl;
	m.Employment_Income__c = dbl;
	m.Other_Income__c = dbl;
	m.Pension_Retirement_and_Investment__c = dbl;
	m.Self_Employment_Income__c = dbl;
	m.SNAP__c = dbl;
	m.Social_Security__c = dbl;
	m.TANF__c = dbl;
	m.Total_emergency_savings__c = dbl;
	m.Unemployment_Income__c = dbl;
	m.Veteran_s_Assistance_Survivor_s_Benefits__c = dbl;
	m.WIC__c = dbl;
	m.Workman_s_Compensation__c = dbl;
	m.Alimony_Child_Support_Actual__c = ing;
	m.Alimony_Child_Support_Budgeted__c = ing;
	m.Cable_Actual__c = ing;
	m.Cable_Budgeted__c = ing;
	m.Car_Insurance_Actual__c = ing;
	m.Car_Insurance_Budgeted__c = ing;
	m.Car_Payment_s_Actual__c = ing;
	m.Car_Payment_s_Budgeted__c = ing;
	m.Charitable_Actual__c = ing;
	m.Charitable_Budgeted__c = ing;
	m.Child_Care_Actual__c = ing;
	m.Child_Care_Budgeted__c = ing;
	m.Clothing_Actual__c = ing;
	m.Clothing_Budgeted__c = ing;
	m.College_Actual__c = ing;
	m.College_Budgeted__c = ing;
	m.Contribution_to_College_Savings__c = ing;
	m.Contribution_to_Emergency__c = ing;
	m.Contribution_to_General__c = ing;
	m.Contribution_to_Holiday_Vacation__c = ing;
	m.Contribution_to_IDA__c = ing;
	m.Contribution_to_IRA__c = ing;
	m.Contributions_to_Auto_Loans__c = ing;
	m.Contributions_to_Cell_Phone_Bills__c = ing;
	m.Contributions_to_Family_Friends_Loans__c = ing;
	m.Contributions_to_Household_Bills__c = ing;
	m.Contributions_to_Medical_Bills__c = ing;
	m.Contributions_to_Other_Bills__c = ing;
	m.Contributions_to_Other_Loans__c = ing;
	m.Contributions_to_Predatory_Loans__c = ing;
	m.Contributions_to_Real_Estate_Loans__c = ing;
	m.Contributions_to_Revolving_Loans__c = ing;
	m.Contributions_to_Sec_Installment_Loans__c = ing;
	m.Contributions_to_Student_Loans__c = ing;
	m.Contributions_to_Unse_Installment_Loan__c = ing;
	m.Eating_Out_Actual__c = ing;
	m.Eating_Out_Budgeted__c = ing;
	m.Electricity_Gas_Actual__c = ing;
	m.Electricity_Gas_Budgeted__c = ing;
	m.Emergency_Actual__c = ing;
	m.Emergency_Budgeted__c = ing;
	m.Entertainment_Actual__c = ing;
	m.Entertainment_Budgeted__c = ing;
	m.Food_and_Grocery_Actual__c = ing;
	m.Food_and_Grocery_Budgeted__c = ing;
	m.Friends_Family_Loan_s_Actual__c = ing;
	m.Friends_Family_Loan_s_Budgeted__c = ing;
	m.Gas_Actual__c = ing;
	m.Gas_Budgeted__c = ing;
	m.General_Actual__c = ing;
	m.General_Budgeted__c = ing;
	m.Gifts_Actual__c = ing;
	m.Gifts_Budgeted__c = ing;
	m.Health_Insurance_Actual__c = ing;
	m.Health_Insurance_Budgeted__c = ing;
	m.Homeowners_Insurance_Actual__c = ing;
	m.Homeowners_Insurance_Budgeted__c = ing;
	m.IDA_Actual__c = ing;
	m.IDA_Budgeted__c = ing;
	m.Internet_Actual__c = ing;
	m.Internet_Budgeted__c = ing;
	m.Life_Insurance_Actual__c = ing;
	m.Life_Insurance_Budgeted__c = ing;
	m.Maintenance_Actual__c = ing;
	m.Maintenance_and_Repair_Actual__c = ing;
	m.Maintenance_and_Repair_Budgeted__c = ing;
	m.Maintenance_Budgeted__c = ing;
	m.Medical_Dental_Actual__c = ing;
	m.Medical_Dental_Budgeted__c = ing;
	m.Mortgage_Actual__c = ing;
	m.Mortgage_Budgeted__c = ing;
	m.Other_Auto_Expenses_Actual__c = ing;
	m.Other_Auto_Expenses_Budgeted__c = ing;
	m.Other_Debt_s_Actual__c = ing;
	m.Other_Debt_s_Budgeted__c = ing;
	m.Other_Family_Expenses_Actual__c = ing;
	m.Other_Family_Expenses_Budgeted__c = ing;
	m.Other_Giving_Actual__c = ing;
	m.Other_Giving_Budgeted__c = ing;
	m.Other_Housing_Expenses_Actual__c = ing;
	m.Other_Housing_Expenses_Budgeted__c = ing;
	m.Other_Insurance_s_Actual__c = ing;
	m.Other_Insurance_s_Budgeted__c = ing;
	m.Other_Leisure_Expenses_Actual__c = ing;
	m.Other_Leisure_Expenses_Budgeted__c = ing;
	m.Other_Savings_Actual__c = ing;
	m.Other_Savings_Budgeted__c = ing;
	m.Other_Taxes_Actual__c = ing;
	m.Other_Taxes_Budgeted__c = ing;
	m.Past_Due_Auto_Loans__c = ing;
	m.Past_Due_Cell_Phone_Bills__c = ing;
	m.Past_Due_Family_Friends_Loan__c = ing;
	m.Past_Due_Household_Bills__c = ing;
	m.Past_Due_Medical_Bill__c = ing;
	m.Past_Due_Other_Bills__c = ing;
	m.Past_Due_Other_Loans__c = ing;
	m.Past_Due_Predatory_Loans__c = ing;
	m.Past_Due_Real_Estate_Loans__c = ing;
	m.Past_Due_Revolving_Loans__c = ing;
	m.Past_Due_Secured_Installment_Loans__c = ing;
	m.Past_Due_Student_Loans__c = ing;
	m.Past_Due_Unsecured_Installment_Loans__c = ing;
	m.Phone_Actual__c = ing;
	m.Phone_Budgeted__c = ing;
	m.Predatory_Loan_s_Actual__c = ing;
	m.Predatory_Loan_s_Budgeted__c = ing;
	m.Property_Taxes_Actual__c = ing;
	m.Property_Taxes_Budgeted__c = ing;
	m.Rent_or_Mortgage_Actual__c = ing;
	m.Rent_or_Mortgage_Budgeted__c = ing;
	m.Retirement_Actual__c = ing;
	m.Retirement_Budgeted__c = ing;
	m.Student_Loan_s_Actual__c = ing;
	m.Student_Loan_s_Budgeted__c = ing;
	m.Tax_Liens_Garnishments__c = ing;
	m.Tax_Liens_Garnishments_Actual__c = ing;
	m.Tax_Liens_Garnishments_Budgeted__c = ing;
	m.Vacation_Actual__c = ing;
	m.Vacation_Budgeted__c = ing;
	m.Warrants2__c = ing;
	m.Water_Trash_Actual__c = ing;
	m.Water_Trash_Budgeted__c = ing;
	m.Number_of_Referrals_Made__c = rf;
	m.Credit_Score__c = cs;

	insert m;

	dbl = 8.5;
	ing = 9;
	cs = 600;
	rf = 3;

	m2.Contact__c = ct.id;
    m2.Name = 'Test Metric 2';
    m2.Date_Information_collected__c = date.Today()+1;
    m2.Client_Testimonial__c = 'Testimonial Text2';

	m2.Child_Support_and_or_Alimony__c = dbl;
	m2.Disability__c = dbl;
	m2.Employment_Income__c = dbl;
	m2.Other_Income__c = dbl;
	m2.Pension_Retirement_and_Investment__c = dbl;
	m2.Self_Employment_Income__c = dbl;
	m2.SNAP__c = dbl;
	m2.Social_Security__c = dbl;
	m2.TANF__c = dbl;
	m2.Total_emergency_savings__c = dbl;
	m2.Unemployment_Income__c = dbl;
	m2.Veteran_s_Assistance_Survivor_s_Benefits__c = dbl;
	m2.WIC__c = dbl;
	m2.Workman_s_Compensation__c = dbl;
	m2.Alimony_Child_Support_Actual__c = ing;
	m2.Alimony_Child_Support_Budgeted__c = ing;
	m2.Cable_Actual__c = ing;
	m2.Cable_Budgeted__c = ing;
	m2.Car_Insurance_Actual__c = ing;
	m2.Car_Insurance_Budgeted__c = ing;
	m2.Car_Payment_s_Actual__c = ing;
	m2.Car_Payment_s_Budgeted__c = ing;
	m2.Charitable_Actual__c = ing;
	m2.Charitable_Budgeted__c = ing;
	m2.Child_Care_Actual__c = ing;
	m2.Child_Care_Budgeted__c = ing;
	m2.Clothing_Actual__c = ing;
	m2.Clothing_Budgeted__c = ing;
	m2.College_Actual__c = ing;
	m2.College_Budgeted__c = ing;
	m2.Contribution_to_College_Savings__c = ing;
	m2.Contribution_to_Emergency__c = ing;
	m2.Contribution_to_General__c = ing;
	m2.Contribution_to_Holiday_Vacation__c = ing;
	m2.Contribution_to_IDA__c = ing;
	m2.Contribution_to_IRA__c = ing;
	m2.Contributions_to_Auto_Loans__c = ing;
	m2.Contributions_to_Cell_Phone_Bills__c = ing;
	m2.Contributions_to_Family_Friends_Loans__c = ing;
	m2.Contributions_to_Household_Bills__c = ing;
	m2.Contributions_to_Medical_Bills__c = ing;
	m2.Contributions_to_Other_Bills__c = ing;
	m2.Contributions_to_Other_Loans__c = ing;
	m2.Contributions_to_Predatory_Loans__c = ing;
	m2.Contributions_to_Real_Estate_Loans__c = ing;
	m2.Contributions_to_Revolving_Loans__c = ing;
	m2.Contributions_to_Sec_Installment_Loans__c = ing;
	m2.Contributions_to_Student_Loans__c = ing;
	m2.Contributions_to_Unse_Installment_Loan__c = ing;
	m2.Eating_Out_Actual__c = ing;
	m2.Eating_Out_Budgeted__c = ing;
	m2.Electricity_Gas_Actual__c = ing;
	m2.Electricity_Gas_Budgeted__c = ing;
	m2.Emergency_Actual__c = ing;
	m2.Emergency_Budgeted__c = ing;
	m2.Entertainment_Actual__c = ing;
	m2.Entertainment_Budgeted__c = ing;
	m2.Food_and_Grocery_Actual__c = ing;
	m2.Food_and_Grocery_Budgeted__c = ing;
	m2.Friends_Family_Loan_s_Actual__c = ing;
	m2.Friends_Family_Loan_s_Budgeted__c = ing;
	m2.Gas_Actual__c = ing;
	m2.Gas_Budgeted__c = ing;
	m2.General_Actual__c = ing;
	m2.General_Budgeted__c = ing;
	m2.Gifts_Actual__c = ing;
	m2.Gifts_Budgeted__c = ing;
	m2.Health_Insurance_Actual__c = ing;
	m2.Health_Insurance_Budgeted__c = ing;
	m2.Homeowners_Insurance_Actual__c = ing;
	m2.Homeowners_Insurance_Budgeted__c = ing;
	m2.IDA_Actual__c = ing;
	m2.IDA_Budgeted__c = ing;
	m2.Internet_Actual__c = ing;
	m2.Internet_Budgeted__c = ing;
	m2.Life_Insurance_Actual__c = ing;
	m2.Life_Insurance_Budgeted__c = ing;
	m2.Maintenance_Actual__c = ing;
	m2.Maintenance_and_Repair_Actual__c = ing;
	m2.Maintenance_and_Repair_Budgeted__c = ing;
	m2.Maintenance_Budgeted__c = ing;
	m2.Medical_Dental_Actual__c = ing;
	m2.Medical_Dental_Budgeted__c = ing;
	m2.Mortgage_Actual__c = ing;
	m2.Mortgage_Budgeted__c = ing;
	m2.Other_Auto_Expenses_Actual__c = ing;
	m2.Other_Auto_Expenses_Budgeted__c = ing;
	m2.Other_Debt_s_Actual__c = ing;
	m2.Other_Debt_s_Budgeted__c = ing;
	m2.Other_Family_Expenses_Actual__c = ing;
	m2.Other_Family_Expenses_Budgeted__c = ing;
	m2.Other_Giving_Actual__c = ing;
	m2.Other_Giving_Budgeted__c = ing;
	m2.Other_Housing_Expenses_Actual__c = ing;
	m2.Other_Housing_Expenses_Budgeted__c = ing;
	m2.Other_Insurance_s_Actual__c = ing;
	m2.Other_Insurance_s_Budgeted__c = ing;
	m2.Other_Leisure_Expenses_Actual__c = ing;
	m2.Other_Leisure_Expenses_Budgeted__c = ing;
	m2.Other_Savings_Actual__c = ing;
	m2.Other_Savings_Budgeted__c = ing;
	m2.Other_Taxes_Actual__c = ing;
	m2.Other_Taxes_Budgeted__c = ing;
	m2.Past_Due_Auto_Loans__c = ing;
	m2.Past_Due_Cell_Phone_Bills__c = ing;
	m2.Past_Due_Family_Friends_Loan__c = ing;
	m2.Past_Due_Household_Bills__c = ing;
	m2.Past_Due_Medical_Bill__c = ing;
	m2.Past_Due_Other_Bills__c = ing;
	m2.Past_Due_Other_Loans__c = ing;
	m2.Past_Due_Predatory_Loans__c = ing;
	m2.Past_Due_Real_Estate_Loans__c = ing;
	m2.Past_Due_Revolving_Loans__c = ing;
	m2.Past_Due_Secured_Installment_Loans__c = ing;
	m2.Past_Due_Student_Loans__c = ing;
	m2.Past_Due_Unsecured_Installment_Loans__c = ing;
	m2.Phone_Actual__c = ing;
	m2.Phone_Budgeted__c = ing;
	m2.Predatory_Loan_s_Actual__c = ing;
	m2.Predatory_Loan_s_Budgeted__c = ing;
	m2.Property_Taxes_Actual__c = ing;
	m2.Property_Taxes_Budgeted__c = ing;
	m2.Rent_or_Mortgage_Actual__c = ing;
	m2.Rent_or_Mortgage_Budgeted__c = ing;
	m2.Retirement_Actual__c = ing;
	m2.Retirement_Budgeted__c = ing;
	m2.Student_Loan_s_Actual__c = ing;
	m2.Student_Loan_s_Budgeted__c = ing;
	m2.Tax_Liens_Garnishments__c = ing;
	m2.Tax_Liens_Garnishments_Actual__c = ing;
	m2.Tax_Liens_Garnishments_Budgeted__c = ing;
	m2.Vacation_Actual__c = ing;
	m2.Vacation_Budgeted__c = ing;
	m2.Warrants2__c = ing;
	m2.Water_Trash_Actual__c = ing;
	m2.Water_Trash_Budgeted__c = ing;
	m2.Number_of_Referrals_Made__c = rf;
	m2.Credit_Score__c = cs;

	insert m2;

    }

}