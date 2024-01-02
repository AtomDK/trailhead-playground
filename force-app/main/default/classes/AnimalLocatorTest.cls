@IsTest
public without sharing class AnimalLocatorTest {

    @IsTest
    private static void test_get_callout(){
        // Set up test data
        Integer animalId = 1;
        String expectedBody = '{"animal":{"id":1,"name":"chicken","eats":"chicken food","says":"cluck cluck"}}';
        
        // Set up mock
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());

        // Make callout
        String animalName = AnimalLocator.getAnimalNameById(animalId);

        // Make assertion
        Assert.areEqual('chicken', animalName);
    }
}