<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Task_Type_Field_Update</fullName>
        <description>Copies the value from the Activity Type field to the Activity Type Copy field.</description>
        <field>C4G_Activity_Type_Copy__c</field>
        <formula>TEXT(Type)</formula>
        <name>Task Type Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Date_Completed_Field</fullName>
        <description>Copies today&apos;s date into the &quot;Date Completed&quot; field, AND re-evaluates Workflow rules after this field changes.</description>
        <field>C4G_Date_Completed__c</field>
        <formula>TODAY()</formula>
        <name>Update Date Completed Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Enter Date Completed</fullName>
        <actions>
            <name>Update_Date_Completed_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Task.Status</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <description>Triggered by the status of the Task changing to &quot;Completed,&quot; this Workflow updates the &quot;Date Completed&quot; field on a Task with the date of completion.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Task Type Copy Update</fullName>
        <actions>
            <name>Task_Type_Field_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Task.Type</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Updates the Activity Type Copy field for Tasks with the value from the Task Type field when it is in use.  This workflow is NOT activated by default, since using the Type field on Tasks requires additional configuration steps.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
