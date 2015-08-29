trigger updateQuoteStatus on Order__c (after insert) {

    List<Id> quoteLidList = new list<id>();
    List<Id> quoteLApprovalList = new list<id>();
    if(trigger.isinsert)
    {
        for(Order__C orderObj : Trigger.new)
        {
            if(orderObj.Discount__c>0.25)
            {
                quoteLApprovalList.add(orderObj.quote__c);
            }
            else
            quoteLidList.add(orderObj.quote__c);

        }

    }
    if(quoteLidList.size()>0){
    List<Quote> quoteList = [select id,name from Quote where id  in :quoteLidList];
    for(quote quoteObj : quoteList)
    {
        quoteObj.status = 'Accepted-Order Created';
    }
    update quoteList;
    }
    else if(quoteLApprovalList.size()>0)
    {
    List<Quote> quoteList = [select id,name from Quote where id  in :quoteLApprovalList];
    for(quote quoteObj : quoteList)
    {
        quoteObj.status = 'Waiting for Approval';
    }
    }
    

}