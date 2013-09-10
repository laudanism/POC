global with sharing class OtherController
{
	public String SearchCriteria
	{
		get;
		set;
	}
    public Boolean IsChecked
    {
    	get;
    	set;
	}

    public List<Product2> ProductsList
    {
        get;
        set;
    }

    public OtherController()
    {
    	String query = 'SELECT Product2.Name, Product2.ProductCode, Price__c, Product2.Description FROM Product2';
        ProductsList = ExecuteQuery(query);
    }
    /**
     * GetProducts
     * @return a list of products which are retrieved  from the database.
     */
    public List<Product2> GetProducts()
    {
        return ProductsList;
    }

    public void SearchProduct()
    {
        String query = 'SELECT Product2.Name, Product2.ProductCode, Price__c, Product2.Description FROM Product2 WHERE Name LIKE \'' + SearchCriteria + '%\'';
        ProductsList = ExecuteQuery(query);
    }
    public List<sObject> ExecuteQuery(string query)
    {
        List<sObject> resultList = new List<sObject>();
        resultList = Database.query(query);
    	return resultList;
    }

    @RemoteAction
    global static Double GetPrice()
    {
        Decimal randomNumber = Math.random() * 1000;
        randomNumber.SetScale(2);
        return randomNumber;
    }
}