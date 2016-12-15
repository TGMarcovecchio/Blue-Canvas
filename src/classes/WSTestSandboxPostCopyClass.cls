@isTest class WSTestSandboxPostCopyClass{

		@isTest public static void testSandboxPostClass() {

		User DummyUser = new User();

		String uid;

		uid = UserInfo.getUserId();

		DummyUser = [select id, TimeZoneSidKey, LocaleSidKey, 
					EmailEncodingKey, ProfileId, LanguageLocaleKey
					from User where Id =: uid limit 1];

		User testUser = new User();

		String lastName;

		lastName = 'Smith';

		testUser.FirstName = 'Joe';
		testUser.LastName = lastName;
		testUser.Email = 'support=winnets.com@example.com';
		testUser.Username = 'joe@winnets.com';
		testUser.ProfileId = DummyUser.ProfileId;
		testUser.Alias = lastName.substring(0,5);
		testUser.CommunityNickname = lastName.substring(0,5);
		testUser.TimeZoneSidKey=DummyUser.TimeZoneSidKey;
		testUser.LocaleSidKey=DummyUser.LocaleSidKey;
		testUser.EmailEncodingKey=DummyUser.EmailEncodingKey;
		testUser.LanguageLocaleKey=DummyUser.LanguageLocaleKey;

		insert testUser;

		Account acc = new Account();
        acc.Name ='Test';
		insert acc;

        Test.startTest();
		WSSandboxPostClass apexclass = new WSSandboxPostClass();
		Test.testSandboxPostCopyScript(apexclass, acc.Id, acc.Id, 'sandboxName');
		System.assertEquals(acc.Id,acc.Id,'sandboxName');
		Test.stopTest();

	}

   
	

}