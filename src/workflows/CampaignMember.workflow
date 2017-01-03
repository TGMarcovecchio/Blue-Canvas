<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>EIC_Registration_Confirmation_Not_Yet_Paid</fullName>
        <description>EIC Registration Confirmation - Not Yet Paid</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/EIC_Registered_NOT_PAID_Confirmation</template>
    </alerts>
    <alerts>
        <fullName>New_EIC_Registration</fullName>
        <description>New EIC Registration</description>
        <protected>false</protected>
        <recipients>
            <recipient>tim_win@winnets.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_EIC_Registration</template>
    </alerts>
    <rules>
        <fullName>New EIC Registration Energy Project Management Certificate</fullName>
        <actions>
            <name>EIC_Registration_Confirmation_Not_Yet_Paid</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>New_EIC_Registration</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>CampaignMember.RecordTypeId</field>
            <operation>equals</operation>
            <value>EIC Training Members</value>
        </criteriaItems>
        <criteriaItems>
            <field>Campaign.Name</field>
            <operation>equals</operation>
            <value>Energy Project Management Certificate</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
