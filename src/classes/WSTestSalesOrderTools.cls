@IsTest(SeeAllData=true)

class WSTestSalesOrderTools{

	//Unit test for Set Sales Order Contact from Primary Opportunity Contact Role
	
    @IsTest static void UnitTestcsetSOContact () {
    
    List<PBSI__PBSI_Sales_Order__c> lstSOs = new List<PBSI__PBSI_Sales_Order__c>(); //List of Sales Orders
    
    // Grab your Custom Setting values
    WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
    Boolean  TriggerOff = settings.Turn_Off_Opportunity_Trigger__c;
    Boolean  AllTriggersOff = settings.Turn_Off_All_APEX_Triggers__c;

	//Only do something if TriggerOff is False
    if(TriggerOff == FALSE && AllTriggersOff == FALSE){
    
    //Generate a list of suitable PAYs
    try{
            for (PBSI__PBSI_Sales_Order__c soget :
            [SELECT Id, Amount_Due_on_SO__c, Ascent2FF__Company__c, Ascent2FF__Customer_Parent__c, Ascent2FF__Last_Shipment_Cost_From_Vendor__c, Ascent2FF__Last_Shipment_Cost_already_included__c, Ascent2FF__Misc_Charges_Already_Included__c, Ascent2FF__Proforma_Issued__c, ConnectionReceivedId, ConnectionSentId, CreatedById, CreatedDate, Discount_Reason__c, IsDeleted, LastActivityDate, LastModifiedById, LastModifiedDate, LastReferencedDate, LastViewedDate, Mattress_Tracking_Number__c, Name, Opportunity_Lead_Source__c, OwnerId, PBSI__Actual_Shipping_Cost__c, PBSI__Address_Tracker__c, PBSI__BOL_Description__c, PBSI__BillingCity__c, PBSI__BillingCompany__c, PBSI__BillingCountry__c, PBSI__BillingState__c, PBSI__BillingStreet__c, PBSI__BillingZip__c, PBSI__Cleared_Date__c, PBSI__Comments__c, PBSI__Contact_Email__c, PBSI__Contact__c, PBSI__Created_From__c, PBSI__Customer_Purchase_Order__c, PBSI__Customer__c, PBSI__Days_Between_Scheduled_Shipments__c, PBSI__Delivery_ATTN_to_Phone__c, PBSI__Delivery_ATTN_to__c, PBSI__Delivery_Address_Type__c, PBSI__Delivery_Address_line2__c, PBSI__Delivery_Address_line_3__c, PBSI__Delivery_City__c, PBSI__Delivery_Company__c, PBSI__Delivery_Country__c, PBSI__Delivery_County__c, PBSI__Delivery_Postal_Code__c, PBSI__Delivery_State__c, PBSI__Delivery_Street__c, PBSI__Delivery_Streetnew__c, PBSI__Disable_Sales_Trade_Agreement__c, PBSI__Discount_Amount__c, PBSI__Due_Date__c, PBSI__External_ID__c, PBSI__Final_Order_Total4__c, PBSI__Final_Order_Total__c, PBSI__Final_Tax_Total__c, PBSI__Fixed_Cost_Shipping__c, PBSI__From_Location__c, PBSI__From_Quote__c, PBSI__From_RMA__c, PBSI__Gross_Weight__c, PBSI__Has_Drop_Ship_Lines__c, PBSI__Invoice_Date__c, PBSI__Invoiced_DIscount_Amount__c, PBSI__Lead_Source__c, PBSI__Misc_Charges__c, PBSI__Mode_of_Delivery__c, PBSI__Movement_Journal__c, PBSI__Net_Order_Total_4__c, PBSI__Net_Order_Total__c, PBSI__Number_Of_Lines__c, PBSI__Number_Of_Pending_Shipping_Lines__c, PBSI__Number_of_Shipments__c, PBSI__Opportunity__c, PBSI__Order_Date__c, PBSI__Order_Discount__c, PBSI__Order_Subtotal4__c, PBSI__Order_Total__c, PBSI__Org_Exchange_Rate__c, PBSI__Pack_Slip_Terms__c, PBSI__Packing_Category__c, PBSI__Packing_Date__c, PBSI__Picker__c, PBSI__PrecisioID__c, PBSI__Reason_for_Refund__c, PBSI__Refund_Amount__c, PBSI__Remaining_Shipments__c, PBSI__Sales_Tax__c, PBSI__Schedule_End_Date__c, PBSI__Schedule_Start_Date__c, PBSI__Ship_Location__c, PBSI__Shipping_Amount__c, PBSI__Shipping_Cost__c, PBSI__Shipping_Discount__c, PBSI__Shipping_Instructions__c, PBSI__Stage__c, PBSI__Staging_Location__c, PBSI__Staging_Movement_Journal__c, PBSI__Status__c, PBSI__Tax_Code__c, PBSI__Tax_on_Misc_Charges__c, PBSI__Tax_on_Shipping__c, PBSI__Terms_Conditions__c, PBSI__Total_Quant_To_Ship__c, PBSI__Total_Tax__c, PBSI__Tracking_Code__c, PBSI__Trade_Agreement__c, PBSI__Type__c, PBSI__User__c, PBSI__Weekday__c, PBSI__alt_Order_Total__c, PBSI__hasMJ__c, Primary_Campaign__c, Product_Delivered_Date__c, Shipping_Notes__c, Status_FFA_Tax_Text__c, Store_Accessories_needing_to_deliver__c, SystemModstamp, Test_Tax_Total__c, Total_Amount_Discounted__c, Total_Payment__c, toggle__c
			FROM PBSI__PBSI_Sales_Order__c
			WHERE PBSI__Opportunity__c != NULL
            LIMIT 1]){
			
			lstSOs.add(soget);
			
			//Create A New Sales Order from the Found Sales Order

			PBSI__PBSI_Sales_Order__c son = new PBSI__PBSI_Sales_Order__c();
        
			son.PBSI__Order_Date__c = soget.PBSI__Order_Date__c;
			son.PBSI__Customer__c = soget.PBSI__Customer__c;
			son.PBSI__Opportunity__c = soget.PBSI__Opportunity__c;
			son.PBSI__Lead_Source__c = soget.PBSI__Lead_Source__c;

			insert son;
            
            }

            //Make sure there the list of PAYIDs is not empty 
            if (!lstSOs.isEmpty()) {
                
                //Pass the list to the class.method
                WSSalesOrderTools.setSOContact(lstSOs);

            }
			
			
        }
        
        //check for exceptions
        catch (QueryException e) {
            system.debug(e);
        }
        }
    }
}