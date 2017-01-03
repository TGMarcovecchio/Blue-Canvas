<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>NPO_Workshop_Confirmation_Email</fullName>
        <description>NPO Workshop Confirmation Email</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NPSP/NPSP_Confirmation2</template>
    </alerts>
    <alerts>
        <fullName>New_EIC_Lead</fullName>
        <ccEmails>raskren@gmail.com</ccEmails>
        <description>New EIC Lead</description>
        <protected>false</protected>
        <recipients>
            <recipient>scuot@comcast.net</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>tim_win@winnets.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/LeadsNewassignmentnotificationSAMPLE</template>
    </alerts>
    <fieldUpdates>
        <fullName>Change_Lead_Owner</fullName>
        <description>Change Lead Owner for EIC leads</description>
        <field>OwnerId</field>
        <lookupValue>tim_win@winnets.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Change Lead Owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>NPSP Confirmation Email</fullName>
        <actions>
            <name>NPO_Workshop_Confirmation_Email</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.LeadSource</field>
            <operation>equals</operation>
            <value>Web-to-Lead</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.RecordTypeId</field>
            <operation>equals</operation>
            <value>WIN</value>
        </criteriaItems>
        <criteriaItems>
            <field>Campaign.Name</field>
            <operation>contains</operation>
            <value>workshop</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
