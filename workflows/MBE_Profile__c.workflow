<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Updating Secondary Email with MBE Email</fullName>
        <field>AS_Secondary_Email__c</field>
        <formula>AS_Email__c</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Rule on Secondary Email for Custom Event%2FMBE Profile</fullName>
        <actions>
            <name>Updating Secondary Email with MBE Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>MBE_Profile__c.AS_Secondary_Email__c</field>
            <operation>equals</operation>
            <value>Null</value>
        </criteriaItems>
        <criteriaItems>
            <field>MBE_Profile__c.AS_Secondary_Email__c</field>
            <operation>equals</operation>
            <value>&quot; &quot;</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
