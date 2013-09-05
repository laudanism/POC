public with sharing class ProductWrapper {
    public Product2 Product { get; set; }
    public Integer Index { get; set; }
    
    public ProductWrapper(Product2 product, Integer index) 
    {
	    Product = product;
	    Index = index;
    }
}