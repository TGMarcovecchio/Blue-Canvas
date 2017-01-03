<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Class_Name</fullName>
        <field>Name</field>
        <formula>Name &amp; &quot; &quot; &amp; text(datevalue( Class_Start_Date_Time__c ))</formula>
        <name>Class Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Class Name</fullName>
        <actions>
            <name>Class_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Program__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Name the class automatically</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
