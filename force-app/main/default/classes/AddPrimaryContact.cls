public without sharing class AddPrimaryContact implements Queueable {
    
    private Contact con;
    private String state;
    
    public AddPrimaryContact(Contact con, String state) {
        this.con = con;
        this.state = state;
    }

     public void execute(QueueableContext context){
        List<Account> accounts = [SELECT Id FROM Account WHERE BillingState = :state LIMIT 200];
        List<Contact> contacts = new List<Contact>();

        for(Account a : accounts){
            Contact conClone = con.clone();
            conClone.AccountId = a.Id;
            contacts.add(conClone);
        }

        if(!contacts.isEmpty()){
            insert contacts;
        }
     }
}