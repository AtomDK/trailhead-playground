public with sharing class RandomContactFactory {

    public static List<Contact> generateRandomContacts(Integer numToCreate, String lastName){

        List<Contact> contactList = new List<Contact>();
        
        for(Integer i = 0; i < numToCreate; i++){
            Contact c = new Contact();
            c.FirstName = 'Test ' + i;
            c.LastName = lastName;
            contactList.add(c);
        }

        return contactList;
    }
}