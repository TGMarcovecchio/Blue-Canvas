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

	public static Map<Integer,KIDS_Service_Log_Entry__c> theentrymap;
	public static Map<Integer,Blob> theblobmap;
	public static Map<Integer,String> thestringmap;
	public static KIDS_Service_Log__c thelog;
	public static List<String> strings;

	public KIDSServiceLogTools(){
		
	}

	/*webservice static Integer serviceProcessLog(String theid){

	}*/

	public static void processLog(Id theid){

		//theentrymap = generateEntryMap(theid); //Generate the Entry Map
		//thestringmap = generateStringMap(theentrymap); //Generate the String Map
		//theblobmap = generateBlobMap(thestringmap); //Generate the Blob Map
		
		//generateAttachments(generateBlobMap(generateStringMap(generateEntryMap(theid))),theid); //Generate the final attachements

		generateAttachments(generateStringMap(generateEntryMap(theid)),theid);
		
		//updateParentLog(theid,'Message','Status',date.today()); //Update the parent log after processing

	}

	public KIDS_Service_Log__c getServiceLog(Id theid){

		KIDS_Service_Log__c thislog = new KIDS_Service_Log__c(); //A Service Log

		SObjectType logType = Schema.getGlobalDescribe().get('KIDS_Service_Log__c'); //Describe the KIDS Service Log Object
		Map<String,Schema.SObjectField> logFields = logType.getDescribe().fields.getMap(); //A Map of Fields on KIDS Service Log

		//Create the select string
		string logselect = 'Select ';

        for(string l : logFields.keyset()){
            logselect = logselect + logFields.get(l) + ', ';
        }

        logselect = logselect.substring(0,logselect.length()-2);
        logselect = logselect + '';
        logselect = logselect + ' FROM KIDS_Service_Log__c WHERE Id =: theid';

        try{
            thislog  = (KIDS_Service_Log__c)Database.query(logselect); //Query for the log
        }catch(Exception e){
            system.debug('***********************ERROR Querying KIDS Service Log ***********************' + e.getMessage());
        }

        if(thislog !=NULL){

        	return thislog;
        	
        }else{

        	return NULL;
        }


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

		

		*/

		// Rollback to the previous database point
		Database.rollback(sp);
	}

	public static void generateAttachments(List<String> thestrings, Id theid){

		//Attache each blob as a pipe delimited file to the parent record identifeid by theid

		// Create a savepoint
		//Savepoint sp = Database.setSavepoint();

		List<Attachment> theatts = new List<Attachment>(); //The List of Attachments
		Integer i = 1;

		//for(Integer i = 1; i < blobmap.size(); i++){

			//if(blobmap.get(i) != NULL){

				//Blob theBlob = blobmap.get(i);

				for(String s : thestrings){

				Blob theblob = Blob.valueOf(s);
				//blobmap.put(i,theblob); //Populate the Blob Map

				Attachment att = new Attachment(Body = theBlob, //Attache the Blob
		                              Name =  theId + System.now().format('yyyy-MMM-dd-hh-mm-ss') + '.psv', //Name the file
		                              parentId = theid); //Set the Parent Id

				theAtts.add(att); //Add the attachment to the list of attachments to be created

				}

			//} //End if blobmap.get(i) != NULL

		//} //End for Integer i = 1; i < blobmap.size(); i++

		if(!theAtts.isEmpty()){

	        Database.SaveResult[]  sr = Database.Insert(theAtts, false); //Insert the list of Attachments

	        for(Database.SaveResult s : sr){ //Cycle through the save results
		
				if(s.isSuccess()){ //Do something if the insert is a success

					Id newid = s.getId();
			
				}else{ //Do something if the insert is not a success
			
				}

			}

        }else{ //Do something if the list of Attachments is NULL

        }                      

		// Rollback to the previous database point
		//Database.rollback(sp);

	}

	public static Map<Integer,Blob> generateBlobMap(Map<Integer,String> stringmap){

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

			System.Debug('------------ ERROR BLOB MAP GENERATED -------------');

			Map<Integer,Blob> errormap = new Map<Integer,Blob>(); //The error map
    		errormap.put(1, NULL);
    		return errormap; // Return the error map
		}

	}

	public static List<String> generateStringMap(List<KIDS_Service_Log_Entry__c> entries) {

		//Take the Map of Service Log Entries and Generate a String for Each Batch of 500 Entries
		/*
		Row ID
		Service Episode ID 
		Service Structure ID 
		Service Rendered  -- Date Provide the date on which the service was rendered. Date format mmddyyyy
		Service Start Time -- Provide the service start time of the service in mmddyyyyhhmmss (24 hr format)
		Service End Time -- Provide the service end time of the service in mmddyyyyhhmmss (24 hr format)
		Target Client ID
		Program ID
		Facility ID
		Unit Type 
		Unit 
		Activity 
		Contact Type 
		Comments 
		Requesting Worker
		Approving Worker
		*/

		Integer b; // The current batch number <= entries.size() / 500 for batches of 500 probably use a mod function example[x].round(System.RoundingMode.UP));
		Decimal maxblock;
		Integer maxb;
		Integer i;
		Integer bcurrent;

		//Integer i; //the current counter 1 through entries.size() ... technically the row number of the entry
		//Map<Integer,String> stringmap = new Map<Integer,String>(); //The String Map
		List<String> somestrings = new List<String>();

		/*
		if(entries.size()>0){

			maxblock = entries.size()/500;
			maxb = maxblock.round(System.RoundingMode.UP).intValue();
			//i = 1;
			//b = 1; 

			//for(b; b < maxb){
		*/

				String s; // A String

				/*
				for (i = 1; i < entries.size(); i++) {

					Decimal block = i/500;

					b = block.round(System.RoundingMode.UP).intValue();

					//Add a line to the string
					KIDS_Service_Log_Entry__c e = new KIDS_Service_Log_Entry__c();
					e = entries.get(i);// Get the entry according to index

					if(b == bcurrent){//Do something if we are still in the same batch
				*/

					for(KIDS_Service_Log_Entry__c e : entries){

						s += line(new String[] { //Build a string from cells

							format(e.Row_ID__c),
							format(e.Service_Episode_ID__c),
							format(e.Service_Structure_ID__c),
							format(e.Service_Rendered_Date__c),
							format(e.Service_Start_Time__c),
							format(e.Service_End_Time__c),
							format(e.Target_Client_ID__c),
							format(e.Program_ID__c),
							format(e.Facility_ID__c),
							format(e.Unit_Type__c),
							format(e.Unit__c),
							format(e.Activity__c),
							format(e.Contact_Type__c),
							format(e.Comments__c),
							format(e.Requesting_Worker__c),
							format(e.Approving_Worker__c)

						}); //End create line

					}

					s = s.removeStartIgnoreCase('null'); //.remove('"');

					//}else{ //Do something if b != bcurrent

						System.Debug('---------- The String ----------' + s);

						//stringmap.put(bcurrent,s); //Put the batch number and string in the map
						somestrings.add(s);

					/*
						s = ''; //Start a new string

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

						}); //End create line

					} //End Else

					*/

					//bcurrent = b; //Set b current

				//} //End for i < entries.size()

			//} //End for b < bmax

			return somestrings;

	        //return stringmap; //Return the string map
	    /*
    	}else{ //Do something if entries.size() is not > 0

    		System.Debug('------------ ERROR STRING MAP GENERATED -------------');

    		//Map<Integer,String> errormap = new Map<Integer,String>(); //The error map
    		//errormap.put(1, NULL);

    		List<String> errorstring = new List<String>();
    		errorstring.add('ERROR');

    		return errorstring;
    		
    		//return errormap; // Return the error map

    	} //End else
    	*/

	}

    public static List<KIDS_Service_Log_Entry__c> generateEntryMap(Id theid){

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

        System.Debug('------------ QUERY STRING SERVICE LOG ENTRY -------------' + entryselect);

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

    	if(!lstEntries.isEmpty()){ //Do something if the map contains something

    		//return themap; //Return themap
    		return lstEntries;

    	}else{

    		System.Debug('------------ ERROR ENTRY MAP GENERATED -------------');

    		//Map<Integer,KIDS_Service_Log_Entry__c> errormap = new Map<Integer,KIDS_Service_Log_Entry__c>(); //An error map
    		//errormap.put(1,NULL); //Populate the error map
    		//return errormap;

    		List<KIDS_Service_Log_Entry__c> errorlist = new List<KIDS_Service_Log_Entry__c>();
    		errorlist.add(NULL);
    		return errorlist;

    	}

    }

    private static String line(String[] cells) {
        return String.join(cells, '|') + '\n'; //Join the cells with a pipe delimiter and add a return
    }

    private static String format(Date d)    { //Format a data as a string
        return d != null ? (String.valueOf(d.month()).leftpad(2) + String.valueOf(d.day()).leftpad(2) + String.valueOf(d.year()).leftpad(4)).replace(' ','0') : ''; //d.format().escapeCsv() 
    }

    private static String format(DateTime dt)    { //Format a date time as a string
    	return dt != null ? (String.valueOf(dt.month()).leftpad(2) + String.valueOf(dt.day()).leftpad(2) + String.valueOf(dt.year()).leftpad(4) + String.valueOf(dt.hour()).leftpad(2) + String.valueOf(dt.minute()).leftpad(2) + String.valueOf(dt.second()).leftpad(2)).replace(' ','0') : ''; //dt.format().escapeCsv() 
    }

    private static String format(String s) { //Format a string as a string
        return s != null ? s.escapeCsv() : '';
    }
    private static String format(Decimal d, Integer scale) { //Format a decimal as a string with scale
        return d != null ? String.valueOf(d.setScale(scale)) : '';
    }

    private static String format(Decimal d) { //Format a decimal with a default scale of 2
        return format(d, 2);
    }

	/*

	Service Rendered  -- Date Provide the date on which the service was rendered. Date format mmddyyyy
	Service Start Time -- Provide the service start time of the service in mmddyyyyhhmmss (24 hr format)
	Service End Time -- Provide the service end time of the service in mmddyyyyhhmmss (24 hr format)

	valueOf(dateToConvert)
	Returns a String that represents the specified Date in the standard “yyyy-MM-dd” format.

	valueOf(datetimeToConvert)
	Returns a String that represents the specified Datetime in the standard “yyyy-MM-dd HH:mm:ss” format for the local

	*/

}