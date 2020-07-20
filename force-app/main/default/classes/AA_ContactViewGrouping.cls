public with sharing class AA_ContactViewGrouping {
    
    public static list<string> cSuite = AA_UtilityClass.getCSuite;
    public static list<string> facAdmin = AA_UtilityClass.getFacAdmin;
    public static list<string> clinical = AA_UtilityClass.getClinical;
    //public static list<string> titles = AA_UtilityClass.getTitleChoices;
    //public static list<string> states = AA_UtilityClass.getRegionChoices;

    @AuraEnabled(cacheable=true)
    public static list<Contact> getRecords(ID recordId, string selectedView){
        system.debug('Chosen View: ' + selectedView);
        system.debug('Calling Record: ' + recordId);
        list<string> choice = new list<string>();
        if(selectedView == 'cSuite'){
            choice = cSuite;
            }
        else if(selectedView == 'facAdmin'){
            choice = facAdmin;
            }
        else if(selectedView == 'clinical'){
            choice = clinical;
            }
        list<Contact> contacts = new list<Contact>();
        contacts = [SELECT Name, KRS_Contact_Status__c, Title, Phone, PF_Nickname__c, Email FROM Contact WHERE Account.ID =: recordId AND Title IN: choice];
        system.debug('Contacts:' + contacts);
        return contacts;
        }

    /*
    @AuraEnabled
    public static list<string> getTitleChoices(){
        list<string> tList = titles;
        return tList;
        }

    @AuraEnabled
    public static list<string> getRegionChoices(){
        list<string> sList = states;
        return sList;
        }
        
    @AuraEnabled
    public static list<Contact> getRecordsAlt(list<string> regionFilter, string selectedView){
        system.debug('Chosen Region: ' + regionFilter);
        system.debug('Chosen View: ' + selectedView);
        string query;
        list<string> choice = new list<string>();
        if(selectedView == 'C-Suite'){
            choice = cSuite;
            }
        else if(selectedView == 'Fac-Admin'){
            choice = facAdmin;
            }
        else if(selectedView == 'Clinical'){
            choice = clinical;
            }
        list<Contact> contacts = new list<Contact>();
        if(selectedView != 'All'){
            query = 'SELECT Name, Account.Name, KRS_Contact_Status__c, Title, Phone, PF_Nickname__c, Email FROM Contact WHERE Title IN: choice';
            }
        else{
            query = 'SELECT Name, Account.Name, KRS_Contact_Status__c, Title, Phone, PF_Nickname__c, Email FROM Contact WHERE Name != null';
            }

        if(!regionFilter.contains('All')){
            query = query + ' AND Account.BillingState IN: regionFilter';
            }

        query = query + ' LIMIT 49000';

        contacts = database.query(query);
        system.debug('Contacts:' + contacts);
        return contacts;
        }
        */
}
