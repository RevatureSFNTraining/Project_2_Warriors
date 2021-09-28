@isTest
public class CarListControllerTest {
    @isTest public static void testCarListController() {
       
        CarListController controller = new CarListController();
        PageReference carList = controller.redirect();
        String param = System.currentPageReference().getParameters().get('depot_id');
        System.assertEquals(null, param);
    }
    @isTest public static void testChangeLoc() {
       
        CarListController controller = new CarListController();
        PageReference carList = controller.changeLoc();
        String param = System.currentPageReference().getParameters().get('depot_id');
        System.assertEquals(null, param);
    }
    @isTest public static void testCarList() {
       
        CarListController controller = new CarListController();
        PageReference carList = controller.carList();
        String param = System.currentPageReference().getParameters().get('depot_id');
        System.assertEquals(null, param);
    }
    @isTest public static void testSellCar() {
       
        CarListController controller = new CarListController();
        PageReference carList = controller.sellCar();
        String param = System.currentPageReference().getParameters().get('depot_id');
        System.assertEquals(null, param);
    }
    @isTest public static void testFaq() {
       
        CarListController controller = new CarListController();
        PageReference carList = controller.faq();
        String param = System.currentPageReference().getParameters().get('depot_id');
        System.assertEquals(null, param);
    }
}