/**********************************************************************
* Name:     checkRecursive
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     06 Dec 2016
* ======================================================
* ======================================================
* Purpose:                                                            
* Public class used in Triggers to manage recursion
*                                                            
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       06 Dec 2016     TGM         Initial Development
***********************************************************************/
public Class checkRecursive {

	private static boolean firstRun = true;
	
	public static boolean runOnce(){
		if(firstRun){
			firstRun=false;
			return true;
		}else{
			return firstRun;
		}

	}
}