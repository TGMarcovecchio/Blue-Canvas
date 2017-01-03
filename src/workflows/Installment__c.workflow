<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>Installment payment due</fullName>
        <actions>
            <name>Installment_payment_due</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>The opportunity&apos;s installment date is due. Please follow up on this to ensure payment.</description>
        <formula>AND(Due_Date__c =today(),ISPICKVAL(Status__c,&quot;Payment Due&quot;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Installment_payment_due</fullName>
        <assignedToType>owner</assignedToType>
        <description>The opportunity&apos;s installment date is due. Please follow up on this to ensure payment.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Installment payment due</subject>
    </tasks>
</Workflow>
