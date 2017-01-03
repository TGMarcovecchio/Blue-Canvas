<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Use_Suggested_Invoice_Number</fullName>
        <field>Name</field>
        <formula>Suggested_Invoice_Number__c</formula>
        <name>Use Suggested Invoice Number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Use Suggested Invoice Number at Creation</fullName>
        <actions>
            <name>Use_Suggested_Invoice_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Name &lt;&gt;  Suggested_Invoice_Number__c</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
