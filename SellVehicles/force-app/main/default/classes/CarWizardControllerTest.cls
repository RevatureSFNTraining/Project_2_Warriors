/*
*Name: SupplierTriggerTest.apxc
*Author: Julia Weakley
*DateCreated: 9/13/2021
*DateModified: 9/21/2021
*Description: 
*	Tests for carWizardController 
*		
*/

@isTest
public class CarWizardControllerTest 
{
    //sets up data for tests
	 @testSetup
    static void setup()
    {
			Account testaccount = new Account(); 
			testaccount.Name = 'Test';  
        	insert testaccount; 
        
        	Depot__c testDepot = new Depot__c(); 
        	testDepot.Name ='TestD'; 
        	insert testDepot; 
    } // end of setup 
    
    // test that all accounts are retrieved for users to select an option
     @isTest
    private static void companyOptionsTest()
    {
        
        List<SelectOption> options = new List<SelectOption>(); 
       	List<Account> lis = [SELECT Name FROM Account];
       
        for(Account accs :lis )
        {
           options.add(new SelectOption(accs.id,accs.Name ));
        } // end of for
        
        System.assertEquals(options, CarWizardController.getcompanyOptions());
    } // end of test
    
    //test that depots are retrieved as OPtions correctly
    @isTest
    private static void getdepotOptionsTest()
    {
     	List<SelectOption> options = new List<SelectOption>(); 
       	List<Depot__c> lis = [SELECT Name FROM Depot__c];
       
        for(Depot__c dep :lis )
        {
           options.add(new SelectOption(dep.id,dep.Name ));
        }// end of for
        
        System.assertEquals(options, CarWizardController.getdepotOptions());
    }// end of test
    
    // tests that ManufacturerOptions is zero when called
     @isTest
    private static void  getManufacturerOptionsTest()
    {
        System.assertEquals(0, CarWizardController.getManufacturerOptions().size());
    } // end of test
    
    //tests that one manufacturer option is reutrned when one Manufacturer is created and inserted
     @isTest
    private static void  oneValueGetManufacturerOptionsTest()
    {
        Manufacturer__c testmanu = new Manufacturer__c();
        testmanu.Name = 'mantest';
        insert testmanu; 
        
        System.assertEquals(1, CarWizardController.getManufacturerOptions().size());
    } // end of test
    
    // No new vehicles should have been added with the return of the Page reference
    @isTest
    public static  void firstPageTest()
    { 	 
        Test.startTest();
        CarWizardController con = new carWizardController(); 
        List<Vehicle__c> vehicles = [SELECT id FROM Vehicle__c]; 
        con.start();
      	Test.stopTest();
        System.assertEquals(0, vehicles.size());
    } // end of test
    
    // no new transactions should be added when sellerinfo page is returned 
     @isTest
    public static  void sellerInfoTest()
    { 	 
        Test.startTest();
        CarWizardController con = new carWizardController(); 
         List<Purchase_Transaction__c> tran = [SELECT id FROM Purchase_Transaction__c]; 
       	PageReference re = page.SellACar; 
        Test.setCurrentPage(re); 
        List<Depot__c> tD = [SELECT id FROM Depot__c]; 
        re.getParameters().put('depot_id',String.valueOf(tD.get(0).id));
        con.sellerInfo();
        String param = System.currentPageReference().getParameters().get('depot_id');
      	Test.stopTest();
        System.assertEquals(0, tran.size());
    } // end of test 
    
   // no new transactions should be added when sellerinfo page is returned 
     @isTest
    public static  void sellerInfoParamTest()
    { 	 
        Test.startTest();
        CarWizardController con = new carWizardController(); 
         List<Purchase_Transaction__c> tran = [SELECT id FROM Purchase_Transaction__c]; 
       	PageReference re = page.SellACar; 
        Test.setCurrentPage(re); 
        re.getParameters().put('depot_id','');
        con.sellerInfo();
        String param = System.currentPageReference().getParameters().get('depot_id');
      	Test.stopTest();
        System.assertEquals('', param);
    } // end of test 
  
    
     // should have a new vehicle inserted after page reference
     @isTest
        public static  void saveTest()
    { 	 
        Test.startTest();
        CarWizardController con = new carWizardController(); 
        con.saveVehicle();
        List<Vehicle__c> vehicles = [SELECT id FROM Vehicle__c]; 
        Test.stopTest();
         System.assertEquals(1, vehicles.size());
    } // end of test
    
    
   
    
    // After adding another vehicle and then saving another there should be 2 vehicles
    //  shouladdAnotherVehicle()
       @isTest
    public static  void addAnoTest()
    { 	 
        Test.startTest();
        CarWizardController con = new carWizardController(); 
        con.addAnotherVehicle();
       	con.saveVehicle();
        List<Vehicle__c> vehicles = [SELECT id FROM Vehicle__c];
        Test.stopTest();
         System.assertEquals(2, vehicles.size());
    } //end of Test  
    
    // After adding another vehicle and then saving another there should be 1 transaction
    //  shouladdAnotherVehicle()
    @isTest
    public static  void addAnoTranTest()
    { 	 
        Test.startTest();
        CarWizardController con = new carWizardController(); 
        con.addAnotherVehicle();
        con.saveVehicle();
        List<Purchase_Transaction__c> tran = [SELECT id FROM Purchase_Transaction__c];
        Test.stopTest();
         System.assertEquals(1, tran.size());
    } // end of test  
    
    
   
    @isTest
    public static void changeLocTest()
    {
        // start test
        Test.startTest();
         CarWizardController con = new carWizardController(); 
       
        PageReference neLoc = con.changeLoc(); 
        Test.setCurrentPage(neLoc);
        String param = System.currentPageReference().getParameters().get('depot_id'); 
        
        // stop test
        Test.stopTest();
        
         // since no parameters have been set the value should be null
        System.assertEquals(null, param);
    } // end of test
    
    
    @isTest
    public static void faqTest()
    {
        Depot__c tempfaq = new Depot__c();
        Test.startTest();
         CarWizardController con = new carWizardController(); 
         PageReference nefaq = con.faq();
       	  
         insert tempfaq; 
         nefaq.getParameters().put('depot_id', tempfaq.Id);
         Test.setCurrentPage(nefaq);
         String param = System.currentPageReference().getParameters().get('depot_id'); 
        
        Test.stopTest();
        // value should be the id of the new dpot since it was put in as a parameter 
        System.assertEquals( tempfaq.Id, param);
    } // end of test
    
    @isTest 
    public static void sellCarTest()
    {
        // begin test 
        Test.startTest();
        CarWizardController con = new carWizardController(); 
        PageReference nesellCar = con.sellCar(); 
        Test.setCurrentPage(nesellCar);
        String param = System.currentPageReference().getParameters().get('depot_id'); 
        // stop test
        Test.stopTest();
        
        // should return null since no parameters were put
        System.assertEquals(null, param);
    } // end of test
    
    @isTest
    public static void carListTest()
    {
        Test.startTest();
         CarWizardController con = new carWizardController(); 
       
        PageReference necarList = con.carList(); 
         String param = System.currentPageReference().getParameters().get('depot_id'); 
        Test.stopTest();
        
        // since no parameters were added the value should be null
        System.assertEquals(null, param);
    } // end of test
    
} // end of test class