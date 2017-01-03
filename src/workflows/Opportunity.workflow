<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>npsp__Opportunity_Email_Acknowledgment</fullName>
        <description>Opportunity Email Acknowledgment</description>
        <protected>false</protected>
        <recipients>
            <field>npsp__Primary_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>npsp__NPSP_Email_Templates/npsp__NPSP_Opportunity_Acknowledgment</template>
    </alerts>
    <fieldUpdates>
        <fullName>Funds_Arrival_Date</fullName>
        <field>C4G_Funds_Arrival_Date__c</field>
        <formula>Today()</formula>
        <name>Funds Arrival Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Grant_Agreement_Received_Date</fullName>
        <field>C4G_Grant_Agreement_Received_Date__c</field>
        <formula>Today()</formula>
        <name>Grant Agreement Received Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Grant_Agreement_Submitted_Date</fullName>
        <field>C4G_Grant_Agreement_Received_Date__c</field>
        <formula>Today()</formula>
        <name>Grant Agreement Submitted Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LOI_Approved_Declined_Date</fullName>
        <field>C4G_LOI_Approved_Declined_Date__c</field>
        <formula>Today()</formula>
        <name>LOI Approved/Declined Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LOI_Submitted_Date</fullName>
        <description>Updates the LOI Submitted Date to today&apos;s date</description>
        <field>C4G_LOI_Submitted_Date__c</field>
        <formula>Today()</formula>
        <name>LOI Submitted Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Proposal_Approved_Declined_Date</fullName>
        <field>C4G_Proposal_Approved_Declined_Date__c</field>
        <formula>Today()</formula>
        <name>Proposal Approved/Declined Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Proposal_Submitted_Date</fullName>
        <description>Updates the Proposal Submitted Date to today&apos;s date</description>
        <field>C4G_Proposal_Submitted_Date__c</field>
        <formula>Today()</formula>
        <name>Proposal Submitted Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npsp__Opportunity_AcknowledgmentStatus_Update</fullName>
        <description>Sets the Acknowledgment Status to &quot;Acknowledged&quot;</description>
        <field>npsp__Acknowledgment_Status__c</field>
        <literalValue>Acknowledged</literalValue>
        <name>Opportunity Acknowledgment Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npsp__Opportunity_Acknowledgment_Date_Update</fullName>
        <description>sets the Acknowledgment Date to Today.</description>
        <field>npsp__Acknowledgment_Date__c</field>
        <formula>Today()</formula>
        <name>Opportunity Acknowledgment Date Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npsp__Opportunity_Copy_FMV_to_Amount</fullName>
        <description>Copy the Opportunities Fair Market Value field to the Amount field.</description>
        <field>Amount</field>
        <formula>npsp__Fair_Market_Value__c</formula>
        <name>Opportunity Copy FMV to Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Funds Arrival Date</fullName>
        <actions>
            <name>Funds_Arrival_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Received</value>
        </criteriaItems>
        <description>Updates the Funds Arrival Date by stage</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Grant Agreement Received Date</fullName>
        <actions>
            <name>Grant_Agreement_Received_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Grant Agreement Received</value>
        </criteriaItems>
        <description>Updates the Grant Agreement Received Date by stage</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Grant Agreement Submitted Date</fullName>
        <actions>
            <name>Grant_Agreement_Submitted_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Grant Agreement Submitted</value>
        </criteriaItems>
        <description>Updates the Grant Agreement Submitted Date by stage</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>LOI Approved%2FDeclined Date</fullName>
        <actions>
            <name>LOI_Approved_Declined_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>LOI Approved,LOI Declined</value>
        </criteriaItems>
        <description>Updates the LOI Approved/Declined Date by stage</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>LOI Submitted Date</fullName>
        <actions>
            <name>LOI_Submitted_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>LOI Submitted</value>
        </criteriaItems>
        <description>Updates the LOI Submitted Date by stage</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Proposal Approved%2FDeclined Date</fullName>
        <actions>
            <name>Proposal_Approved_Declined_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Proposal Declined,Proposal Approved</value>
        </criteriaItems>
        <description>Updates the Proposal Approved/Declined Date by stage</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Proposal Submitted Date</fullName>
        <actions>
            <name>Proposal_Submitted_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Proposal Submitted</value>
        </criteriaItems>
        <description>Updates the Proposal Submitted Date
 by stage</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>npsp__Opportunity Copy FMV to Amount</fullName>
        <actions>
            <name>npsp__Opportunity_Copy_FMV_to_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>Opportunity.Amount</field>
            <operation>equals</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Amount</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.npsp__Fair_Market_Value__c</field>
            <operation>notEqual</operation>
            <value>0</value>
        </criteriaItems>
        <description>Enable this rule if you would like the Fair Market Value copied to the Amount, if the Amount is zero or is blank.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>npsp__Opportunity Email Acknowledgment</fullName>
        <actions>
            <name>npsp__Opportunity_Email_Acknowledgment</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>npsp__Opportunity_AcknowledgmentStatus_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>npsp__Opportunity_Acknowledgment_Date_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Emails an acknowledgment to the Primary Contact when Email Acknowledgment is set.</description>
        <formula>TEXT(npsp__Acknowledgment_Status__c) = $Label.npsp__sendAcknowledgmentFireStatus &amp;&amp;  npsp__Primary_Contact__r.Email &lt;&gt; NULL &amp;&amp;  npsp__Primary_Contact__r.npsp__Do_Not_Contact__c &lt;&gt; True &amp;&amp;  npsp__Primary_Contact__r.HasOptedOutOfEmail &lt;&gt; True &amp;&amp;  npsp__Primary_Contact__r.npsp__Deceased__c &lt;&gt; True</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
