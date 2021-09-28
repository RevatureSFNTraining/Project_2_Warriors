public class CarListController {
	public List<Vehicle__c> vehicleList{get;set;} 
    public CarListController(){
        vehicleList = new List<Vehicle__c>();
        vehicleList = [SELECT Id, Name, Vehicle_Type__c, Vehicle_Year__c, Vehicle_Make__c, Vehicle_Model__c, Status__c, Description__c FROM Vehicle__c Where Status__c != 'Lost/Stolen' OR Status__c != 'Decomissioned' ORDER BY Status__c];  
    }
    public PageReference changeLoc() {
        PageReference pageRef = new PageReference('/apex/locations');
        pageRef.setRedirect(true);
        return pageRef;
    }
    //redirect to carList page for rental process
    public PageReference carList() {
        PageReference pageRef = new PageReference('/apex/carlist');
        pageRef.setRedirect(true);
        pageRef.getParameters().put('depot_id',System.currentPageReference().getParameters().get('depot_id'));
        return pageRef;
    }
    //redirect to faq page
    public PageReference faq() {
        PageReference pageRef = new PageReference('/apex/casepage');
        pageRef.setRedirect(true);
        pageRef.getParameters().put('depot_id',System.currentPageReference().getParameters().get('depot_id'));
        return pageRef;
    }
    //redirect to sell car page
    public PageReference sellCar() {
        PageReference pageRef = new PageReference('/apex/sellacar');
        pageRef.setRedirect(true);
        pageRef.getParameters().put('depot_id',System.currentPageReference().getParameters().get('depot_id'));
        return pageRef;
    }
    public PageReference redirect() {
        PageReference p = new PageReference('/apex/TransactionPage');
        p.getParameters().put('depot_id',System.currentPageReference().getParameters().get('depot_id'));
        p.setRedirect(true);
        return p;
    } 
}