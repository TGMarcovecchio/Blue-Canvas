global class WSCampaignTools {

    //When a new Campaign of Type 'Show' is created Create a new FF Dimension 3 Record with the same name and associate it to the Campaign
  
    public static void createCampaignDimension3(Campaign[] lstCamps){
    
        Set<ID> campIds = new Set<Id>(); //The Set of Campaign Ids
        Map<ID, ID> campTodimension = new Map<ID, ID>(); //The Map of Campaign to Dimension 3 Ids
  
        for (Campaign camp2 : lstCamps){
            
            if(camp2.Type.contains('Show')){   //Only operate on Campaigns whose type contains 'Show'
            
            c2g__codaDimension3__c dim3 = new c2g__codaDimension3__c();
            
                dim3.Name = camp2.Name;
                dim3.c2g__ReportingCode__c = camp2.Name.trim().mid(0,23);
                dim3.Campaign__c = camp2.Id;
                
                insert dim3;
                campIds.add(camp2.Id);
                campToDimension.put(camp2.Id,dim3.Id);
                
            }
        }
        
        List<Campaign> lstCampupdates= [SELECT Id, Dimension_3__c FROM Campaign WHERE Id IN: campIds];
        
        for (Campaign camp : lstCampupdates){
        camp.Dimension_3__c = campToDimension.get(camp.Id);
        }
        
        if(!lstCampupdates.isempty()){
        update lstCampupdates;
        }
    }

      public static void changeCampaignDimension3(Campaign[] lstCamps){
    
        Set<ID> campIds = new Set<Id>(); //The Set of Campaign Ids
        Set<ID> dimIds = new Set<Id>(); //The Set of Dimension 3 Ids

        Map<ID, String> campToName = new Map<ID, String>(); //The Map of Campaign Ids to Campaign Names
        Map<ID, ID> dimToCamp = new Map<ID, ID>(); //The Map of Dimension 3 Ids to Campaign Ids
  
        for (Campaign camp : lstCamps){
            
            if(camp.Type.contains('Show')){   //Only operate on Campaigns whose type contains 'Show'
            
            dimIds.add(camp.Dimension_3__c);
            dimToCamp.put(camp.Dimension_3__c,camp.Id);
            campToName.put(camp.Id,camp.Name);
                
            }
        }
        
        List<c2g__codaDimension3__c> lstDim3Updates= [SELECT Id, Name FROM c2g__codaDimension3__c WHERE Id IN: dimIds];
        
        for (c2g__codaDimension3__c dim3 : lstDim3Updates){
        dim3.Name = campToName.get(dimToCamp.get(dim3.Id));
        }
        
        if(!lstDim3Updates.isempty()){
        update lstDim3Updates;
        }
    }
 
}