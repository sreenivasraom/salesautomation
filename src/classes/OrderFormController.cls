public class OrderFormController
{

    public OrderFormController(ApexPages.StandardController controller) {
     
        quoteObjid = ApexPages.currentPage().getParameters().get('id'); 
        quoteObj = [select id,Accountid,name,Status,Discount,Opportunityid,TotalPrice from Quote where id =: ApexPages.currentPage().getParameters().get('id')];
        orderObj = new order__C();
        orderObj.Account__c = quoteObj.accountid;
        orderObj.Quote__c = quoteObjid;
        
    }
    public quote quoteObj{get;set;}
    public Order__c orderObj {get;set;}
    public string accountid{get;set;}
    public string quoteid{get;set;}
    public string quantitystr{get;set;}
    public id quoteObjid{get;set;}
    
  /*  public list<product2> getProductList()
    {
        List<Product2> prdList = [select id,name,ProductCode from product2 limit 10];
        return prdList;
    
    }*/
    public list<productWrapper> prdWrapList = new list<productWrapper>();
    public list<product2> selectedprd= new list<product2>();
    
    public list<productWrapper> getProductList()
    {
        for(Product2 prd : [select id,name,ProductCode from product2 limit 10])
        {
            prdWrapList.add(new productWrapper(prd));
        }
       
        return prdWrapList;
    }
      public PageReference getSelected()
    {
        selectedprd.clear();
        for(productWrapper prdWrapper: prdWrapList)
        if(prdWrapper.isselected == true)
        selectedprd.add(prdWrapper.ProductWrapObj);
        return null;
    }   
     public List<product2> GetSelectedPrdcts()
    {
        if(selectedprd.size()>0)
        return selectedprd;
        else
        return null;
    }    
    
    public pagereference save()
    {
        orderObj.Quantity__c= quantitystr;
        insert orderObj;
        pagereference pg = new pagereference('/' + quoteObjid);
        pg.setRedirect(true);
        return pg;
    }
     public class productWrapper{
    
    public boolean isselected{get;set;}
    public Product2 ProductWrapObj{get;set;}
    
    public productWrapper(Product2 prd)
    {
        ProductWrapObj =prd;
        isselected = false;
    }
    
    }

}