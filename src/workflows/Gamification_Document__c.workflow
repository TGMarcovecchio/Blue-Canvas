<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Group_Value</fullName>
        <field>Group_Value__c</field>
        <formula>if(AND( Sales_Invoice_Line_Item__r.c2g__Product__r.Item_Group__r.Is_Eligible__c, NOT(Sales_Invoice_Line_Item__r.c2g__Invoice__r.Void__c)),  Sales_Invoice_Line_Item__r.c2g__NetValue__c , 0)</formula>
        <name>Update Group Value</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Group_Value_Void</fullName>
        <field>Group_Value_Voided__c</field>
        <formula>if(AND( Sales_Invoice_Line_Item__r.c2g__Product__r.Item_Group__r.Is_Eligible__c, Sales_Invoice_Line_Item__r.c2g__Invoice__r.Void__c),  Sales_Invoice_Line_Item__r.c2g__NetValue__c , 0)</formula>
        <name>Update Group Value Void</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Net_Value</fullName>
        <field>Net_Value__c</field>
        <formula>if( Sales_Invoice_Line_Item__r.c2g__Invoice__r.Void__c,0,  Sales_Invoice_Line_Item__r.c2g__Invoice__r.c2g__NetTotal__c  )</formula>
        <name>Update Net Value</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Net_Value_Void</fullName>
        <field>Net_Value_Voided__c</field>
        <formula>if( Sales_Invoice_Line_Item__r.c2g__Invoice__r.Void__c,  Sales_Invoice_Line_Item__r.c2g__Invoice__r.c2g__NetTotal__c ,0 )</formula>
        <name>Update Net Value Void</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Quantity_Sold</fullName>
        <field>Quantity_Sold__c</field>
        <formula>if( Sales_Invoice_Line_Item__r.c2g__Invoice__r.Void__c,0,  Sales_Invoice_Line_Item__r.c2g__Quantity__c  )</formula>
        <name>Update Quantity Sold</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Quantity_Sold_Void</fullName>
        <field>Quantity_Voided__c</field>
        <formula>if( Sales_Invoice_Line_Item__r.c2g__Invoice__r.Void__c, Sales_Invoice_Line_Item__r.c2g__Quantity__c,0 )</formula>
        <name>Update Quantity Sold Void</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>UpdateGameFields</fullName>
        <actions>
            <name>Update_Group_Value</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Group_Value_Void</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Net_Value</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Net_Value_Void</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Quantity_Sold</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Quantity_Sold_Void</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Referral_Report_Card__c.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
