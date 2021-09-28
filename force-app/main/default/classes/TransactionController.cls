public class TransactionController {
    public Date issueDate{get;set;}
    public Date expectedReturnDate{get;set;}
    public decimal tp{get;set;}
    public String selectedId{get;set;}
    public Date birthdayDate{get;set;}
    public String email{get;set;}
    public String firstName{get;set;}
    public String lastName{get;set;}
    List<selectOption> vehicleOptions = new List<selectOption>();
    public List<selectOption> getCarNames() {
        for(Vehicle__c vn : [SELECT Name FROM Vehicle__c WHERE Status__c != 'Lost/Stolen' OR Status__c != 'Decomissioned']) {
            vehicleOptions.add(new selectOption(vn.Id, vn.Name));
        }
        return vehicleOptions;
    }
    public void totalPrice(){
        if(issueDate == null || expectedReturnDate == null){
            return;
        }
        else{
        tp = issueDate.daysBetween(expectedReturnDate) * 25.77;
        }
    }
    public PageReference saveRecord() {
        Rental_Contract__c newRental = new Rental_Contract__c();
        List<Contact> existingContacts = [SELECT id, email FROM Contact WHERE Email = :email];
        if(existingContacts.size() == 0) {
            Contact customer = new Contact(FirstName = firstName, LastName= lastName, Birthdate = birthdayDate, Email = email);
            insert customer;
            newRental.Customer__c = customer.Id;
        } else {
            newRental.Customer__c = existingContacts[0].id;
        }
        newRental.Issue_Date__c = issueDate;
        newRental.Expected_Return_Date__c = expectedReturnDate; 
        newRental.Status__c = 'Active';
        newRental.Vehicle__c = selectedId;
        List<Vehicle__c> vehicleDepot = [SELECT id, stationed_Depot__c FROM Vehicle__c WHERE id =: selectedId]; 
        newRental.Issuing_Depot__c = vehicleDepot[0].stationed_Depot__c;
        List<Depot__c> depotList = [SELECT id, Owner__c FROM Depot__c WHERE id =: vehicleDepot[0].stationed_Depot__c];
        newRental.Company__c = depotList[0].Owner__c;
        insert newRental;
        PageReference pageRef = new PageReference('/apex/thankYou');
        pageRef.getParameters().put('depot_id',System.currentPageReference().getParameters().get('depot_id'));
        return pageRef;
    }
}