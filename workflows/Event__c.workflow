<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Event Site Location Rule</fullName>
        <field>EV_SiteLocation__c</field>
        <formula>SUBSTITUTE( EV_Title__c, &apos; &apos;, &apos;&apos;)</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Front colors</fullName>
        <field>Registration_Front_End_Color__c</field>
        <formula>&apos;#ff2500&apos;</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update colors</fullName>
        <field>Registration_Back_End_Color__c</field>
        <formula>&apos;#FFFFFF&apos;</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Event Site Location Rule</fullName>
        <actions>
            <name>Event Site Location Rule</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event__c.EV_HostingTimeZone__c</field>
            <operation>equals</operation>
            <value>Indian Standard Time(IST),Eastern Time(USA),Central Time(USA),Pacific Time(USA),Mountain Time(USA)</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Updating Colors</fullName>
        <actions>
            <name>Update Front colors</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update colors</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Website URL</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Event__c.CreatedDate</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
