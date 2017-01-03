<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Start_Date_of_Previous_Month_c</fullName>
        <field>Start_Date_of_Previous_Month__c</field>
        <formula>SDPM__c</formula>
        <name>Start_Date_of_Previous_Month__c</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Send welcome e-mail</fullName>
        <actions>
            <name>send_welcome_e_mail</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Won</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Start_Date_of_Previous_Month%5F%5Fc</fullName>
        <actions>
            <name>Start_Date_of_Previous_Month_c</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>SDPM__c &lt;&gt;  Start_Date_of_Previous_Month__c</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>send_welcome_e_mail</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>3</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <offsetFromField>Opportunity.CloseDate</offsetFromField>
        <priority>B</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>send welcome e-mail</subject>
    </tasks>
</Workflow>
