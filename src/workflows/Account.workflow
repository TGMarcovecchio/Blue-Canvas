<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Billing_to_Shipping_City</fullName>
        <field>ShippingCity</field>
        <formula>BillingCity</formula>
        <name>Billing to Shipping City</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Billing_to_Shipping_Country</fullName>
        <field>ShippingCountry</field>
        <formula>BillingCountry</formula>
        <name>Billing to Shipping Country</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Billing_to_Shipping_State</fullName>
        <field>ShippingState</field>
        <formula>BillingState</formula>
        <name>Billing to Shipping State</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Billing_to_Shipping_Street</fullName>
        <field>ShippingStreet</field>
        <formula>BillingStreet</formula>
        <name>Billing to Shipping Street</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Billing_to_Shipping_Zip</fullName>
        <field>ShippingPostalCode</field>
        <formula>BillingPostalCode</formula>
        <name>Billing to Shipping Zip</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Daysoffset</fullName>
        <field>c2g__CODADaysOffset1__c</field>
        <formula>30</formula>
        <name>Daysoffset = 30</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>USD</fullName>
        <field>c2g__CODAAccountTradingCurrency__c</field>
        <formula>&quot;USD&quot;</formula>
        <name>USD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Billing to Shipping Address</fullName>
        <actions>
            <name>Billing_to_Shipping_City</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Billing_to_Shipping_Country</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Billing_to_Shipping_State</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Billing_to_Shipping_Street</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Billing_to_Shipping_Zip</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Keep_Shipping_Address_in_Sync__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Keeps Shipping Address in Sync with Billing Address</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Default Days Out</fullName>
        <actions>
            <name>Daysoffset</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.c2g__CODADaysOffset1__c</field>
            <operation>equals</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Override_Days_Offset_Default__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Tasks to finalize blogger paperwork</fullName>
        <actions>
            <name>Confirm_Accounting_has_W9</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Confirm_Affiliate_Contract_is_on_File</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Get_accounting_coupon_code_name_invoice_number_and_percent</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Get_bed_to_warehouse_for_shipping</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.Referral_Type__c</field>
            <operation>equals</operation>
            <value>Affiliate,Blogger</value>
        </criteriaItems>
        <description>Tasks are created for Jason to get the affiliate agreement signed, email accounting the coupon code and W9.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>USD Default</fullName>
        <actions>
            <name>USD</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.c2g__CODAAccountTradingCurrency__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>run</fullName>
        <active>false</active>
        <formula>true</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Confirm_Accounting_has_W9</fullName>
        <assignedTo>jason@intellibed.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Confirm Accounting has W9</subject>
    </tasks>
    <tasks>
        <fullName>Confirm_Affiliate_Contract_is_on_File</fullName>
        <assignedTo>jason@intellibed.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Confirm Affiliate Contract is on File</subject>
    </tasks>
    <tasks>
        <fullName>Get_accounting_coupon_code_name_invoice_number_and_percent</fullName>
        <assignedTo>jason@intellibed.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Get accounting coupon code, name, invoice number and percent</subject>
    </tasks>
    <tasks>
        <fullName>Get_bed_to_warehouse_for_shipping</fullName>
        <assignedTo>jason@intellibed.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Get bed to warehouse for shipping</subject>
    </tasks>
</Workflow>
