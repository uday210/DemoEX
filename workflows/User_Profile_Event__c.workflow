<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Ismatchmaking User</fullName>
        <field>IsMatchMakingUser__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>MAking Ismatchmaking true for MBE</fullName>
        <actions>
            <name>Ismatchmaking User</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>User_Profile_Event__c.MAtchMakingProfile__c</field>
            <operation>equals</operation>
            <value>MBE</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
