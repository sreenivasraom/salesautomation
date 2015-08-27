<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>Status Update</fullName>
        <actions>
            <name>Send_to_Approval</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Order__c.Quantity__c</field>
            <operation>greaterOrEqual</operation>
            <value>6</value>
        </criteriaItems>
        <description>Demo Time</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
