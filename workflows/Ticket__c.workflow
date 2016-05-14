<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Copy ParentId</fullName>
        <field>praentidworkflowfill__c</field>
        <formula>Parent_ID__c</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy ParentIds</fullName>
        <field>praentidworkflowfill__c</field>
        <formula>Parent_ID__c</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Ticket</fullName>
        <field>Ticket_Status__c</field>
        <literalValue>Available</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Updatefield</fullName>
        <field>Ticket_Status__c</field>
        <literalValue>Available</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Copy Parentid in ticket</fullName>
        <actions>
            <name>Copy ParentIds</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>1==1</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>revertbacktoavailble</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Ticket__c.Ticket_Status__c</field>
            <operation>equals</operation>
            <value>Abandoned</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
