/**********************************************************************
* Name:     TestCampaignTrigger
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     19 Dec 2016
* ======================================================
* ======================================================
* Purpose:                                                            
* Test class related to CampaignTrigger which uses CampaignTriggerHandler
*                                                            
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       19 Dec 2016     TGM         Initial Development
***********************************************************************/

@isTest(SeeAllData=true)

class TestCampaignTrigger {
	
	@IsTest static void UnitTestCampaignTrigger () {

		Campaign c = new Campaign(
			Name = 'Test',
			Type = 'Other',
			StartDate = date.Today(),
			BudgetedCost = 0,
			Status = 'In Progress'
			);

		insert c;

		checkRecursive.resetAll();

		c.Name = 'Test Update';
		update c;

		checkRecursive.resetAll();

		delete c;

		checkRecursive.resetAll();

		undelete c;


	}//End UnitTestCampaignTrigger

}//End WSTestCampaignTrigger