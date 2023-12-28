@isTest
public without sharing class AccountProcessorTest {
    
    @isTest
    private static void it_should_count_1_contact(){

        // Set up test account data
        List<Account> accountList = TestDataFactory.createAccounts(1);
        
        // Set up test Contact data
        TestDataFactory.createContactsForAccounts(accountList, 1);

        // Get AccountIds for countContacts method
        List<Id> accountIds = new List<Id>((new Map<Id, SObject>(accountList).keySet()));

        Test.startTest();
        AccountProcessor.countContacts(accountIds);
        Test.stopTest();

        List<Account> results = [SELECT Id, Number_Of_Contacts__c
                                FROM Account
                                WHERE Id IN :accountIds];

        Assert.areEqual(1, results[0].Number_Of_Contacts__c, 'Expecting the Number of Contacts to equal the number created in the test');
    }

    @isTest
    private static void it_should_count_3_contacts_and_0_contacts(){

        List<Account> accountList = new List<Account>();

        // Set up test account data
        Account firstAccount = TestDataFactory.createAccounts(1)[0];
        
        // Set up test Contact data for firstAccount
        TestDataFactory.createContactsForAccounts((new List<Account>{firstAccount}), 3);

        // Set up another test Account but without Contacts
        Account secondAccount = TestDataFactory.createAccounts(1)[0];

        Test.startTest();
        AccountProcessor.countContacts(new List<Id>{firstAccount.Id, secondAccount.Id});
        Test.stopTest();

        Account accountOne = [SELECT Number_Of_Contacts__c
                            FROM Account
                            WHERE Id = :firstAccount.Id
                            LIMIT 1];
        
        Account accountTwo = [SELECT Number_Of_Contacts__c
                            FROM Account
                            WHERE Id = :secondAccount.Id
                            LIMIT 1];

        Assert.areEqual(3, accountOne.Number_Of_Contacts__c, 'Expecting the Number of Contacts to equal the number created in the test for accountOne');
        Assert.areEqual(0, accountTwo.Number_Of_Contacts__c, 'Expecting the Number of Contacts to equal the number created in the test for accountTwo');
    }
}