@IsTest(SeeAllData=true)

class WSTestCampaignTools{

  //Unit test for createCampaignDimension3
  
    @IsTest static void UnitTestccreateCampaignDimension3 () 
    {
    
    // Grab your Custom Setting values
    WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
    Boolean  TriggerOff = settings.Turn_Off_Campaign_Trigger__c;
    Boolean  AllTriggersOff = settings.Turn_Off_All_APEX_Triggers__c;

    //Only do something if TriggerOff is False
    if(TriggerOff == FALSE && AllTriggersOff == FALSE){
    
    List<Campaign> lstCamps = new List<Campaign>();    //A list of campaigns to create
    List<Campaign> lstCampsu = new List<Campaign>(); //A list of campaigns to update
    Date myDate = Date.today();
    
        //Create some campaigns
        
        try{
            
            Campaign camp1 = new Campaign();
            Campaign camp2 = new Campaign();
            Campaign camp3 = new Campaign();
            Campaign camp4 = new Campaign();
            
            
            camp1.name = '1UnitTestCamp1';
            camp1.Type = 'Consumer Show';
            camp1.StartDate = myDate;
            camp1.Status = 'Planned';
            insert camp1;
            lstCamps.add(camp1);
            
            camp2.name = '2UnitTestCamp2';
            camp2.Type = 'Consumer Show';
            camp2.StartDate = myDate;
            camp2.Status = 'Planned';
            insert camp2;
            lstCamps.add(camp2);
            
            camp3.name = '3UnitTestCamp3';
            camp3.Type = 'Email';
            camp3.StartDate = myDate;
            camp3.Status = 'Planned';
            insert camp3;
            lstCamps.add(camp3);

            camp4.name = '4UnitTestCamp4';
            camp4.Type = 'Email';
            camp4.StartDate =  myDate;
            camp4.Status = 'Planned';
            camp4.Dimension_3__c = NULL;

            for(Campaign campu : lstCamps){

                if(campu.Name != '4UnitTestCamp4'){
                    
                    campu.Type = 'Medical Show';
                    campu.Name = campu.Name + 'z';
                }

                else

                campu.Type = 'Medical Show';

                lstCampsu.add(campu);

            }

            if(!lstCampsu.isempty()){
                update lstCampsu;
            }

        }

        //check for exceptions
        catch (QueryException e) {
            system.debug(e);
        }


        
        }
    }
}