@isTest
private class AA_ContactViewGroupingTest {
    
    static testMethod void myUnitTest(){
        
        Account a = new Account(Name = 'Testing Account');
        insert a;

        list<Contact> toInsert = new list<Contact>();

        Contact c = new Contact(LastName = 'Testerly',
                                FirstName = 'Tim',
                                Title = 'CEO',
                                Phone = '555-555-5555',
                                Email = 'test@none.com',
                                AccountId = a.Id
                                );
        
        Contact c2 = new Contact(LastName = 'Testerly',
                                 FirstName = 'Tom',
                                 Title = 'Administrator',
                                 Phone = '444-444-4444',
                                 Email = 'test2@none.com',
                                 AccountId = a.Id
                                 );

        Contact c3 = new Contact(LastName = 'Testerly',
                                 FirstName = 'Tina',
                                 Title = 'ADON',
                                 Phone = '666-666-6666',
                                 Email = 'test3@none.com',
                                 AccountId = a.Id
                                 );
            toInsert.add(c);
            toInsert.add(c2);
            toInsert.add(c3);

            insert toInsert;

            AA_ContactViewGrouping.getRecords(a.Id, 'cSuite');
            AA_ContactViewGrouping.getRecords(a.Id, 'facAdmin');
            AA_ContactViewGrouping.getRecords(a.Id, 'clinical');
        }
    
}
