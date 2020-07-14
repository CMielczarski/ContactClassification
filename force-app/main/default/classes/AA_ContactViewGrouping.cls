public with sharing class AA_ContactViewGrouping {
    
    public static list<string> cSuite = AA_UtilityClass.getCSuite;
    public static list<string> facAdmin = AA_UtilityClass.getFacAdmin;
    public static list<string> clinical = AA_UtilityClass.getClinical;

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
        contacts = [SELECT Name, KRS_Contact_Status__c, Title, Phone, KRS_Extension__c, Email FROM Contact WHERE Account.ID =: recordId AND Title IN: choice];
        system.debug('Contacts:' + contacts);
        return contacts;
        }
    
}
