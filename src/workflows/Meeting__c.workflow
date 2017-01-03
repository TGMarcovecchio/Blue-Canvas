<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Meeting_Name</fullName>
        <field>Name</field>
        <formula>Program__r.Name  &amp; &quot; - &quot; &amp; TEXT(DATEVALUE( Date_Time__c ))</formula>
        <name>Meeting Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Meeting Name</fullName>
        <actions>
            <name>Meeting_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Meeting__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Class,One-on-One,Event or Training</value>
        </criteriaItems>
        <description>Automatically name the meeting based on date and program</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
