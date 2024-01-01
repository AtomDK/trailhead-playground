@IsTest
public with sharing class DailyLeadProcessorTest {

    @IsTest
    private static void it_should_update_leadsource_from_null(){
        
        // Set up dummy cron expression
        String CRON_EXP = '0 0 0 15 3 ? 2100';

        // Create leads for testing with null leadsource
        List<Lead> leads = new List<Lead>();
        for(Integer i = 0; i < 200; i++){
            leads.add(new Lead(Company = 'Test LeadSource Update', LastName = 'Test LastName'));
        }
        insert leads;
        
        // Start the test and verify the LeadSource is null
        Test.startTest();
        List<Lead> leadsPreJobRun = [SELECT Id, LeadSource FROM Lead WHERE Company = 'Test LeadSource Update' LIMIT 200];
        
        for(Lead l : leadsPreJobRun){
            Assert.areEqual(null, leadsPreJobRun[0].LeadSource, 'The LeadSource should be null before the update occurs');
        }

        // Schedule the job then stop the test so the job runs synchronously
        System.schedule('TestLeadSourceUpdate', CRON_EXP, new DailyLeadProcessor());
        Test.stopTest();

        // Query for the leads post-job-run and verify the LeadSource was updated to Dreamforce as expected
        List<Lead> leadsPostJobRun = [SELECT Id, LeadSource FROM Lead WHERE Company = 'Test LeadSource Update' LIMIT 200];
        for(Lead l : leadsPostJobRun){
            Assert.areEqual('Dreamforce', l.LeadSource);
        }

    }
}