@RestResource(urlMapping='/getPrices/')
global class ServiceRestController
{
    @HttpGet
    global static LIST<Double> GetPrices()
    {
        List<Double> lst;
        try
        {
            Integer i = 0;
            while(i < 30)
            {
                lst.add(Math.random() * 1000);
            }
        }
        catch(Exception e)
        {
            system.debug('ERROR: ' + e.getMessage());
        }
        return lst;
    }
}
