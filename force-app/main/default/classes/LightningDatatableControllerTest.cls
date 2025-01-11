@isTest
public class LightningDatatableControllerTest {
    @TestSetup
    static void makeData(){
        Account a = new Account();
        a.name='superuberuniqueaccountfortest';
        insert a;

        Contact c = new Contact();
        c.AccountId = a.Id;
        c.FirstName = 'First';
        c.LastName = 'Last';
        c.Email = 'uniquefosho@email.com';
        insert c;
    }
    
    @isTest
    static void pageControllerWithNameTestMethod(){
        Account a = [Select Id From Account WHERE Name='superuberuniqueaccountfortest'];
        Contact c = [Select Id, Name, Email, CreatedDate From Contact Where FirstName = 'First' AND LastName = 'Last'];
        Contact[] results = LightningDatatableController.getContacts(a.Id, c.Name, '', 2);
        Contact[] contactList = new List<Contact>();
        contactList.add(c);
        System.assertEquals(results, contactList);
    }

    @isTest
    static void pageControllerWithEmailTestMethod(){
        Account a = [Select Id From Account WHERE Name='superuberuniqueaccountfortest'];
        Contact c = [Select Id, Name, Email, CreatedDate From Contact Where FirstName = 'First' AND LastName = 'Last'];
        Contact[] results = LightningDatatableController.getContacts(a.Id, '', c.Email, 2);
        Contact[] contactList = new List<Contact>();
        contactList.add(c);
        System.assertEquals(results, contactList);
    }
}