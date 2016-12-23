/**********************************************************************
* Name:     KIDSServiceLogTools
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     19 Dec 2016
* ======================================================
* ======================================================
* Purpose:                                                            
* KIDSServiceLog Tools - class with related methods for operating on KIDS Service Logs
*                                                            
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       19 Dec 2016     TGM         Initial Development
***********************************************************************/
public class KIDSServiceLogTools{

	public Map<Integer,KIDS_Service_Log_Entry__c> entrymap;
	public Map<Integer,Blob> blobmap;
	public Map<Integer,String> stringmap;

	public KIDSServiceLogTools(){
		
	}

	public static void updateParentLog(Id theid, String theMessage, String theStatus, Date thedate){

		// Create a savepoint
		Savepoint sp = Database.setSavepoint();

		//Update the parent log file after processing
		/*
				=l.Click_To_Download_Most_Recent_File__c
		=l.Date_Time_Most_Recent_File__c
		=l.Most_Recent_File_Generated_By__c
		=l.Most_Recent_File_Id__c
		=l.Most_Recent_File_Result__c
		=l.Report_Date__c
		=l.Status__c

		Attachment AttachmentObj = new Attachment(Body = csvBlob,
                              Name = 'Test-' +System.now().format('yyyy-MMM-dd-hh-mm-ss') + '.csv',
                              parentId = 'some id');

        Database.SaveResult[]  sr = Database.Insert(AttachemntObj, false)                      
		
		for(Database.SaveResult s : sr){
	
		if(s.isSuccess()){

			Id newid = sr.getId()  
	
		}else{
	
		}

		*/

		// Rollback to the previous database point
		Database.rollback(sp);
	}

	public static void generateAttachments(Map<Integer,Blob> blobmap, Id theid){

		//Attache each blob as a pipe delimited file to the parent record identifeid by theid

		// Create a savepoint
		Savepoint sp = Database.setSavepoint();

		

		// Rollback to the previous database point
		Database.rollback(sp);

	}

	public Map<Integer,Blob> generateBlobMap(Map<Integer,String> stringmap){

		//For each occurence in the stringmap generate a blob
		//Get the map size
		//Iterate through the map to the first 500 entries for the first batch then start the next batch

		Map<Integer,Blob> blobmap = new Map<Integer,Blob>(); //The blob map

		for(Integer i = 1; i < stringmap.size(); i++){

			String thestring = stringmap.get(i);

			if(thestring != NULL){
				Blob theblob = Blob.valueOf(thestring);
				blobmap.put(i,theblob); //Populate the Blob Map

			}else{
				Blob theblob = Blob.valueOf('No String To Convert');
				blobmap.put(i,theblob); //Populate the Blob Map
			}

		}

		if(blobmap.size()>0){
			return blobmap;
		}else{
			Map<Integer,Blob> errormap = new Map<Integer,Blob>(); //The error map
    		errormap.put(1, NULL);
    		return errormap; // Return the error map
		}

	}

	public Map<Integer,String> generateStringMap(Map<Integer,KIDS_Service_Log_Entry__c> entries) {

		//Take the Map of Service Log Entries and Generate a String for Each Batch of 500 Entries

		Integer b; // The current batch number <= entries.size() / 500 for batches of 500 probably use a mod function example[x].round(System.RoundingMode.UP));
		//Integer i; //the current counter 1 through entries.size() ... technically the row number of the entry
		Map<Integer,String> stringmap = new Map<Integer,String>(); //The String Map

		if(entries.size()>0){

			for (Integer i = 1; i < entries.size(); i++) {

			Decimal block = i/500;

			b = block.round(System.RoundingMode.UP).intValue();

			String s; // A String

			KIDS_Service_Log_Entry__c e = new KIDS_Service_Log_Entry__c();

			e = entries.get(i);// Get the entry according to index

			s += line(new String[] { //Build a string from cells

				format(e.Activity__c),
				format(e.Approving_Worker__c),
				format(e.Comments__c),
				format(e.Contact_Type__c),
				format(e.Facility_ID__c),
				format(e.Program_ID__c),
				format(e.Requesting_Worker__c),
				format(e.Row_ID__c),
				format(e.Service_End_Time__c),
				format(e.Service_Episode_ID__c),
				format(e.Service_Rendered_Date__c),
				format(e.Service_Start_Time__c),
				format(e.Service_Structure_ID__c),
				format(e.Target_Client_ID__c),
				format(e.Unit__c),
				format(e.Unit_Type__c)

			});

			stringmap.put(b,s); //Put the batch number and string in the map

			}
        	return stringmap; //Return the string map
    	}else{
    		Map<Integer,String> errormap = new Map<Integer,String>(); //The error map
    		errormap.put(1, NULL);
    		return errormap; // Return the error map
    	}

	}

    public Map<Integer,KIDS_Service_Log_Entry__c> generateEntryMap(Id theid){

    	//Use the Service Log Id to Find All Related Entries
    	//Return the Entries as a Map of the Row Id to the KIDS Service Log Entry Object

    	List<KIDS_Service_Log_Entry__c> lstEntries = new List<KIDS_Service_Log_Entry__c>(); //A Map of KIDS Service Log Entries
    	Map<Integer, KIDS_Service_Log_Entry__c> themap = new Map<Integer, KIDS_Service_Log_Entry__c>(); //A map of Kids Service Log Entries

		SObjectType logentryType = Schema.getGlobalDescribe().get('KIDS_Service_Log_Entry__c'); //Describe the KIDS Service Log Entry Object
		Map<String,Schema.SObjectField> entryFields = logentryType.getDescribe().fields.getMap(); //A Map of Fields on KIDS Service Log Entry

		//Create the select string
		string entryselect = 'Select ';

        for(string e : entryFields.keyset()){
            entryselect = entryselect + entryFields.get(e) + ', ';
        }

        entryselect = entryselect.substring(0,entryselect.length()-2);
        entryselect = entryselect + '';
        entryselect = entryselect + ' FROM KIDS_Service_Log_Entry__c WHERE KIDS_Service_Log__c =: theid';

        try{
            lstEntries = (KIDS_Service_Log_Entry__c[])Database.query(entryselect); //Query for the list of Log Entries
        }catch(Exception e){
            system.debug('***********************ERROR Querying KIDS Service Log Entries ***********************' + e.getMessage());
        }

        if(!lstEntries.isEmpty()){ //If the list of Entries is not empty do something

        	Integer i;

        	i = 1;

        	for(KIDS_Service_Log_Entry__c le : lstEntries){

        		themap.put(i,le); //Populate the map

        		i = i + 1;

        	}

        }

    	if(themap.size() > 0){ //Do something if the map contains something
    		return themap; //Return themap
    	}else{
    		Map<Integer,KIDS_Service_Log_Entry__c> errormap = new Map<Integer,KIDS_Service_Log_Entry__c>(); //An error map
    		errormap.put(1,NULL); //Populate the error map
    		return errormap;
    	}

    }

    private String line(String[] cells) {
        return String.join(cells, '|') + '\n'; //Join the cells with a pipe delimiter and add a return
    }

    private String format(Date d)    { //Format a data as a string
        return d != null ? '"' + d.format().escapeCsv() + '"' : '""';
    }

    private String format(DateTime dt)    { //Format a date time as a string
    	return dt != null ? '"' + dt.format().escapeCsv() + '"' : '""';
    }

    private String format(String s) { //Format a string as a string
        return s != null ? '"' + s.escapeCsv() + '"' : '""';
    }
    private String format(Decimal d, Integer scale) { //Format a decimal as a string with scale
        return d != null ? String.valueOf(d.setScale(scale)) : '';
    }

    private String format(Decimal d) { //Format a decimal with a default scale of 2
        return format(d, 2);
    }

}