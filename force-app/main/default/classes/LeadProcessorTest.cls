@isTest
public without sharing class LeadProcessorTest {
    
    @isTest
    private static void it_should_update_lead_source(){

        // Creating 200 leads and calling the batchable to update their LeadSource to Dreamforce
        TestDataFactory.createLeads(200);

        Test.startTest();
        LeadProcessor leadProcessor = new LeadProcessor();
        Database.executeBatch(leadProcessor);
        Test.stopTest();

        List<Lead> updatedLeadList = [SELECT Id, LeadSource FROM Lead];

        List<Lead> correctlyUpdatedLeads = new List<Lead>();
        List<Lead> notUpdatedLeads = new List<Lead>();

        for(Lead l : updatedLeadList){
            if(l.LeadSource == 'Dreamforce'){
                correctlyUpdatedLeads.add(l);
            } else {
                notUpdatedLeads.add(l);
            }
        }

        Assert.areEqual(200, correctlyUpdatedLeads.size(), 'Expecting to find all 200 leads with an updated LeadSource of Dreamforce');
        Assert.areEqual(0, notUpdatedLeads.size(), 'Not expecting to find any leads without a LeadSource of Dreamforce');
    }

    @isTest
    private static void no_lead_source_should_be_update(){

        List<Lead> leadList = TestDataFactory.createLeads(10);

        List<Lead> dreamforceLeads = new List<Lead>();
        List<Lead> nullSourceLeads = new List<Lead>();

        for(Lead l : leadList){
            if(l.LeadSource == 'Dreamforce'){
                dreamforceLeads.add(l);
            } else {
                nullSourceLeads.add(l);
            }
        }

        Assert.areEqual(0, dreamforceLeads.size(), 'Expecting to have 0 leads with a LeadSource of Dreamforce');
        Assert.areEqual(10, nullSourceLeads.size(), 'Expecting to find 10 leads without a LeadSource');
    }
}