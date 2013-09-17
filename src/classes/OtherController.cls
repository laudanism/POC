global with sharing class OtherController
{
    private Paginator paginator;
    private SearchManager searchManager;
    private Integer PAGE_LIMIT = 5;
    private String whereQuery;
    private String selectQuery;
    private String fromQuery;

    public String SearchCriteria
    {
        get;
        set;
    }
    public boolean DisableNext
    {
        get
        {
            return !paginator.HasNext;
        }
        private set;
    }
    public boolean DisablePrev
    {
        get
        {
            return !paginator.HasPrev;
        }
        private set;
    }

    public Integer PageNumber
    {
        get
        {
            return paginator.PageNumber;
        }
    }

    public boolean IsChecked
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
    	selectQuery = 'SELECT Product2.Name, Product2.ProductCode, Price__c, Product2.Description ';
    	fromQuery = 'FROM Product2 ';
    	whereQuery = '';
        String query = selectQuery + fromQuery + ' limit ' + PAGE_LIMIT;
        ProductsList = new List<Product2>();
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
        whereQuery = 'WHERE Name LIKE \'%' + SearchCriteria + '%\'';
        List<sObject> aux = ExecuteQuery(selectQuery + fromQuery + whereQuery);
        paginator.Reset(aux.size());
        GetNext();
    }

    public void GetNext()
    {
        if(paginator.HasNext)
        {
            String pages = paginator.Next();
            String query = selectQuery + fromQuery + whereQuery + pages;
            ProductsList = ExecuteQuery(query);
        }
    }

    public void GetPrev()
    {
        if(paginator.HasPrev)
        {
            String pages = paginator.Prev();
            String query = selectQuery + fromQuery + whereQuery + pages;
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
        return [Select count() From Product2 ];
    }

    @RemoteAction
    global static String GetPrice(String fieldId)
    {
        Decimal randomNumber = Math.random() * 1000;
        randomNumber = randomNumber.SetScale(2);
        return String.valueOf(randomNumber) + '@@' + fieldId;
    }
}