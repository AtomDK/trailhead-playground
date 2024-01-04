@IsTest
public without sharing class ParkLocatorTest {
    
    @IsTest
    public static void testCallout(){
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        // Call the method that invokes a callout
        String[] expectedParks = new String[]{'Hamburg Wadden Sea National Park', 'Hainich National Park', 'Bavarian Forest National Park'};
        String[] actualParks = ParkLocator.country('Germany');
        // Verify that a fake result is returned
        System.assertEquals(expectedParks, actualParks, 'Fake result was not returned as expected'); 
    }
}