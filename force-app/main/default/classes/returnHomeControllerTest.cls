@isTest
public class returnHomeTest {
    @isTest public static void testReturnHomeController(){
    	returnHome controller = new returnHome();
        PageReference carList = controller.returnToHome();
        String param = System.currentPageReference().getParameters().get('depot_id');
        System.assertEquals(null, param);
}
}