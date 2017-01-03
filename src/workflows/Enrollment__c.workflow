<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Registration_Confirmation</fullName>
        <description>Email Registration Confirmation</description>
        <protected>false</protected>
        <recipients>
            <field>Contact_Email_2__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>center@prosperityconnection.org</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Class_Registration/Class_Reminder</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Email_Address_on_Enrollment</fullName>
        <description>Adds the email address of the Contact to the Enrollment record so that email confirmation can be sent</description>
        <field>Contact_Email_2__c</field>
        <formula>Contact__r.Email</formula>
        <name>Update Email Address on Enrollment</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Enrollment Reminder</fullName>
        <actions>
            <name>Update_Email_Address_on_Enrollment</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Enrollment__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Program__c.Name</field>
            <operation>notContain</operation>
            <value>Coach</value>
        </criteriaItems>
        <criteriaItems>
            <field>Enrollment__c.Registration_Type__c</field>
            <operation>contains</operation>
            <value>Online</value>
        </criteriaItems>
        <description>Copies Contact&apos;s email address to the Enrollment record so that it can be used to send email reminder to Contact. Also sends email reminder 2 days prior to Class.</description>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Email_Registration_Confirmation</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Enrollment__c.Class_Date__c</offsetFromField>
            <timeLength>-2</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
