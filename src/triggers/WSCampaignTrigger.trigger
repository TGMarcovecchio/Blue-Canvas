trigger WSCampaignTrigger on Campaign (after insert, before update, after update) {

// Grab your Custom Setting values
    WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();
    Boolean  TriggerOff = settings.Turn_Off_Campaign_Trigger__c;
    Boolean  AllTriggersOff = settings.Turn_Off_All_APEX_Triggers__c;

//Only do something if TriggerOff is False
    if(TriggerOff == FALSE && AllTriggersOff == FALSE){
        
        if(Trigger.IsInsert){
        
            List<Campaign> lstCampsi = new List<Campaign>();
            
            for (Campaign camp : Trigger.new){
            //Check if the Campaign Type contains 'Show' and if Dimension 3 on Campaign is NULL. If it meets these conditions then send it to WSCampaignTools.createCampaignDimension3
        
                if (camp.Type.contains('Show')){
                        lstCampsi.add(camp);
                }

            }
                
            if (!lstCampsi.isEmpty()) WSCampaignTools.createCampaignDimension3(lstCampsi);
        }

        else if (Trigger.IsUpdate){

            if (Trigger.IsBefore){

                List<Campaign> lstCampsu = new List<Campaign>();
            
                for (Campaign campu : Trigger.new){

                    Campaign oldCamp = Trigger.oldMap.get(campu.Id);
            
                    if (oldCamp.Name == campu.Name && oldCamp.Type != campu.Type && oldCamp.Dimension_3__c == null && campu.Dimension_3__c == null && campu.Type.contains('Show'))
                            lstCampsu.add(campu);
                }

                if (!lstCampsu.isEmpty()) WSCampaignTools.createCampaignDimension3(lstCampsu);

                }

            else if (Trigger.IsAfter){

                List<Campaign> lstCampsnc = new List<Campaign>();

                for (Campaign campnc : Trigger.new){

                    Campaign oldCampnc = Trigger.oldMap.get(campnc.Id);

                    if (oldCampnc.Name != campnc.Name && oldCampnc.Dimension_3__c != null) lstCampsnc.add(campnc);

                }
                    
                if (!lstCampsnc.isEmpty()) WSCampaignTools.changeCampaignDimension3(lstCampsnc);

            }
        }
    }
}