@isTest
public without sharing class AddPrimaryContactTest {
    
    @isTest
    private static void it_should_insert_50_ca_contacts(){
        // Set up test data
        List<Account> nyAccounts = TestDataFactory.createAccountsWithBillingState(50, 'NY');
        List<Account> caAccounts = TestDataFactory.createAccountsWithBillingState(50, 'CA');
        Contact primaryContact = new Contact(LastName = 'TestName');

        // Perform the test of adding a clone of the primaryContact to all Accounts with a BillingState of CA
        Test.startTest();
        AddPrimaryContact addPrimaryContact = new AddPrimaryContact(primaryContact, 'CA');
        System.enqueueJob(addPrimaryContact);
        Test.stopTest();

        // Query for Contacts related to the Accounts to assert the test worked correctly
        List<Contact> caContactList = [SELECT Id FROM Contact WHERE Account.BillingState = 'CA'];
        List<Contact> nyContactList = [SELECT Id FROM Contact WHERE Account.BillingState = 'NY'];

        // Query for the CA Accounts to assert 1 Contact created per account
        List<Account> caAccountResultList = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE BillingState = 'CA'];

        // Assert 50 Contacts were created related to the CA Accounts, and each CA Account has 1 Contact
        Assert.areEqual(50, caContactList.size(), 'Expecting 50 Contacts related to Accounts with a billing state of CA');
        Assert.areEqual(0, nyContactList.size(), 'Not expecting any Contacts related to Accounts with a billing state of NY');
        for(Account a : caAccountResultList){
            Assert.areEqual(1, a.Contacts.size(), 'Expecting to find 1 Contact per Account');
        }
    }
}