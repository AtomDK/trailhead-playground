public without sharing class DailyLeadProcessor implements Schedulable {

    public void execute(SchedulableContext ctx) {

        // Query for first 200 Leads with a null LeadSource
        List<Lead> nullLeadSourceLeads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = null LIMIT 200];

        // Update the LeadSource of the returned leads to 'Dreamforce'
        for(Lead l : nullLeadSourceLeads){
            l.LeadSource = 'Dreamforce';
        }

        // If any Leads were found, update them
        if(!nullLeadSourceLeads.isEmpty()){
            update nullLeadSourceLeads;
        }
    }
}