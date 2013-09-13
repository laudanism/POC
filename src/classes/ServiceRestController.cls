@RestResource(urlMapping='/GetPrices/')
global class ServiceRestController
{
    @HttpGet
    global static ResponseWrapper GetPrices()
    {
		try
		{
		    List<Double> lst = new List<Double>();
		    Integer i = 0;

		    Decimal randomNumber = Math.random() * 1000;
		    lst.add(randomNumber.SetScale(2));
            randomNumber = Math.random() * 1000;
            lst.add(randomNumber.SetScale(2));
            randomNumber = Math.random() * 1000;
            lst.add(randomNumber.SetScale(2));
            randomNumber = Math.random() * 1000;
            lst.add(randomNumber.SetScale(2));
            randomNumber = Math.random() * 1000;
            lst.add(randomNumber.SetScale(2));
            randomNumber = Math.random() * 1000;
            lst.add(randomNumber.SetScale(2));
            randomNumber = Math.random() * 1000;
            lst.add(randomNumber.SetScale(2));
            randomNumber = Math.random() * 1000;
            lst.add(randomNumber.SetScale(2));
            randomNumber = Math.random() * 1000;
            lst.add(randomNumber.SetScale(2));
            randomNumber = Math.random() * 1000;
            lst.add(randomNumber.SetScale(2));
            randomNumber = Math.random() * 1000;
            lst.add(randomNumber.SetScale(2));
            randomNumber = Math.random() * 1000;
            lst.add(randomNumber.SetScale(2));
            randomNumber = Math.random() * 1000;
            lst.add(randomNumber.SetScale(2));
            randomNumber = Math.random() * 1000;
            lst.add(randomNumber.SetScale(2));
            randomNumber = Math.random() * 1000;
            lst.add(randomNumber.SetScale(2));
            randomNumber = Math.random() * 1000;
            lst.add(randomNumber.SetScale(2));
            randomNumber = Math.random() * 1000;
            lst.add(randomNumber.SetScale(2));

            ResponseWrapper res = new ResponseWrapper('true', 'List filled successfully', lst);

            system.DEBUG('>>>>>>>>>>> RES ' + res.Records.get(0));
		    return res;
		}
		catch(Exception e)
		{
		    system.debug('ERROR: ' + e.getMessage());
		    return new ResponseWrapper('false', e.getMessage(), null);
		}
    }
}