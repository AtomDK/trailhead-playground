@isTest
public class TestDataFactory {
    public static List<Account> createAccountsWithOpps(Integer numAccts, Integer numOppsPerAcct) {
        List<Account> accts = new List<Account>();
        for(Integer i=0;i<numAccts;i++) {
            Account a = new Account(Name='TestAccount' + i);
            accts.add(a);
        }
        insert accts;
        List<Opportunity> opps = new List<Opportunity>();
        for (Integer j=0;j<numAccts;j++) {
            Account acct = accts[j];
            // For each account just inserted, add opportunities
            for (Integer k=0;k<numOppsPerAcct;k++) {
                opps.add(new Opportunity(Name=acct.Name + ' Opportunity ' + k,
                                       StageName='Prospecting',
                                       CloseDate=System.today().addMonths(1),
                                       AccountId=acct.Id));
            }
        }
        // Insert all opportunities for all accounts.
        insert opps;
        return accts;
    }

    /**
     * @description Creates a specified number of Contacts for each Account passed in
     * @param List<Account> Accounts for the Contacts to be related to
     * @param Integer number of Contacts to create
     * @return List<Contact> newly inserted Contacts
     */
    public static List<Contact> createContactsForAccounts(List<Account> accountList, Integer numContacts){
        List<Contact> contacts = new List<Contact>();

        for(Integer i = 0; i < accountList.size(); i++){

            for(Integer j = 0; j < numContacts; j++){
                Contact c = new Contact(LastName = 'Test ' + j, AccountId = accountList[i].Id);
                contacts.add(c);
            }
        }
        
        insert contacts;
        return contacts;
    }

    /**
     * @description Creates a specified number of Accounts
     * @param Integer number of Accounts to create
     * @return List<Account> newly inserted Accounts
     */
    public static List<Account> createAccounts(Integer numAccounts){
        List<Account> accounts = new List<Account>();

        for(Integer i = 0; i < numAccounts; i++){
            Account a = new Account(Name = 'Test ' + i);
            accounts.add(a);
        }

        insert accounts;
        return accounts;
    }

    /**
     * @description Creates a specified number of Leads
     * @param Integer number of Leads to create
     * @return List<Lead> newly inserted Leads
     */
    public static List<Lead> createLeads(Integer numLeads){
        List<Lead> leads = new List<Lead>();

        for(Integer i = 0; i < numLeads; i++){
            leads.add(new Lead(Company = 'Test Company', LastName = 'Test LastName'));
        }

        insert leads;
        return leads;
    }
}