@isTest
private class PaginatorTest {

    static testMethod void nextMethodWith17RecordsTest()
    {
        Integer pageLimit = 5;
        Integer offset = 0;

        Paginator paginator = new Paginator(5, 17);
        String nextPage = 'LIMIT ' + pageLimit + 'OFFSET ' + offset;
        String nextResult = paginator.Next();

        system.assert(nextResult == 'LIMIT 5 OFFSET 5');
        system.assert(paginator.PageNumber == 2);

        nextResult = paginator.Next();
        system.assert(nextResult == 'LIMIT 5 OFFSET 10');
        system.assert(paginator.PageNumber == 3);

        nextResult = paginator.Next();
        system.assert(nextResult == 'LIMIT 5 OFFSET 15');
        system.assert(paginator.PageNumber == 4);

        nextResult = paginator.Next();
        system.assert(nextResult == '');
        system.assert(paginator.PageNumber == 4);
    }

    static testMethod void prevMethodWith17RecordsTest()
    {
        Integer pageLimit = 5;
        Integer offset = 15;

        Paginator paginator2 = new Paginator(5, 17);
        String nextResult = paginator2.Next();
        nextResult = paginator2.Next();
        nextResult = paginator2.Next();
        nextResult = paginator2.Next(); //last page

        String prevPage = paginator2.Prev();
        system.assert(prevPage == 'LIMIT 5 OFFSET 10');
        system.assert(paginator2.PageNumber == 3);

        prevPage = paginator2.Prev();
        system.assert(prevPage == 'LIMIT 5 OFFSET 5');
        system.assert(paginator2.PageNumber == 2);

        prevPage = paginator2.Prev();
        system.assert(prevPage == 'LIMIT 5 OFFSET 0');
        system.assert(paginator2.PageNumber == 1);

        prevPage = paginator2.Prev();
        system.assert(prevPage == '');
        system.assert(paginator2.PageNumber == 1);

    }


}