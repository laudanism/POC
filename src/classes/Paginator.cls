public with sharing class Paginator
{

    private Integer pagesLimit;
    private Integer offset;
    private Integer totalRecords;

    public Paginator(Integer pagesLimit, Integer totalRecords)
    {
        this.pagesLimit = pagesLimit;
        this.totalRecords = totalRecords;
        PageNumber = 1;
        offset = pagesLimit;
    }

    public Integer PageNumber
    {
        get;
        set;
    }
    public Boolean HasNext
    {
        get
        {
            if(offset < totalRecords && offset >= 0)
            {
                return true;
            }
            return false;
        }
        private set;
    }
    public Boolean HasPrev
    {
        get {
            if(offset > 0 && PageNumber != 1)
            {
                return true;
            }
            return false;
        }
        private set;
    }

    public String Next()
    {
        String query = '';
        if(HasNext)
        {
            PageNumber += 1;
            query = 'LIMIT ' + pagesLimit + ' OFFSET ' + offset;
            offset += pagesLimit;
        }
        return query;
    }

    public String Prev()
    {
        String query = '';
        if(HasPrev)
        {
            Integer offsetToSubstract = (offset >= totalRecords) ? (pagesLimit * 2): pagesLimit;
            offset -= offsetToSubstract;
            query = 'LIMIT ' + pagesLimit + ' OFFSET ' + offset;
            PageNumber -= 1;

            return query;
        }
        HasNext = false;
        return query;
    }

    public void Reset(Integer records)
    {
        offset = 0;
        PageNumber = 0;
        totalRecords = records;
    }
}