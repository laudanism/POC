public with sharing class SearchManager {

    private Integer index;
    private List<Product2> results;
    private Integer blockSize;

    public Integer ResultSize
    {
    	get
    	{
    		return results.size();
    	}
    }

    public SearchManager(Integer blockSize)
    {
    	results = new List<Product2>();
    	index = 0;
    	this.blockSize = blockSize;
    }

    public void SearchQuery(String searchCriteria)
    {
        String query = 'SELECT Name, ProductCode, Price__c, Description FROM Product2 WHERE Name LIKE \'%' + searchCriteria + '%\'';
        List<sObject> queryResult = new List<sObject>();
        queryResult = Database.query(query);
        results = queryResult;
    }

    public void Reset()
    {
    	results.clear();
    	index = 0;
    }

    public List<sObject> GetPrevBlock()
    {
        Integer newIndex = index - (blockSize * 2);
        Integer chunk = index - blockSize;
        if(chunk == 0)
        {
            return LoadList(0, blockSize);
        }

        if(newIndex < 0)
        {
            return null;
        }
        return LoadList(newIndex, index + blockSize);
    }

    public List<sObject> GetNextBlock()
    {
    	Integer recordsToLoad = (results.size() - index);

    	if(recordsToLoad <= 1)
            return null;

    	Integer newIndex = index + blockSize;
    	if(newIndex < results.size())
    	{
    		return LoadList(index, newIndex);
    	}
    	return LoadList(index, index+recordsToLoad);
    }

    private List<sObject> LoadList(Integer initIndex, Integer endIndex)
    {
    	List<sObject> block = new List<sObject>();
        while(initIndex < endIndex)
        {
        	block.add(results[initIndex++]);
        	index++;
        }
        return block;
    }
}