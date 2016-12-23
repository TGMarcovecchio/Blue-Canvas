public with sharing class MetricsEditDetailPage_Ctrl
{
    private final sObject theSObject;
    private ApexPages.StandardController theController;

    public String sfId { get; set; }
    public String tabOpt { get; set; }

    public sObject theObject
    { 
        get
        {   
            return theSObject;
        }
    }

    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public MetricsEditDetailPage_Ctrl(ApexPages.StandardController stdController)
    {
        theController = stdController;
        this.theSObject = (sObject)stdController.getRecord();
        tabOpt = 'Screen';

        if (this.theSObject.get('Id') != null)
            this.sfId = (String)this.theSObject.get('Id');
    }

    public PageReference performNextNavigation()
    {
        theController.save();

        this.sfId = theController.getId();
        System.debug(this.sfId);
        
        PageReference pageRef = new PageReference('/apex/' + 'MetricsEditPage2' + '?id=' + this.sfId);
        pageRef.setRedirect(true);
        return pageRef;
    }

    public PageReference performSaveAndNewNavigation()
    {
        theController.save();

        PageReference pageRef = new PageReference('/apex/' + 'MetricsEditPage1');
        pageRef.setRedirect(true);
        return pageRef;
    }

    public PageReference performCloseNavigation()
    {
        theController.save();

        if ((this.sfId != null) && (this.theObject.get('Id') != null))
            this.sfId = (String)this.theObject.get('Id');

        PageReference pageRef = new PageReference('/' + this.sfId);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public void saveDepartingTab()
    {
        theController.save();
        System.debug('saveDepartingTab');
    }

    public void jumpToTab1()
    {
        theController.save();
        tabOpt = 'Screen';
        System.debug('Screen');
    } 

    public void jumpToTab2()
    {
        theController.save();
        tabOpt = 'Income';
        System.debug('Income');
    } 

    public void jumpToTab3()
    {
        theController.save();
        tabOpt = 'Expenses';
        System.debug('Expenses');
    } 

    public void jumpToTab4()
    {
        theController.save();
        tabOpt = 'Credit';
        System.debug('Credit');
    } 

    public void jumpToTab5()
    {
        theController.save();
        tabOpt = 'Debt';
        System.debug('Debt');
    } 

    public void jumpToTab6()
    {
        theController.save();
        tabOpt = 'Savings';
        System.debug('Savings');
    } 
    
    public void jumpToTab7()
    {
        theController.save();
        tabOpt = 'Banked Status';
        System.debug('Banked Status');
    }
    
    public void jumpToTab8()
    {
        theController.save();
        tabOpt = 'Referrals';
        System.debug('Referrals');
    }
    
    public void jumpToTab9()
    {
        theController.save();
        tabOpt = 'Assets';
        System.debug('Assets');
    }
    
    public void jumpToTab10()
    {
        theController.save();
        tabOpt = 'Confidence/Wellness';
        System.debug('Confidence/Wellness');
    }

}