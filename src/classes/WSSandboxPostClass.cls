global class WSSandboxPostClass implements SandboxPostCopy {

	global WSSandboxPostClass() {

    }

    global void runApexClass(SandboxContext context) {

    	//Return basic sandbox information
		System.debug('WSSandboxPostClass: Sandbox Info - ' + context.organizationId() + ' ' + context.sandboxId() + ' ' + context.sandboxName());

		//Run the method which fixes the email address of the WIN support user
		fixsupportuser(); 

    }

	global static void fixsupportuser() { //fixes the user email associated with the WIN Support user account in the sandbox

		List<User> winusers = new List<User>(); //A list of WIN users
		List<User> userup = new List<User>(); //A list of WIN users to update

		try{
			//Find the WIN Support users based on their email address
			winusers = [SELECT Id, Email, IsActive from User WHERE Email LIKE '%winnets.com@example.com' AND IsActive = TRUE ];
			}catch(Exception e1){
				System.Debug('------Error retrieving WIN users by email address in Sandbox--------------'+e1);
			}
		
		//For each WIN user correct their email address so that it is valid
		for(User u : winusers){
			
			String bademail = u.Email;
			String goodemail = bademail.replace('@example.com', '');
			goodemail = goodemail.replace('=','@');

			u.Email = goodemail;
			userup.add(u);
		}


		try{
			//If the list of WIN users is not empty the update the list
			if(!userup.isEmpty()){
				update userup;
			}
		}catch(Exception e2){
			System.Debug('-------Error updating WIN Support Email address in Sandbox--------------'+e2);
		}

 	}

}