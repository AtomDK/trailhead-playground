@IsTest
public without sharing class AccountManagerTest {
    @isTest static void testGetAccountById() {
        
        // Set up test data
        List<Account> accountList = TestDataFactory.createAccounts(1);
        String contactId = TestDataFactory.createContactsForAccounts(accountList, 1)[0].Id;

        String accountId = accountList[0].Id;
        
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://empathetic-unicorn-av4mi7-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Accounts/'
            + accountId + '/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();

        // Verify results
        Assert.areNotEqual(null, thisAccount, 'A non-null Account should have been returned');
        Assert.areEqual(accountId, thisAccount.Id, 'The returned Account Id should match the test Account Id');
        Assert.areEqual(1, thisAccount.Contacts.size(), 'The returned Account should only have 1 Contact related');
    }
}