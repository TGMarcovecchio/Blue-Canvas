@IsTest class WSTestExceptionClass {

	@IsTest static void unitTest1() {

		throw new WSException('----I am a new Exception------');
		
	}
}