public class CaseController {
    public ApexPages.StandardController stdCntrlr {get; set;}
    
    public CaseController(ApexPages.StandardController controller) {
        
        stdCntrlr = controller;
    }
    
    public Case cs{get; set;}
    public CaseController(){
        cs = new Case();
    }
    
 	public PageReference save(){
       if(cs != null) {
            upsert cs;
        } else {
            stdCntrlr.save();
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.CONFIRM,'Successfully inserted Case.'));
            PageReference pr = new PageReference('/apex/CasePage');
   			pr.setRedirect(true);
   			return pr;
        }
        return null;
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
    
}