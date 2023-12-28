public without sharing class AccountProcessor {

    // /**
    //  * First iteration, 2 SOQL for loops
    //  * Speed = 102 (97), heap = 2682
    //  */
    //  @future
    //  public static void countContactsOne(List<Id> accountIds){
    //     Map<Id, Integer> accountToContactCountMap = new Map<Id, Integer>();

    //     for (Contact c : [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIds]) {
    //         Integer count = accountToContactCountMap.get(c.AccountId);
    //         accountToContactCountMap.put(c.AccountId, (count == null) ? 1 : count + 1);
    //     }

    //     List<Account> accountListToUpdate = new List<Account>();

    //     for (Account a : [SELECT Id, Number_Of_Contacts__c FROM Account WHERE Id IN :accountIds]) {
    //         Integer contactCount = accountToContactCountMap.get(a.Id);
    //         a.Number_Of_Contacts__c = (contactCount == null) ? 0 : contactCount;
    //         accountListToUpdate.add(a);
    //     }

    //     if(!accountListToUpdate.isEmpty()){
    //         update accountListToUpdate;
    //     }
    //  }

    // /**
    //  * Second iteration, 1 SOQL query and 1 for loop
    //  * Speed = 92 (82), heap = 4321
    //  */
    // @future
    // public static void countContactsTwo(List<Id> accountIds) {

    //     // Query for the number of contacts associated with all Account IDs
    //     List<Account> accountsWithContacts = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accountIds];

    //     // Populate the map with the count of contacts for each Account
    //     for (Account acc : accountsWithContacts) {
    //         acc.Number_Of_Contacts__c = acc.Contacts.size();
    //     }

    //     // Update the Account records
    //     if (!accountsWithContacts.isEmpty()) {
    //         update accountsWithContacts;
    //     }
    // }

    // /** 
    //  * Third iteration, one SOQL for loop
    //  * Speed = 119 (105), heap = 2676
    //  */
    // @future
    // public static void countContactsThree(List<Id> accountIds) {

    //     List<Account> accountsToUpdate = new List<Account>();
        
    //     for (Account acc : [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accountIds]) {
    //         accountsToUpdate.add(new Account(Id = acc.Id, Number_Of_Contacts__c = acc.Contacts.size()));
    //     }

    //     // Update the Account records
    //     if (!accountsToUpdate.isEmpty()) {
    //         update accountsToUpdate;
    //     }
    // }

    /**
     * Fourth iteration, one SOQL for loop 
     * Speed = 101 (87), heap = 2647
     */
    @future
    public static void countContacts(List<Id> accountIds) {

        List<Account> accountsToUpdate = new List<Account>();
        
        for (Account acc : [SELECT Id, Number_Of_Contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accountIds]) {
            acc.Number_Of_Contacts__c = acc.Contacts.size();
            accountsToUpdate.add(acc);
        }

        // Update the Account records
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }

}