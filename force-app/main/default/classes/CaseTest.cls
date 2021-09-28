@isTest
public class CaseTest {
    static testMethod void testMethod1(){
        Case testCase = new Case();
        testCase.Status = 'New';
        testCase.Origin = 'Phone';
        testCase.Subject = 'test';
        testCase.Description = 'test';
        upsert testCase;
        
        Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(testCase);
        CaseController testCasePage = new CaseController(sc);
        
        PageReference pageRef = Page.CasePage;
        pageRef.getParameters().put('id', String.valueOf(testCase.Id));
        Test.setCurrentPage(pageRef);
        testCasePage.save();
        system.assert(Database.insert(testCase).isSuccess());
        Test.stopTest();
    }
    
    static testMethod void bulkTestMethod2(){
        
        test.StartTest();
        integer caseCount = 0;
        list<Case> cs = new List<Case>();
        while (caseCount<=151){
            caseCount +=1; 
        }
        insert cs;
        
        test.stopTest();
    }
    
    static testMethod void positiveTestMethod3(){
        test.startTest();
        Case cs = new Case(Status = 'New');
        system.assert(Database.insert(cs).isSuccess());
        test.stopTest();
    }
    
    static testMethod void negativeTestMethod4(){
        test.startTest();
        Case cs = new Case();
        cs.Status = Null;
        insert cs;
        Database.SaveResult sr = Database.insert(cs, false);
        system.assertEquals(false, sr.isSuccess());
        test.stopTest();
    }
}

//comment