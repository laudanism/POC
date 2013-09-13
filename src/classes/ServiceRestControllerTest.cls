@isTest(SeeAllData=true)
private class ServiceRestControllerTest {

    static testMethod void testRest() {

        system.RestContext.request = new RestRequest();

        Restrequest req = new Restrequest();
        Restresponse res = new Restresponse();
        req.requestURI = 'https://c.na15.visual.force.com/services/apexrest/GetPrices/';
        req.httpMethod = 'GET';
        req.addHeader('email', 'ad_opio@hotmail.com');

        ResponseWrapper result = ServiceRestController.GetPrices();
        system.assertEquals('true', result.success);
        system.assertEquals(17, result.records.size());
        system.assertEquals('List filled successfully', result.message);

    }
}