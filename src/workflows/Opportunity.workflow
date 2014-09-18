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
        <fullName>OpportunityCloser</fullName>
        <actions>
            <name>ClosureLimit</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.IsClosed</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Override the default close date from the close of the quarter to six months after the opportunity is created.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
