<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Text Lead Rating</fullName>
        <field>Lead_Rating__c</field>
        <formula>TEXT(BVS_LeadRating__c)</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Lead Rating</fullName>
        <actions>
            <name>Text Lead Rating</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>BoothVisitSummary__c.BVS_LeadRating__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>For Report by Lead Rating Dashboard</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
