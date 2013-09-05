public with sharing class OtherController {
        
    public List<Product2> ProductsList
    {
        get
        {
            String query = 'SELECT Product2.Name, Product2.ProductCode, Price__c, Product2.Description FROM Product2';           
            ProductsList = Database.query(query);
            return ProductsList;
        }
        set;
    }
    
    public List<Product2> GetProducts()
    {
        return ProductsList;
    }
}