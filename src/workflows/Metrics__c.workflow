<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Metrics_Name</fullName>
        <field>Name</field>
        <formula>Contact__r.FirstName &amp; &quot; &quot; &amp; Contact__r.LastName &amp; &quot; Metric - &quot; &amp; text(Date_information_collected__c)</formula>
        <name>Metrics Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Metric Name</fullName>
        <actions>
            <name>Metrics_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Metrics__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Automatically name Metrics</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
