<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>BadgePrintStatus_FU</fullName>
        <field>EA_isBadgePrinted__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IsmatchmakingTrue</fullName>
        <description>Making IsMatchmakingAttendd as true</description>
        <field>IsMatchMakingAttendee__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateAttendeeSourceField</fullName>
        <field>Attendee_Source__c</field>
        <literalValue>Walk Ins</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Updating</fullName>
        <field>Update_With_CreatedDate__c</field>
        <formula>CreatedDate</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Field with CreatedDate</fullName>
        <actions>
            <name>Updating</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event_Attendee_Mapping__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UpdateAttendeeSource</fullName>
        <actions>
            <name>UpdateAttendeeSourceField</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>EV_id__r.EV_StartDate__c == Update_With_CreatedDate__c</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>ismatchmaking</fullName>
        <actions>
            <name>IsmatchmakingTrue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event_Attendee_Mapping__c.Attendee_Types__c</field>
            <operation>contains</operation>
            <value>MBE</value>
        </criteriaItems>
        <description>This is written by mythily for making is matchmaking checkbox as true while an event admin adds an attendee with the type as MBE.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
