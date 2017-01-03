<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Attended_Date</fullName>
        <description>Updates attended date to match meeting date</description>
        <field>Date__c</field>
        <formula>DATEVALUE( Meeting_Name__r.Date_Time__c )</formula>
        <name>Update Attended Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Meeting Attendee Date</fullName>
        <actions>
            <name>Update_Attended_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Meeting_Attendee__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Updates the meeting attendee date to match the date of the meeting</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
