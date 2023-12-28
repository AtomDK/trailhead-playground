public without sharing class AccountProcessor {

     @future
     public static void countContacts(List<Id> accountIds){
        Map<Id, Integer> accountToContactCountMap = new Map<Id, Integer>();

        for (Contact c : [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIds]) {
            Integer count = accountToContactCountMap.get(c.AccountId);
            accountToContactCountMap.put(c.AccountId, (count == null) ? 1 : count + 1);
        }

        List<Account> accountListToUpdate = new List<Account>();

        for (Account a : [SELECT Id, Number_Of_Contacts__c FROM Account WHERE Id IN :accountIds]) {
            Integer contactCount = accountToContactCountMap.get(a.Id);
            a.Number_Of_Contacts__c = (contactCount == null) ? 0 : contactCount;
            accountListToUpdate.add(a);
        }

        update accountListToUpdate;
     }

}