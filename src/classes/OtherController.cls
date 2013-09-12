global with sharing class OtherController
{
	private Paginator paginator;
    private Integer PAGE_LIMIT = 5;

    public String SearchCriteria
    {
        get;
        set;
    }
    public Integer PageNumber
    {
    	get
    	{
    		return paginator.PageNumber;
    	}
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
        String query = 'SELECT Product2.Name, Product2.ProductCode, Price__c, Product2.Description FROM Product2 limit ' + PAGE_LIMIT;
        ProductsList = ExecuteQuery(query);
        paginator = new Paginator(PAGE_LIMIT, GetNumberRows());
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
        String query = 'SELECT Product2.Name, Product2.ProductCode, Price__c, Product2.Description FROM Product2 WHERE Name LIKE \'%' + SearchCriteria + '%\'';
        ProductsList = ExecuteQuery(query);
    }

    public void GetNext()
    {
        if(paginator.HasNext)
        {
        	String pages = paginator.Next();
            String query = 'SELECT Product2.Name, Product2.ProductCode, Price__c, Product2.Description FROM Product2 ' + pages;
            ProductsList = ExecuteQuery(query);
        }
    }

    public void GetPrev()
    {
        if(paginator.HasPrev)
        {
            String pages = paginator.Prev();
            String query = 'SELECT Product2.Name, Product2.ProductCode, Price__c, Product2.Description FROM Product2 ' + pages;
            ProductsList = ExecuteQuery(query);
        }
    }

    private List<sObject> ExecuteQuery(string query)
    {
        List<sObject> resultList = new List<sObject>();
        resultList = Database.query(query);
        return resultList;
    }

    private Integer GetNumberRows()
    {
        return [Select COUNT() From Product2];
    }

    @RemoteAction
    global static Double GetPrice()
    {
        Decimal randomNumber = Math.random() * 1000;
        randomNumber = randomNumber.SetScale(2);
        return randomNumber;
    }
}