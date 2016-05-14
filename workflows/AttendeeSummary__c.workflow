<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>BusinessRevenue</fullName>
        <field>updateRevenue__c</field>
        <formula>TEXT(Revenueupdate__c)</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FU on PrimaryBusinessCategory1</fullName>
        <field>AS_PrimaryBusinessCategory__c</field>
        <formula>TEXT(AS_PrimaryBusinessCategory1__c)</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FU_on_WorkState_picklist_to_textfield</fullName>
        <field>AS_WorkState__c</field>
        <formula>TEXT(AS_Work_States__c)</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Updating Secondary Email with Email</fullName>
        <field>AS_Secondary_Email__c</field>
        <formula>AS_Email__c</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>FU On NAICSCode1</fullName>
        <active>false</active>
        <criteriaItems>
            <field>AttendeeSummary__c.As_NAICSCode_1__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>AttendeeSummary__c.AS_NAICSCode1__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>FU on PrimaryBusinessCategory</fullName>
        <actions>
            <name>FU on PrimaryBusinessCategory1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AttendeeSummary__c.AS_PrimaryBusinessCategory1__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>FU_on_WorkState_picklist_to_textfield</fullName>
        <actions>
            <name>FU_on_WorkState_picklist_to_textfield</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AttendeeSummary__c.AS_Work_States__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>RevenueupdateRule1</fullName>
        <actions>
            <name>BusinessRevenue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AttendeeSummary__c.Revenueupdate__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Rule on Secondary Email</fullName>
        <actions>
            <name>Updating Secondary Email with Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>AttendeeSummary__c.AS_Secondary_Email__c</field>
            <operation>equals</operation>
            <value>Null</value>
        </criteriaItems>
        <criteriaItems>
            <field>AttendeeSummary__c.AS_Secondary_Email__c</field>
            <operation>equals</operation>
            <value>&quot; &quot;</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
