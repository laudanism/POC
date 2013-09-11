global with sharing class OtherController
{
  private Integer PAG_LIMIT = 10;
  private Integer OFFSET = 0;

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

    public Integer TotalRecords
    {
      get;
      set;
    }

    public List<Product2> ProductsList
    {
        get;
        set;
    }
    public Integer PageNumber
    {
    	get;
    	set;
    }
    public Boolean HasNext {
        get {
            if(OFFSET < TotalRecords)
                return true;
            return false;
        }
        private set;
    }

    public OtherController()
    {
        String query = 'SELECT Product2.Name, Product2.ProductCode, Price__c, Product2.Description FROM Product2 limit ' + PAG_LIMIT + 'OFFSET ' + OFFSET;
        OFFSET += PAG_LIMIT;
        ProductsList = ExecuteQuery(query);
        PageNumber = 1;
        SetNumberRows();
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
        if(HasNext)
        {
            String query = 'SELECT Product2.Name, Product2.ProductCode, Price__c, Product2.Description FROM Product2 limit ' + PAG_LIMIT + 'OFFSET ' + OFFSET;
            ProductsList = ExecuteQuery(query);
            OFFSET += PAG_LIMIT;
            PageNumber += 1;
            return;
        }

    }

    public void GetPrev()
    {
        if(OFFSET > 0)
        {
            OFFSET -= PAG_LIMIT;
            String query = 'SELECT Product2.Name, Product2.ProductCode, Price__c, Product2.Description FROM Product2 limit ' + PAG_LIMIT + 'OFFSET ' + OFFSET;
            ProductsList = ExecuteQuery(query);
            PageNumber -= 1;
            return;
        }
        HasNext = false;
    }

    private List<sObject> ExecuteQuery(string query)
    {
        List<sObject> resultList = new List<sObject>();
        resultList = Database.query(query);
        return resultList;
    }

    private void SetNumberRows()
    {
        Integer nRows = [Select COUNT() From Product2];
        TotalRecords = nRows;
    }

    @RemoteAction
    global static Double GetPrice()
    {
        Decimal randomNumber = Math.random() * 1000;
        randomNumber = randomNumber.SetScale(2);
        return randomNumber;
    }
}