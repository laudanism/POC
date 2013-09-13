@isTest
private class OtherControllerTest {

    static testMethod void SearchProductTest()
    {
        OtherController controller = new OtherController();
        controller.SearchCriteria = '200kw';
        controller.SearchProduct();
        List<Product2> expectedList = [SELECT Product2.Name, Product2.ProductCode, Price__c, Product2.Description FROM Product2 limit 5];
        system.assertEquals(expectedList, controller.ProductsList);

    }
}