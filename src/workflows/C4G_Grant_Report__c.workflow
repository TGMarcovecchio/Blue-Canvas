<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Alert_Grant_Report_Deadline_Email_Alert</fullName>
        <description>Email Alert: Grant Report Deadline Email Alert</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Grant_Reports/Report_Due_Date</template>
    </alerts>
    <rules>
        <fullName>Grant Report Deadline Email Alert</fullName>
        <active>true</active>
        <criteriaItems>
            <field>C4G_Grant_Report__c.Status__c</field>
            <operation>notEqual</operation>
            <value>Sent</value>
        </criteriaItems>
        <description>A thirty (30) day reminder to submit the grant&apos;s report</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Email_Alert_Grant_Report_Deadline_Email_Alert</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>C4G_Grant_Report__c.Due_Date__c</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
