<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <flowActions>
        <fullName>Tax_Code_Test</fullName>
        <flow>Tax_Code_Test</flow>
        <flowInputs>
            <name>LookupAccountId</name>
            <value>{!Id}</value>
        </flowInputs>
        <flowInputs>
            <name>LookupTaxCodeName</name>
            <value>{!Test__c}</value>
        </flowInputs>
        <label>Tax Code Test</label>
        <language>en_US</language>
        <protected>false</protected>
    </flowActions>
    <rules>
        <fullName>Tax Code Test</fullName>
        <actions>
            <name>Tax_Code_Test</name>
            <type>FlowAction</type>
        </actions>
        <active>false</active>
        <formula>Ischanged( Test__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
