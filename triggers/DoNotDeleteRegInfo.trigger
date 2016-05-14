trigger DoNotDeleteRegInfo on Dummay__c (Before Delete) {
    LIST<Dummay__c> RegInfosList= trigger.Old;
    system.debug(RegInfosList.size()+'  SIZE OF REG INFO '+RegInfosList);
    if(RegInfosList.size() >0){
        for(Dummay__c reg: RegInfosList){
            reg.addError('Do Not Delete Payment Details!');
        }
    }
}