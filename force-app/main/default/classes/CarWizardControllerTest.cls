/*
*Name: SupplierTriggerTest.apxc
*Author: Julia Weakley
*DateCreated: 9/13/2021
*DateModified: 9/21/2021
*Description: 
*	Tests for carWizardController 
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
            testDepot.Owner__c = testAccount.Id; 
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
        con.sellerInfo();
      	Test.stopTest();
        System.assertEquals(0, tran.size());
    } // end of test 
    
    // should not have any vehicles added
   @isTest
        public static  void backToTest()
    { 	 
        Test.startTest();
        CarWizardController con = new carWizardController();
         List<Vehicle__c> vehicles = [SELECT id FROM Vehicle__c];
        con.backToYourInfo();
      	Test.stopTest();
         System.assertEquals(0, vehicles.size());
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
    
    
    //saveAnother() should have a new vehicle inserted after page reference
    @isTest
    public static  void saveAnoTest()
    { 	 
        Test.startTest();
        CarWizardController con = new carWizardController(); 
        con.saveAnother();
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
        con.saveAnother();
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
        con.saveAnother();
        List<Purchase_Transaction__c> tran = [SELECT id FROM Purchase_Transaction__c];
        Test.stopTest();
         System.assertEquals(1, tran.size());
    } // end of test  
    
} // end of test class