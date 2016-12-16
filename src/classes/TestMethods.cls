/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestMethods {

    static testMethod void UpdateSummaryFieldsOnProgram_Test() {
        
        Program__c pro1 = new Program__c(Name= 'Program_Test');
        insert pro1;
        
        Opportunity op1 = new Opportunity(Name='Opportunity_Test_1', Amount = 10.0, Income_Type__c = 'Enrollment', Program__c=pro1.Id, StageName='Fully Paid', CloseDate=Date.today());
		insert op1;
        // Don = 0
        // Enroll = 10       
        // Nro = 1
              
        System.assertEquals(10, [Select Total_Income_from_Participants__c, Total_Income_from_Donations__c From Program__c where Id =: pro1.Id].Total_Income_from_Participants__c);        
        System.assertEquals(1, [Select Total_Income_from_Participants__c, Total_Income_from_Donations__c, Number_of_Participants_Paid__c From Program__c where Id =: pro1.Id].Number_of_Participants_Paid__c);
        
        Opportunity op2;
        
        try{
	        op2 = new Opportunity(Name='Opportunity_Test_2', Amount = 15.0,Income_Type__c = 'Enrollment', StageName= 'Prospecting', CloseDate=Date.today());
			insert op2;
        }catch(Exception e){
        	//
        }
        
        op2 = new Opportunity(Name='Opportunity_Test_2', Amount = 15.0,Income_Type__c = 'Enrollment', StageName= 'Prospecting', Program__c = pro1.Id, CloseDate=Date.today());
        insert op2;
        
        // Don = 0
        // Enroll = 10
        // Nro = 1
        
        //op2.Program__c = pro1.Id;
        //update op2;
        
        op2.StageName = 'Fully Paid';
        update op2;
        
        // Don = 0
        // Enroll = 25
        // Nro = 2
        
        System.assertEquals(0, [Select Total_Income_from_Participants__c, Total_Income_from_Donations__c From Program__c where Id =: pro1.Id].Total_Income_from_Donations__c);
        System.assertEquals(25, [Select Total_Income_from_Participants__c, Total_Income_from_Donations__c From Program__c where Id =: pro1.Id].Total_Income_from_Participants__c);
        
        System.assertEquals(2, [Select Total_Income_from_Participants__c, Total_Income_from_Donations__c, Number_of_Participants_Paid__c From Program__c where Id =: pro1.Id].Number_of_Participants_Paid__c);
        op2.Income_Type__c = 'Donation';
        update op2; 
        
        
        // Don = 15
        // Enroll = 10
        // Nro = 1
                
        System.assertEquals(1, [Select Total_Income_from_Participants__c, Total_Income_from_Donations__c, Number_of_Participants_Paid__c From Program__c where Id =: pro1.Id].Number_of_Participants_Paid__c);
        System.assertEquals(15, [Select Total_Income_from_Participants__c, Total_Income_from_Donations__c From Program__c where Id =: pro1.Id].Total_Income_from_Donations__c);
        System.assertEquals(10, [Select Total_Income_from_Participants__c, Total_Income_from_Donations__c From Program__c where Id =: pro1.Id].Total_Income_from_Participants__c);
        
        
        Opportunity op3 = new Opportunity(Name='Opportunity_Test_3', Amount = 20,Income_Type__c = 'Donation', StageName='Fully Paid', Program__c=pro1.Id, CloseDate=Date.today());
		insert op3;

		// Don = 35
        // Enroll = 10
        // Nro = 1
			        
        System.assertEquals(35, [Select Total_Income_from_Participants__c, Total_Income_from_Donations__c, Number_of_Participants_Paid__c  From Program__c where Id =: pro1.Id].Total_Income_from_Donations__c);
        
        op1.StageName = 'Fully Paid';
        update op1;
        
        op1.StageName = 'Prospecting';
        update op1;
        
        delete op1;
        
        // Don = 35
        // Enroll = 0
        // Nro = 0
        System.assertEquals(0, [Select Total_Income_from_Participants__c, Total_Income_from_Donations__c, Number_of_Participants_Paid__c From Program__c where Id =: pro1.Id].Total_Income_from_Participants__c);
        System.assertEquals(0, [Select Number_of_Participants_Paid__c From Program__c where Id =: pro1.Id].Number_of_Participants_Paid__c);
        
        op2.Amount = 10;
        update op2;
        
        
        // Don = 35
        // Enroll = 0
        // Nro = 0
        System.assertEquals(30, [Select Total_Income_from_Participants__c, Total_Income_from_Donations__c, Number_of_Participants_Paid__c From Program__c where Id =: pro1.Id].Total_Income_from_Donations__c);
        
               
        Opportunity op4 = new Opportunity(Name='Opportunity_Test_4', Amount = 10.0, Income_Type__c = 'Donation', Program__c=pro1.Id, StageName='Fully Paid', CloseDate=Date.today());
		insert op4;
        
        // Don = 45
        // Enroll = 
        // Nro = 0
        System.assertEquals(0, [Select Total_Income_from_Participants__c, Total_Income_from_Donations__c, Number_of_Participants_Paid__c From Program__c where Id =: pro1.Id].Total_Income_from_Participants__c);
        System.assertEquals(0, [Select Number_of_Participants_Paid__c From Program__c where Id =: pro1.Id].Number_of_Participants_Paid__c);
                
        op4.Income_Type__c = 'Enrollment';
        update op4;       
        
        // Don = 35
        // Enroll = 10
        // Nro = 1
        System.assertEquals(10, [Select Total_Income_from_Participants__c, Total_Income_from_Donations__c, Number_of_Participants_Paid__c From Program__c where Id =: pro1.Id].Total_Income_from_Participants__c);
        System.assertEquals(1, [Select Number_of_Participants_Paid__c From Program__c where Id =: pro1.Id].Number_of_Participants_Paid__c);
        
        List<Opportunity> listop = new List<Opportunity>();
        
        op4.Amount = 5;
        listop.add(op2);
        listop.add(op4);
         
        update listop;  
          
        System.assertEquals(30, [Select Total_Income_from_Participants__c, Total_Income_from_Donations__c, Number_of_Participants_Paid__c From Program__c where Id =: pro1.Id].Total_Income_from_Donations__c);  
        System.assertEquals(5, [Select Total_Income_from_Participants__c, Total_Income_from_Donations__c, Number_of_Participants_Paid__c From Program__c where Id =: pro1.Id].Total_Income_from_Participants__c);
        System.assertEquals(1, [Select Number_of_Participants_Paid__c From Program__c where Id =: pro1.Id].Number_of_Participants_Paid__c);  
        
        listop.clear();
        listop.add(op3);
        listop.add(op2);
        listop.add(op4);
        
        delete listop;
    }
    
    static testMethod void UpdateTotalPaymentsOnBudget_Test() {
    
    	Program__c pro1 = new Program__c(Name= 'Program_Test');
        insert pro1;
    
    	Budget__c bud1 = new Budget__c(Name = 'Budget_Test', Program_Name__c = pro1.Id);
    	insert bud1;
    	
    	List<Payments__c> listpay = new List<Payments__c>();
    	    	
    	Payments__c pay1 = new Payments__c(Budget__c = bud1.Id, Name = 'Payments_Test');
    	Payments__c pay2 = new Payments__c(Budget__c = bud1.Id, Name = 'Payments_Test', Payment_Amount__c = 10);
    	listpay.add(pay1);
    	listpay.add(pay2);
		
		insert listpay;    
		
		System.assertEquals(10, [Select Total_Payments__c From Budget__c where Id =: bud1.Id].Total_Payments__c);
		
		pay1.Payment_Amount__c = 10;
		update pay1;
		
		System.assertEquals(20, [Select Total_Payments__c From Budget__c where Id =: bud1.Id].Total_Payments__c);
		delete pay1;
		
		System.assertEquals(10, [Select Total_Payments__c From Budget__c where Id =: bud1.Id].Total_Payments__c);		
    }
    
    
    static testMethod void PopulateMeetingFields_Test(){
    
    	Program__c pro1 = new Program__c(Name= 'Program1_Test');
        insert pro1;
        
        Meeting__c meeting1 = new Meeting__c(Name = 'Meeting1_Test', Program__c = pro1.Id, Date_Time__c = System.now().addHours(-15));
        insert meeting1;
    	
    	System.assertEquals([Select Name From Meeting__c Where Id = :meeting1.Id].Name, pro1.Name + ' - ' + meeting1.Name);    	
    	
    	meeting1.Name = 'Meeting_Test';
    	update meeting1;
    	
    	System.assertEquals([Select Name From Meeting__c Where Id = :meeting1.Id].Name, pro1.Name + ' - ' + meeting1.Name);
    }
}