<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <flowActions>
        <fullName>Time_Record_Account</fullName>
        <flow>Time_Record_Account</flow>
        <flowInputs>
            <name>TimeRecord</name>
            <value>{!this}</value>
        </flowInputs>
        <label>Time Record Account</label>
        <language>en_US</language>
        <protected>false</protected>
    </flowActions>
    <rules>
        <fullName>Time Record Account</fullName>
        <actions>
            <name>Time_Record_Account</name>
            <type>FlowAction</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.AccountId</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
