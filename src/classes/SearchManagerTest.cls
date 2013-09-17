@isTest(SeeAllData=true)

private class SearchManagerTest {

    static testMethod void SearchQueryTest()
    {
        SearchManager manager = new SearchManager(5);
        manager.SearchQuery('gen'); //9 records
        system.assert(9 == manager.ResultSize);
    }

    static testMethod void ResetTest()
    {
        SearchManager manager = new SearchManager(5);
        manager.SearchQuery('gen'); //9 records
        manager.Reset();
        system.assert(0 == manager.ResultSize);
    }

    static testMethod void GetNextBlockTest()
    {
        SearchManager manager = new SearchManager(5);
        system.assertEquals(null, manager.GetNextBlock());
        manager.SearchQuery('gen'); //9 records
        List<sObject> result = manager.GetNextBlock();
        system.assertNotEquals(null, result);
    }

    static testMethod void GetPrevBlock()
    {
        SearchManager manager = new SearchManager(5);
        system.assertEquals(null, manager.GetPrevBlock());
        manager.SearchQuery('gen');
        manager.GetNextBlock();
        List<sObject> result = manager.GetPrevBlock();
        system.assertNotEquals(null, result);
    }

    static testMethod void Trial()
    {
    	List<sObject> result = [SELECT Name FROM Product2 WHERE Name like '%ge%' limit 3 OFFSET 8];
        for(sObject o : result)
        {
            system.DEBUG('>>>>>>>>> O: ' + o);
        }
    }
}