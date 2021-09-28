/*
*Name: CarWizardController
*Author: Julia Weakley
*DateCreated: 9/13/2021
*DateModified: 9/17/2021
*Description: 
*	Controller for wizard
*/


public class CarWizardController 
{
    public vehicle__c vec {get;set;}
    public Purchase_Transaction__c tran{get;set;}
    public Depot__c dep {get;set;}
    
    public CarWizardController()
    {
        // vehicle
        vec = new vehicle__c(); 
        // purhcase transaction
        tran = new Purchase_Transaction__c(); 
        // depot
        dep = new Depot__c(); 
    } // end of CarWizardController
    
    // brings user back to first page of wizard
    public PageReference start()
    {
        //  attaches id of depot to url 
        PageReference pageRef = page.sellACar; 
        pageRef.setRedirect(true);
        String param = System.currentPageReference().getParameters().get('depot_id');
        pageRef.getParameters().put('depot_id', param);
        
        // new Vehicle to add to Purchase Transaction
        Vehicle__c anewv = new Vehicle__c(); 
        // new purchase transaction
        Purchase_Transaction__c aNewTran = new Purchase_Transaction__c();
        // set transactions to be able to reference in additional vechicle creation
        tran.id = aNewTran.Id; 
        // set vehicle
        vec.id = anewv.id; 
        
        
        
        return pageRef; 
    } // end of start()
    
    // send user to page for filling out Company Information
    public PageReference sellerInfo()
    {
        // grab depot id
        String param = System.currentPageReference().getParameters().get('depot_id');
        PageReference pageRef = page.SellerInformation; 
        pageRef.setRedirect(true);
        
        // if id is there set transaction depot to the one saved in the url
        if(!String.isEmpty(param))
        {
            pageref.getParameters().put('depotId',param);
            dep.Id = param; 
            tran.Depot__c = dep.id; 
            return pageRef; 
        }// end of if 
        
        // placed depot id in next url 
        pageref.getParameters().put('depot_id',''); 
        
        return pageRef; 
    }// end of sellerInfo
    
    
    // send user to transaction completed page
    public PageReference saveVehicle()
    {
        // insert purchase transaction if it does not exist already
        List<Purchase_Transaction__c> tranList = [SELECT ID FROM Purchase_Transaction__c where id =: tran.id];
        if(tranList.size() == 0)
        {
            tran.Purchase_Date__c = System.today();
            insert tran;
        } // end of if
        
        // make sure vehicle is in same transaction and same depot
        vec.Purchase_Transaction__c = tran.Id; 
        vec.Stationed_Depot__c = tran.Depot__c; 
        
        // save new vehicle 
        insert vec;
        
        // place depot id in url 
        PageReference pageRef = Page.CompletedPage;
        pageRef.setRedirect(true);
        pageRef.getParameters().put('depot_id', tran.Depot__c);
        
        return pageRef; 
    } // end of saveVehicle()
    
    
    public PageReference addAnotherVehicle()
    {
        
        
        List<Purchase_Transaction__c> tranList = [SELECT ID FROM Purchase_Transaction__c where id =: tran.id];
        if(tranList.size() == 0)
        {
            tran.Purchase_Date__c = System.today();
            insert tran;
        } // end of if
        
        vec.Purchase_Transaction__c = tran.Id; 
        vec.Stationed_Depot__c = tran.Depot__c; 
        
        
        insert vec;
        
        Vehicle__c anotherv = new Vehicle__c(); 
        vec.id = anotherv.id;
        
        
        
        
        return  page.AdditionalVehicle;
    }
    //creates option list for companies 
    public static List<SelectOption> getcompanyOptions()
    {
        List<SelectOption> options = new List<SelectOption>(); 
        List<Account> lis = [SELECT Name FROM Account];
        
        for(Account accs :lis )
        {
            options.add(new SelectOption(accs.id,accs.Name ));
        }// end of for
        
        return  options;
    } // getcompanyOptions
    
    //creates option list for Depot
    public static List<SelectOption> getdepotOptions()
    {
        List<SelectOption> options = new List<SelectOption>(); 
        List<Depot__c> lis = [SELECT Name FROM Depot__c];
        
        for(Depot__c dep :lis )
        {
            options.add(new SelectOption(dep.id,dep.Name ));
        }// end of for
        
        return  options;
    } // getcompanyOptions
    
    public static List<SelectOption> getManufacturerOptions()
    {
        List<SelectOption> options = new List<SelectOption>(); 
        List<Manufacturer__c> lis = [SELECT Name FROM Manufacturer__c];
        
        for(Manufacturer__c man :lis )
        {
            options.add(new SelectOption(man.id,man.Name ));
        }// end of for
        
        return  options;
    } // getcompanyOptions
    
    
    // Alex's code for Project
    public PageReference changeLoc() {
        PageReference pageRef = new PageReference('/apex/locations');
        pageRef.setRedirect(true);
        return pageRef;
    } // end of changeLoc
    
    //redirect to carList page for rental process
    public PageReference carList() {
        PageReference pageRef = new PageReference('/apex/carlist');
        pageRef.setRedirect(true);
        pageRef.getParameters().put('depot_id',System.currentPageReference().getParameters().get('depot_id'));
        return pageRef;
    } // end of carList
    
    //redirect to faq page
    public PageReference faq() {
        PageReference pageRef = new PageReference('/apex/casepage');
        pageRef.setRedirect(true);
        pageRef.getParameters().put('depot_id',System.currentPageReference().getParameters().get('depot_id'));
        return pageRef;
    } // end of faq
    
    //redirect to sell car page
    public PageReference sellCar() {
        PageReference pageRef = new PageReference('/apex/sellacar');
        pageRef.setRedirect(true);
        pageRef.getParameters().put('depot_id',System.currentPageReference().getParameters().get('depot_id'));
        return pageRef;
    } // end of sell car
    
    
    
    
}