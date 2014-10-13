<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>ClosureLimit</fullName>
        <field>CloseDate</field>
        <formula>DATE( YEAR(TODAY()) , (MONTH(TODAY()) + 6), DAY(TODAY()))</formula>
        <name>ClosureLimit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>OpportunityClosure</fullName>
        <actions>
            <name>ClosureLimit</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.IsClosed</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This is Opportunity Closure description</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
