<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Promotion Inactive FU</fullName>
        <description>To make status field inactive 1 day after the expire day</description>
        <field>Status__c</field>
        <literalValue>Inactive</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Promotion Inactive FU</fullName>
        <description>To make the status of promotion Inactive after the expire date.</description>
        <field>Status__c</field>
        <literalValue>Inactive</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Promotion Inactive</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Promotion__c.Exp_TimeStamp__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>This Workflow is to make Promotion Inactive after the end of Expire Date.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
