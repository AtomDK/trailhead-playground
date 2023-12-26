@isTest
public without sharing class TestRestrictContactByName {
    
    @isTest
    public static void it_should_insert_two_and_prevent_one(){

        List<Contact> contactList = new List<Contact>();
        List<Database.SaveResult> successList = new List<Database.SaveResult>();
        List<Database.SaveResult> errorList = new List<Database.SaveResult>();


        Contact invalidContact = new Contact();
        invalidContact.Email = 'atomkeller+test@gmail.com';
        invalidContact.FirstName = 'Adam Test';
        invalidContact.LastName = 'INVALIDNAME';
        contactList.add(invalidContact);

        Contact validContactOne = new Contact();
        validContactOne.Email = 'atomkeller+test1@gmail.com';
        validContactOne.FirstName = 'Adam Test';
        validContactOne.LastName = 'Valid Name';
        contactList.add(validContactOne);

        Contact validContactTwo = new Contact();
        validContactTwo.Email = 'atomkeller+test2@gmail.com';
        validContactTwo.FirstName = 'Adam Test';
        validContactTwo.LastName = 'Valid Name';
        contactList.add(validContactTwo);

        Test.startTest();
        List<Database.SaveResult> insertResultList = Database.insert(contactList, false);
        Test.stopTest();

        for(Database.SaveResult result : insertResultList){
            if(result.isSuccess()){
                successList.add(result);
            } else {
                errorList.add(result);
            }
        }

        Assert.areEqual(3, insertResultList.size(), 'Should have attempted to insert 3');
        Assert.areEqual(2, successList.size(), 'There should be 2 successes');
        Assert.areEqual(1, errorList.size(), 'There should be 1 error');
        
    }
}