<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Backdate_HC_enroll_date</fullName>
        <description>Back dates HC enroll date so it doesn&apos;t affect current reports.</description>
        <field>Enrolled_in_HC__c</field>
        <formula>DATE(1999,01,01)</formula>
        <name>Backdate HC enroll date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Pillows_in_Clinic</fullName>
        <description>Pillows in clinic will equal true if kit is ordered.</description>
        <field>Pillows_in_Clinic__c</field>
        <literalValue>1</literalValue>
        <name>Pillows in Clinic</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Contact_RecordType_Hospitality</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Hospitality</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set Contact RecordType Hospitality</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Contact_RecordType_Wholesale</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Wholesale</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set Contact RecordType Wholesale</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Contact_Record_Type_Affiliate</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Affiliate</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set Contact Record Type Affiliate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_HCR_Paid_Field</fullName>
        <description>Updates the HCR paid field to yes if the lead source is house call</description>
        <field>HCR_Paid_by_Client__c</field>
        <literalValue>Y</literalValue>
        <name>Update HCR Paid Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Blogger</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Record_Type_based_on_PPC</fullName>
        <field>RecordTypeId</field>
        <lookupValue>PPC</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Record Type based on PPC</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Record_Type_based_on_Sales_Center</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Sales_Center</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Record Type based on Sales Center</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Record_Type_based_on_lead_Doctor</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Doctor</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Record Type based on lead Doctor</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Salutation</fullName>
        <description>Update the salutation to Dr when the Profession is updated to DC or MD</description>
        <field>Salutation</field>
        <literalValue>Dr.</literalValue>
        <name>Update Salutation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Profession changes salutation</fullName>
        <actions>
            <name>Update_Salutation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Profession__c</field>
            <operation>equals</operation>
            <value>DC,MD</value>
        </criteriaItems>
        <description>If Profession is Doctor salutation is updated to Dr as well.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SFDC TEST2</fullName>
        <active>false</active>
        <booleanFilter>(1 or 2) and 3 and ((4 and 5) or 6)</booleanFilter>
        <criteriaItems>
            <field>Contact.LastModifiedById</field>
            <operation>contains</operation>
            <value>Cameron</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.LastModifiedById</field>
            <operation>equals</operation>
            <value>Josh</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Coupon_Code_Used_to_Purchase__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Purchase_Date__c</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Purchase_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.CreatedDate</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SW Enrolled in DC Program</fullName>
        <actions>
            <name>Create_coupon_campaign</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Enrolled_in_Referral_Program__c</field>
            <operation>equals</operation>
            <value>Y</value>
        </criteriaItems>
        <description>When enrolled in DC program = yes a &apos;task&apos; is set for Terry to Setup coupon and email dr.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SW HC Lead Source</fullName>
        <actions>
            <name>Backdate_HC_enroll_date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_HCR_Paid_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Contact.LeadSource</field>
            <operation>startsWith</operation>
            <value>HC</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.LeadSource</field>
            <operation>contains</operation>
            <value>Housecall</value>
        </criteriaItems>
        <description>If lead source if from housecall then HCR paid by client = yes</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SW Reminder for Staff Training</fullName>
        <actions>
            <name>Reminder_email_for_staff_training</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Contact.Date_of_Staff_Training__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Date_Time_Staff_Training__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>When staff training is scheduled creates a task 1 day before for Terry as a reminder to email Dr.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SW Welcome Kit ordered</fullName>
        <actions>
            <name>Order_desk_display</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Send_Welcome_Kit_intelliPillow</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Welcome_Kit_Shipped__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>When someone orders a welcome kit this rule will task Terry</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Task for Al for referral sales</fullName>
        <actions>
            <name>Referral_Source_TY_email_contact_update</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <booleanFilter>(1 or 2) and 3 and (4 or 5)</booleanFilter>
        <criteriaItems>
            <field>Contact.LastModifiedById</field>
            <operation>equals</operation>
            <value>Cameron @ Team intelliBED</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.LastModifiedById</field>
            <operation>equals</operation>
            <value>Josh @ Team intelliBED</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Coupon_Code_Used_to_Purchase__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Purchase_Date__c</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.CreatedDate</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <description>This will task Al so he can update the bloggers and doctors when their patient purchases.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Task for incentive for staff</fullName>
        <actions>
            <name>Incentive_for_staff</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Incentive_for_Staff__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Date_of_last_bed_sale__c</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <description>If the staff is incentivized Terry is tasked.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Record Type based on lead Affiliate</fullName>
        <actions>
            <name>Set_Contact_Record_Type_Affiliate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(
OR( NOT( ISBLANK( Contact_Record_Type_Text__c ) ), 
 NOT( ISNULL( Contact_Record_Type_Text__c ) ))
, CONTAINS( Contact_Record_Type_Text__c , &quot;Affiliate&quot;)  )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Record Type based on lead Blogger</fullName>
        <actions>
            <name>Update_Record_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(
OR( NOT( ISBLANK( Contact_Record_Type_Text__c ) ), 
 NOT( ISNULL( Contact_Record_Type_Text__c ) ))
, CONTAINS( Contact_Record_Type_Text__c , &quot;Blogger&quot;)  )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Record Type based on lead Doctor</fullName>
        <actions>
            <name>Update_Record_Type_based_on_lead_Doctor</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(
OR( NOT( ISBLANK( Contact_Record_Type_Text__c ) ), 
 NOT( ISNULL( Contact_Record_Type_Text__c ) ))
, CONTAINS( Contact_Record_Type_Text__c , &quot;Doctor&quot;)  )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Record Type based on lead Hospitality</fullName>
        <actions>
            <name>Set_Contact_RecordType_Hospitality</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(
OR( NOT( ISBLANK( Contact_Record_Type_Text__c ) ), 
 NOT( ISNULL( Contact_Record_Type_Text__c ) ))
, CONTAINS( Contact_Record_Type_Text__c , &quot;Hospitality&quot;)  )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Record Type based on lead PPC</fullName>
        <actions>
            <name>Update_Record_Type_based_on_PPC</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(
OR( NOT( ISBLANK( Contact_Record_Type_Text__c ) ), 
 NOT( ISNULL( Contact_Record_Type_Text__c ) ))
, CONTAINS( Contact_Record_Type_Text__c , &quot;PPC&quot;)  )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Record Type based on lead Sales Center</fullName>
        <actions>
            <name>Update_Record_Type_based_on_Sales_Center</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(
OR( NOT( ISBLANK( Contact_Record_Type_Text__c ) ), 
 NOT( ISNULL( Contact_Record_Type_Text__c ) ))
, CONTAINS( Contact_Record_Type_Text__c , &quot;Customer&quot;)  )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Record Type based on lead Wholesale</fullName>
        <actions>
            <name>Set_Contact_RecordType_Wholesale</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(
OR( NOT( ISBLANK( Contact_Record_Type_Text__c ) ), 
 NOT( ISNULL( Contact_Record_Type_Text__c ) ))
, CONTAINS( Contact_Record_Type_Text__c , &quot;Wholesale&quot;)  )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>sfdc test</fullName>
        <active>false</active>
        <booleanFilter>(1 OR 2) AND ((3 AND 4) OR 5)</booleanFilter>
        <criteriaItems>
            <field>Contact.LastModifiedById</field>
            <operation>contains</operation>
            <value>Cameron @ Team intelliBED</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.LastModifiedById</field>
            <operation>contains</operation>
            <value>Josh @ Team intelliBED</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Purchase_Date__c</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Product_Purchased__c</field>
            <operation>notEqual</operation>
            <value>NULL</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.CreatedDate</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Create_Coupon_code_web_access_for_doc</fullName>
        <assignedTo>sjensen@intellibed.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Create Coupon code &amp; web access for doc</subject>
    </tasks>
    <tasks>
        <fullName>Create_coupon_campaign</fullName>
        <assignedTo>bridgerk@intellibed.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Create coupon code and campaign</subject>
    </tasks>
    <tasks>
        <fullName>Incentive_for_staff</fullName>
        <assignedTo>terry@intellibed.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>60</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Incentive for staff (make sure the bed wasn&apos;t returned)</subject>
    </tasks>
    <tasks>
        <fullName>Order_desk_display</fullName>
        <assignedTo>terry@intellibed.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Order desk display &amp; pads</subject>
    </tasks>
    <tasks>
        <fullName>Referral_Source_TY_email_contact_update</fullName>
        <assignedTo>al@intellibed.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Referral Source TY email/contact update</subject>
    </tasks>
    <tasks>
        <fullName>Reminder_email_for_staff_training</fullName>
        <assignedTo>terry@intellibed.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>-1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Contact.Date_of_Staff_Training__c</offsetFromField>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Reminder email for staff training</subject>
    </tasks>
    <tasks>
        <fullName>Send_Welcome_Kit_intelliPillow</fullName>
        <assignedTo>terry@intellibed.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>5</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>In Progress</status>
        <subject>Send Welcome Kit + intelliPillow</subject>
    </tasks>
    <tasks>
        <fullName>Setup_coupon_code_c</fullName>
        <assignedTo>terry@intellibed.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Create Coupon Code</subject>
    </tasks>
    <tasks>
        <fullName>Shipping_update_HARD_TIME_Welcome_Kit_and_Pillow</fullName>
        <assignedTo>sean@intellibed.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Shipping update (HARD TIME) Welcome Kit and Pillow</subject>
    </tasks>
</Workflow>
