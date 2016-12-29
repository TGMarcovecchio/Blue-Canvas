public with sharing class WSTaskTools {

	public static void nullTaskDates(List<Task> thetasks){

		for(Task t : thetasks){

			if(t.ActivityDate != NULL && (t.npsp__Engagement_Plan__c != NULL || t.npsp__Engagement_Plan_Task__c != NULL)){

				t.ActivityDate = NULL;
			}
		}
	}

}