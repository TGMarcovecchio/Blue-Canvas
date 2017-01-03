<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Lead_Source_Primary_Campaign_and_or_Secondary_Campaign_Changed_on_Locked_Opportu</fullName>
        <description>Lead Source, Primary Campaign, and/or Secondary Campaign Changed on Locked Opportunity</description>
        <protected>false</protected>
        <recipients>
            <recipient>katy@intellibed.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Opportunity_Lead_or_Primary_Source_Changed</template>
    </alerts>
    <fieldUpdates>
        <fullName>Account_email</fullName>
        <field>Referral_Partner_Id__c</field>
        <formula>Account.Email__c</formula>
        <name>Account email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Blogger_Sales_1_Percentage</fullName>
        <field>Sales_Person_1_Percentage__c</field>
        <formula>Sales_Person_1__r.Blogger_Commission_Percentage__c</formula>
        <name>Blogger Sales 1 Percentage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Blogger_Sales_2_Percentage</fullName>
        <field>Sales_Person_2_Percentage__c</field>
        <formula>Sales_Person_2__r.Blogger_Commission_Percentage__c</formula>
        <name>Blogger Sales 2 Percentage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PBSI__Amountupdate</fullName>
        <field>Amount</field>
        <formula>PBSI__Final_Order_Total__c</formula>
        <name>Amount update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SP_1_Medical_Show</fullName>
        <field>Sales_Person_1_Percentage__c</field>
        <formula>Sales_Person_1__r.Medical_Show_Commission_Percentage__c</formula>
        <name>SP 1 Medical Show</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SP_1_Online_Percentage</fullName>
        <field>Sales_Person_1_Percentage__c</field>
        <formula>$Setup.Commission_Percentages__c.Online_Percentage__c</formula>
        <name>SP 1 Online Percentage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SP_1_PPC_Commission_Percentage</fullName>
        <field>Sales_Person_1_Percentage__c</field>
        <formula>Sales_Person_1__r.Digital_Media_Commission_Percentage__c</formula>
        <name>SP 1 PPC Commission Percentage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SP_1_Percentage_Cons_Show</fullName>
        <field>Sales_Person_1_Percentage__c</field>
        <formula>Sales_Person_1__r.Consuner_Show_Commission__c</formula>
        <name>SP 1 Percentage Cons Show</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SP_1_Percentage_Medical</fullName>
        <field>Sales_Person_1_Percentage__c</field>
        <formula>Sales_Person_1__r.Medical__c</formula>
        <name>SP 1 Percentage Medical</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SP_1_Percentage_Sales_Center</fullName>
        <field>Sales_Person_1_Percentage__c</field>
        <formula>Sales_Person_1__r.Sales_Center__c</formula>
        <name>SP 1 Percentage Sales Center</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SP_1_Percentage_Store</fullName>
        <field>Sales_Person_1_Percentage__c</field>
        <formula>Sales_Person_1__r.Store_Commission_Percentage__c</formula>
        <name>SP 1 Percentage Store</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SP_2_Commission_Percentage</fullName>
        <field>Sales_Person_2_Percentage__c</field>
        <formula>Sales_Person_2__r.Medical__c</formula>
        <name>SP 2 Commission Percentage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SP_2_Commission_Percentage_Online</fullName>
        <field>Sales_Person_2_Percentage__c</field>
        <formula>$Setup.Commission_Percentages__c.Online_Percentage__c</formula>
        <name>SP 2 Commission Percentage Online</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SP_2_Con_Show_Percentage</fullName>
        <field>Sales_Person_2_Percentage__c</field>
        <formula>Sales_Person_2__r.Consuner_Show_Commission__c</formula>
        <name>SP 2 Con Show Percentage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SP_2_Medical_Show</fullName>
        <field>Sales_Person_2_Percentage__c</field>
        <formula>Sales_Person_2__r.Medical_Show_Commission_Percentage__c</formula>
        <name>SP 2 Medical Show</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SP_2_PPC_Commission_Percentage</fullName>
        <field>Sales_Person_2_Percentage__c</field>
        <formula>Sales_Person_2__r.Digital_Media_Commission_Percentage__c</formula>
        <name>SP 2 PPC Commission Percentage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SP_2_Sales_Center_Percentage</fullName>
        <field>Sales_Person_2_Percentage__c</field>
        <formula>Sales_Person_2__r.Sales_Center__c</formula>
        <name>SP 2 Sales Center Percentage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SP_2_Store_Percentage</fullName>
        <field>Sales_Person_2_Percentage__c</field>
        <formula>Sales_Person_2__r.Store_Commission_Percentage__c</formula>
        <name>SP 2 Store Percentage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Opty_Close_Date_to_Created_Date</fullName>
        <field>CloseDate</field>
        <formula>CreatedDate</formula>
        <name>Set Opty Close Date to Created Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Total_Update_2</fullName>
        <field>Amount</field>
        <formula>PBSI__Total__c</formula>
        <name>Total Update 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Enforce Valid Lead Source%2C Referral Type Pairs</fullName>
        <active>false</active>
        <formula>AND(ISPICKVAL(StageName, &quot;Closed Won&quot;),
OR(
AND(ISPICKVAL(LeadSource, &quot;Blogger Program&quot;), 
NOT(CONTAINS( Referral_Type__c, &quot;Blogger&quot;))),
AND(ISPICKVAL(LeadSource, &quot;Medical Program&quot;), 
OR(NOT(CONTAINS(Referral_Type__c, &quot;Medical - Doctor&quot;)), 
NOT(CONTAINS(Referral_Type__c, &quot;Medical Show&quot;))),
AND(ISPICKVAL(LeadSource, &quot;Medical Show&quot;), 
NOT(CONTAINS(Referral_Type__c, &quot;Medical Show&quot;))),
AND(ISPICKVAL(LeadSource, &quot;Consumer Show&quot;), 
NOT(CONTAINS(Referral_Type__c, &quot;Consumer Show&quot;))),
AND(ISPICKVAL(LeadSource, &quot;Direct Sales&quot;),
OR( CONTAINS(Referral_Type__c, &quot;Blogger&quot;) , 
CONTAINS(Referral_Type__c, &quot;Medical - Doctor&quot;)))
)
))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Locked Opp Lead Source%2C Primary%2C Secondary Campaign Has Changed</fullName>
        <actions>
            <name>Lead_Source_Primary_Campaign_and_or_Secondary_Campaign_Changed_on_Locked_Opportu</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Notify accounting when the lead source, primary campaign or secondary campaign on a locked opportunity are changed.</description>
        <formula>AND(
 Referral_Access__c = &quot;Locked&quot;,
OR(
ISCHANGED( LeadSource ),
ISCHANGED( Lead_Source_2__c ),
ISCHANGED( CampaignId ),
ISCHANGED( Secondary_Campaign__c )
)
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PBSI__opp Amount</fullName>
        <actions>
            <name>PBSI__Amountupdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SP Percentage Blogger</fullName>
        <actions>
            <name>Blogger_Sales_1_Percentage</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Blogger_Sales_2_Percentage</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.LeadSource</field>
            <operation>equals</operation>
            <value>Blogger Program</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Purchase_Method__c</field>
            <operation>notEqual</operation>
            <value>Online</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Override_Comm_Percent_from_User_Tab__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SP Percentage Consumer Show</fullName>
        <actions>
            <name>SP_1_Percentage_Cons_Show</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SP_2_Con_Show_Percentage</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.LeadSource</field>
            <operation>equals</operation>
            <value>Consumer Show</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Purchase_Method__c</field>
            <operation>equals</operation>
            <value>Show</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Override_Comm_Percent_from_User_Tab__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SP Percentage Consumer Show - Call In</fullName>
        <actions>
            <name>SP_1_Percentage_Sales_Center</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SP_2_Sales_Center_Percentage</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Override_Comm_Percent_from_User_Tab__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.LeadSource</field>
            <operation>equals</operation>
            <value>Consumer Show</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Purchase_Method__c</field>
            <operation>equals</operation>
            <value>Call In</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SP Percentage Consumer Show - Store</fullName>
        <actions>
            <name>SP_1_Percentage_Store</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SP_2_Store_Percentage</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Override_Comm_Percent_from_User_Tab__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.LeadSource</field>
            <operation>equals</operation>
            <value>Consumer Show</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Purchase_Method__c</field>
            <operation>equals</operation>
            <value>Store</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SP Percentage Digital Media</fullName>
        <actions>
            <name>SP_1_PPC_Commission_Percentage</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SP_2_PPC_Commission_Percentage</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.LeadSource</field>
            <operation>equals</operation>
            <value>Digital Media</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Purchase_Method__c</field>
            <operation>notEqual</operation>
            <value>Online</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Override_Comm_Percent_from_User_Tab__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SP Percentage Medical Program</fullName>
        <actions>
            <name>SP_1_Percentage_Medical</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SP_2_Commission_Percentage</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND( 
ISPICKVAL(LeadSource, &quot;Medical Program&quot;),
NOT(CONTAINS(TEXT(Purchase_Method__c), &quot;Online&quot;)),
Override_Comm_Percent_from_User_Tab__c = FALSE  
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SP Percentage Medical Show</fullName>
        <actions>
            <name>SP_1_Medical_Show</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SP_2_Medical_Show</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.LeadSource</field>
            <operation>equals</operation>
            <value>Medical Show</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Purchase_Method__c</field>
            <operation>equals</operation>
            <value>Show</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Override_Comm_Percent_from_User_Tab__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SP Percentage Medical Show - Non Show</fullName>
        <actions>
            <name>SP_1_Percentage_Medical</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SP_2_Commission_Percentage</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Override_Comm_Percent_from_User_Tab__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.LeadSource</field>
            <operation>equals</operation>
            <value>Medical Show</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Purchase_Method__c</field>
            <operation>equals</operation>
            <value>Call In,Store</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SP Percentage Online All</fullName>
        <actions>
            <name>SP_1_Online_Percentage</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SP_2_Commission_Percentage_Online</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Purchase_Method__c</field>
            <operation>equals</operation>
            <value>Online</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Override_Comm_Percent_from_User_Tab__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.LeadSource</field>
            <operation>notEqual</operation>
            <value>Wholesale</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SP Percentage Sales Center</fullName>
        <actions>
            <name>SP_1_Percentage_Sales_Center</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SP_2_Sales_Center_Percentage</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.LeadSource</field>
            <operation>equals</operation>
            <value>Direct Sales</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Purchase_Method__c</field>
            <operation>notEqual</operation>
            <value>Online</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Override_Comm_Percent_from_User_Tab__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SP Percentage Store</fullName>
        <actions>
            <name>SP_1_Percentage_Store</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SP_2_Store_Percentage</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.LeadSource</field>
            <operation>equals</operation>
            <value>&quot;Store - Draper, Utah&quot;,&quot;Store - Orem, Utah&quot;,&quot;Store - Salt Lake City, Utah&quot;</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Purchase_Method__c</field>
            <operation>notEqual</operation>
            <value>Online</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Override_Comm_Percent_from_User_Tab__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Close Date to Created Date</fullName>
        <actions>
            <name>Set_Opty_Close_Date_to_Created_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>opp Amount1</fullName>
        <actions>
            <name>Total_Update_2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>DATEVALUE(CreatedDate) &gt; DATE(2015,1,5)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
