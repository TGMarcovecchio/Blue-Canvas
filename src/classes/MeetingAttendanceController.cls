public class MeetingAttendanceController {
    
    public class SelecTableAtendee {
        
        private Contact contact = null;
        private String reason = null;
        
        private Boolean selectedAttended = false;
        private Boolean selectedDrop = false;
        private ID id = null;
        
        public SelecTableAtendee(Contact con, ID id) {
            this.contact = con;  
            this.id = id;
        }
        
        public Contact getContact() {
            return contact;    
        }
        
        public void setContact(Contact con) {
            this.contact = con;
        }
        
        public String getReason() {
            return reason;
        }
        
        public void setReason(String reason) {
            this.reason = reason;
        }
        
        public Boolean getSelectedAttended() {
            return selectedAttended;
        }
        
        public void setSelectedAttended(Boolean s) {
            this.selectedAttended = s;
        }
        
        public Boolean getSelectedDrop() {
            return selectedDrop;
        }
        
        public void setSelectedDrop(Boolean s) {
            this.selectedDrop = s;
        }
        
        public ID getId() {
            return id;    
        }
    }
    
    public class MyException extends Exception {}
        
    private List<SelecTableAtendee> listAttendees = null;
    private final ApexPages.StandardController theController;
    private Meeting__c meeting;
    private Map<ID, Meeting_Attendee__c> listExistMeetingAttendee = new Map<ID, Meeting_Attendee__c>(); // <Contact__c.Id,Meeting_Attendee__c>
    private Boolean validDateTime = True; 
    
    public MeetingAttendanceController(ApexPages.StandardController stdcontroller) {
            
        theController = stdController;
        
        meeting = [SELECT Id, Name, Special_Expenses__c, Program__c, Primary_Facilitator__c, Description__c, Date_Time__c, Facility__c FROM Meeting__c WHERE Id = :theController.getId()];
        
        if( (meeting.Date_Time__c).addHours(1) <= System.now()){
	        
	        validDateTime = True;
	        
	        List<Contact> contacts = [ Select Id, FirstName, LastName, Name From Contact where Id IN (Select Contact__c From Enrollment__c where Program__c = :meeting.Program__c and Dropped_Out__c = False ) ];
	        List<Contact> contactsDrop = [ Select Id, FirstName, LastName, Name From Contact where Id IN (Select Contact__c From Enrollment__c where Program__c = :meeting.Program__c and Dropped_Out__c = True)];
	        
	        // List MeetingAttendee
	        for(Meeting_Attendee__c meet: [Select Id, Contact__c, Reason_if_not_Attended__c, Attended__c  From Meeting_Attendee__c WHERE Meeting_Name__c = :theController.getId()]){
	            listExistMeetingAttendee.put(meet.Contact__c, meet);            
	        }
	                
	        if(contacts.size() > 0){
	            
	            listAttendees = new List<SelecTableAtendee>();
	            ID id;
	            for (Contact contact : contacts) { // No Drop
	                
	                SelecTableAtendee contactSelection;
	                if(!listExistMeetingAttendee.isEmpty() && listExistMeetingAttendee.containsKey(contact.Id)){
	                    Meeting_Attendee__c meet = listExistMeetingAttendee.get(contact.Id);
	                    contactSelection = new SelecTableAtendee(contact, meet.Id);
	                    contactSelection.setReason(meet.Reason_if_not_Attended__c);
	                    contactSelection.setSelectedAttended(meet.Attended__c);
	                }else{
	                    contactSelection = new SelecTableAtendee(contact, null);
	                }   
	                listAttendees.add(contactSelection);
	            }
	        }
	            
	        if(contacts.size() > 0){    
	            for (Contact contact : contactsDrop) { // Drop              
	                SelecTableAtendee contactSelection;         
	                if(!listExistMeetingAttendee.isEmpty() && listExistMeetingAttendee.containsKey(contact.Id)){
	                    Meeting_Attendee__c meet = listExistMeetingAttendee.get(contact.Id);
	                    contactSelection = new SelecTableAtendee(contact, meet.Id);
	                    contactSelection.setReason(meet.Reason_if_not_Attended__c);
	                    contactSelection.setSelectedAttended(meet.Attended__c);
	                    contactSelection.setSelectedDrop(True);
	                    listAttendees.add(contactSelection);
	                }               
	            }
	        }
        }else{
        	validDateTime = False;
        }   
    }
    
    public Boolean getValidDateTime() {       
        return validDateTime;
    }
    
    public List<SelecTableAtendee> getListAttendees() {       
        return listAttendees;
    }
    
    public void setListContact(List<SelecTableAtendee> s) {
        listAttendees = s;
    }
    
    public Meeting__c getMeeting(){
        return meeting;
    }
    
    public PageReference SaveAttendance() {
        
        PageReference newPage = null;
        
        List<ID> enrollmentDropContact = new List<ID>();
        List<ID> enrollmentUndoDropContact = new List<ID>();
        List<Enrollment__c> enrollmentDrop = new List<Enrollment__c>();        
        List<Meeting_Attendee__c> newMeetingAttendee = new List<Meeting_Attendee__c>();
        List<Meeting_Attendee__c> upMeetingAttendee = new List<Meeting_Attendee__c>();
    
        Contact contact = null;
        Enrollment__c enrollment = null;
        
        try {
            
            for (SelecTableAtendee con: listAttendees){
                
                Meeting_Attendee__c newA, upA;
                
                
                if(con.getId() <> null){
                    
                    upA = new Meeting_Attendee__c(Id=con.getId());
                    
                    upA.Reason_if_not_Attended__c = con.getReason();
                    upA.Meeting_Name__c = meeting.Id;
                    upA.Date__c = System.today();
                    upA.Contact__c = con.getContact().Id;
                    upA.Attended__c = con.getSelectedAttended();
                    
                    upMeetingAttendee.add(upA);
                }else{
                    newA = new Meeting_Attendee__c(
                                                    Reason_if_not_Attended__c = con.getReason(),
                                                    Meeting_Name__c = meeting.Id,
                                                    Date__c = System.today(),
                                                    Contact__c = con.getContact().Id,
                                                    Attended__c = con.getSelectedAttended());
                    newMeetingAttendee.add(newA);
                }
                 
                
                if(con.getSelectedDrop()){                  
                    enrollmentDropContact.add(con.getContact().Id);                 
                }else{
                    enrollmentUndoDropContact.add(con.getContact().Id);
                }
                 
                if(!con.getSelectedAttended() && con.getReason() == ''){
                    throw new MyException('Please complete the attendance for the meeting before you click on Save'); 
                }
                
                if(con.getSelectedAttended() && con.getReason() <> ''){
                    throw new MyException('You can either check the Attended the Meeting box or fill in the Reason if not Attended field'); 
                }
            }
            
            if(!newMeetingAttendee.isEmpty()){              
                insert newMeetingAttendee;
            }
            
            if(!upMeetingAttendee.isEmpty()){               
                update upMeetingAttendee;
            }
            
            if(!enrollmentDropContact.isEmpty()){           
                 
                for(Enrollment__c en :[Select Id, Dropped_Out__c From Enrollment__c where Program__c = :meeting.Program__c and Dropped_Out__c = False and Contact__c IN :enrollmentDropContact]){
                    en.Dropped_Out__c = True;
                    en.Dropped_Out_Date__c = System.today();
                    enrollmentDrop.add(en); 
                }               
                update enrollmentDrop;
            }
            
            if(!enrollmentUndoDropContact.isEmpty()){   
                
                enrollmentDrop.clear();
                for(Enrollment__c en :[Select Id, Dropped_Out__c From Enrollment__c where Program__c = :meeting.Program__c and Dropped_Out__c = True and Contact__c IN :enrollmentUndoDropContact]){
                    en.Dropped_Out__c = False;
                    en.Dropped_Out_Date__c = null;
                    enrollmentDrop.add(en); 
                }               
                update enrollmentDrop;                
            }         
            
            Double NumberOfMeeting = 0; 
            Double NumberOfMeetingAttendees = 0;
            
            for(Meeting__c meet : [Select Id, ( Select Id From Meeting_Attendees__r Where Attended__c = true) From Meeting__c Where Program__c =:meeting.Program__c And Date_Time__c <=: System.now()]){
                  
                NumberOfMeeting += 1;
                NumberOfMeetingAttendees += meet.Meeting_Attendees__r.size();
            }   
            
            if(NumberOfMeeting > 0){  
                Program__c program = new Program__c(Id = meeting.Program__c);
                program.Average_Attendance_Rate__c = NumberOfMeetingAttendees / NumberOfMeeting;
                update program;  
            }
            
            newPage = null;
            
            String newPageUrl = '/'+ meeting.Id;
            newPage = new PageReference(newPageUrl);
            newPage.setRedirect(true);  
         }catch(System.Exception e){
            ApexPages.addMessages(e);
        }           
        return newPage;
    }
    
    static testMethod void MeetingAttendanceController_Test() {
        
        Program__c pro1 = new Program__c(Name= 'Program1_Test');
        insert pro1;
        
        Meeting__c meeting1 = new Meeting__c(Name = 'Meeting1_Test', Program__c = pro1.Id, Date_Time__c = System.now().addHours(-15));
        insert meeting1;
        
        Meeting__c meeting2 = new Meeting__c(Name = 'Meeting2_Test', Program__c = pro1.Id, Date_Time__c = System.now().addHours(-15));
        insert meeting2;
        
        Contact con1 = new Contact(LastName = 'Test1', FirstName = 'Contact1_Test');
        insert con1;
        
        Contact con2 = new Contact(LastName = 'Test2', FirstName = 'Contact2_Test');
        insert con2;
        
        Contact con3 = new Contact(LastName = 'Test3', FirstName = 'Contact3_Test');
        insert con3;
        
        Contact con4 = new Contact(LastName = 'Test4', FirstName = 'Contact4_Test');
        insert con4;
                
        Enrollment__c enroll1 = new Enrollment__c( Contact__c = con1.Id, Program__c = pro1.Id);
        insert enroll1;
        
        Enrollment__c enroll2 = new Enrollment__c( Contact__c = con2.Id, Program__c = pro1.Id);
        insert enroll2;
        
        //Enrollment__c enroll4 = new Enrollment__c( Contact__c = con4.Id, Program__c = pro1.Id);
        //insert enroll4;
                
        ApexPages.StandardController sc = new ApexPages.StandardController(meeting1);
        MeetingAttendanceController controller = new MeetingAttendanceController(sc);   
        
        PageReference pageRef;
        SelecTableAtendee atendee;
        
        try{            
            atendee = controller.getListAttendees().get(0);
            atendee.setSelectedAttended(true);
            atendee.setReason('...');            
            pageRef = controller.SaveAttendance();
        }catch(Exception e){
            // Test the exception lines
        }
        
        try{            
            atendee = controller.getListAttendees().get(0);
            atendee.setSelectedAttended(false);
            atendee.setReason('');            
            pageRef = controller.SaveAttendance();
        }catch(Exception e){
            // Test the exception lines
        }
        
        try{            
            List<SelecTableAtendee> attendees = controller.getListAttendees();
            attendees.get(0).setSelectedAttended(false);
            attendees.get(0).setReason('...');
            attendees.get(0).setSelectedDrop(true);
            controller.setListContact(attendees);
            pageRef = controller.SaveAttendance();
        }catch(Exception e){
            // Test the exception lines
        }
        
        // Contact 1
        System.assertEquals(2,controller.getListAttendees().size());
        atendee = controller.getListAttendees().get(0);
        atendee.setSelectedAttended(true);
        controller.getListAttendees().add(0, atendee);
        
        // Contact 2
        atendee = controller.getListAttendees().get(1);
        atendee.setSelectedDrop(true);
        atendee.setReason('Test Reason');
        controller.getListAttendees().add(1, atendee);
        
        pageRef = controller.SaveAttendance();
        
        sc = new ApexPages.StandardController(meeting2);
        controller = new MeetingAttendanceController(sc);   
        
        // Meeting 2    
        atendee = controller.getListAttendees().get(0);
        atendee.setSelectedAttended(true);
        atendee.setContact(atendee.getContact());
        controller.getListAttendees().add(0, atendee);
        
        
        //Test extra lines
        controller.setListContact(controller.getListAttendees());
        controller.getMeeting();
        pageRef = controller.SaveAttendance();  
        
        // Meeting 1
        Enrollment__c enroll3 = new Enrollment__c( Contact__c = con3.Id, Program__c = pro1.Id);
        insert enroll3;
        
        sc = new ApexPages.StandardController(meeting1);
        controller = new MeetingAttendanceController(sc);   
                
        System.assertEquals(3,controller.getListAttendees().size());
        atendee = controller.getListAttendees().get(0);
        atendee.setSelectedAttended(true);
        atendee.setContact(atendee.getContact());
        controller.getListAttendees().add(0, atendee);
        
        atendee = controller.getListAttendees().get(1);
        atendee.setSelectedDrop(true);
        atendee.setSelectedAttended(true);
        atendee.setContact(atendee.getContact());
        controller.getListAttendees().add(1, atendee);
        
        pageRef = controller.SaveAttendance();
        
        meeting1.Date_Time__c = System.now();
        update meeting1;
        sc = new ApexPages.StandardController(meeting1);
        controller = new MeetingAttendanceController(sc);   
        
        
        meeting1.Date_Time__c = System.now().addHours(-1);
        update meeting1;
        
        sc = new ApexPages.StandardController(meeting1);
        controller = new MeetingAttendanceController(sc);        
        
        atendee = controller.getListAttendees().get(0);
        atendee.setSelectedDrop(true);
        atendee.setSelectedAttended(true);
        atendee = controller.getListAttendees().get(1);
        atendee.setSelectedDrop(true);
        atendee.setSelectedAttended(true);
        atendee = controller.getListAttendees().get(2);
        atendee.setSelectedDrop(true);
        atendee.setSelectedAttended(true);
        pageRef = controller.SaveAttendance();
        
        sc = new ApexPages.StandardController(meeting1);
        controller = new MeetingAttendanceController(sc);        
        
        atendee = controller.getListAttendees().get(0);
        atendee.setSelectedDrop(false);
        atendee.setSelectedAttended(true);
        atendee = controller.getListAttendees().get(1);
        atendee.setSelectedDrop(false);
        atendee.setSelectedAttended(true);
        atendee = controller.getListAttendees().get(2);
        atendee.setSelectedDrop(false);
        atendee.setSelectedAttended(true);
        pageRef = controller.SaveAttendance();
                
        controller.getValidDateTime();
        
    }
    
}