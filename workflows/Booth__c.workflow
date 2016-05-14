<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>update tableNo</fullName>
        <field>BT_Location__c</field>
        <formula>&quot;Room 21/22/23&quot;</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>update tableNo</fullName>
        <actions>
            <name>update tableNo</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>EV_id__r.Name  = &apos;QR_EVT_2213_0034984&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
