public class OrderFormController
{

    public quote quoteObj{get;set;}
    public Order__c orderObj {get;set;}
    public string accountid{get;set;}
    public string quoteid{get;set;}
    public map<id,decimal> priceperProduct{get;set;}
    public id quoteObjid{get;set;}
    public decimal totalVal{get;set;}
    //public QuoteLineItem qlObj{get;set;}
    public List<Quote_Line_Item__c> qlList = new list<Quote_Line_Item__c>();
    
    public OrderFormController(ApexPages.StandardController controller) {
        
        quoteObjid = ApexPages.currentPage().getParameters().get('id'); 
        quoteObj = [select id,Accountid,name,Status,Discount,Opportunityid,TotalPrice from Quote where id =: ApexPages.currentPage().getParameters().get('id')];
        orderObj = new order__C();
        orderObj.Account__c = quoteObj.accountid;
        orderObj.Quote__c = quoteObjid;
        
    }
    
    public decimal getTotalValDec()
    {
         return totalVal;
    }
    public list<productWrapper> prdWrapList = new list<productWrapper>();
    public list<productWrapper> selectedPrdWrapList = new list<productWrapper>();
    public list<product__c> selectedprd= new list<product__c>();
    
    public list<productWrapper> getProductList()
    {
        for(product__c prdObj : [SELECT Price_per_Product__c,Active__c,Name,Price__c,Product_Code__c,Quantity__c,Product_Description__c,createdby.name FROM product__c where Active__c =true and createdby.name = 'Bhargavi V' limit 10])
        {
            prdWrapList.add(new productWrapper(prdObj));
        }
        
        return prdWrapList;
    }
    public PageReference getSelected()
    {
        selectedprd.clear();
        for(productWrapper prdWrapper: prdWrapList){
        
        if(prdWrapper.isselected == true)
        {
            selectedprd.add(prdWrapper.ProductWrapObj);
            selectedPrdWrapList.add(prdWrapper);
            }
        }
        return null;
    }  
    
    
    public List<product__c> GetSelectedPrdcts()
    {
        
        if(selectedprd.size()>0){
         
            return selectedprd;
        }
        else{
            return null;
        }
    }
    public list<productWrapper> getseletecprdocutwrapList()
    {
     return selectedPrdWrapList;
    }

    
    public void insertquoteLineItems()
    {
        //system.debug('Qunat'+quantitystr);
        for(product__c prdLoopVar :selectedprd)
        {
            Quote_Line_Item__c qlObj = new Quote_Line_Item__c();
            qlObj.Quote_Standard__c = quoteObjid;
            qlObj.Product__c = prdLoopVar.id;
            qlObj.Quantity__c = prdLoopVar.Quantity__c;
            //totalpriceStr = qlObj.Total_Price__c = prdLoopVar.Quantity__c*prdLoopVar.Price__c;
            qlList.add(qlObj);
        }
        insert qlList;
        
    }
    public pagereference save()
    {
        insertquoteLineItems();
        //orderObj.Quantity__c= quantitystr;
        insert orderObj;
        pagereference pg = new pagereference('/' + quoteObjid);
        pg.setRedirect(true);
        return pg;
    }
    
    public class productWrapper{
        
        public boolean isselected{get;set;}
        public product__c ProductWrapObj{get;set;}
        public decimal totalpriceStr{get;set;}

        public productWrapper(product__c prd)
        {
            ProductWrapObj =prd;
            isselected = false;
            //totalpriceStr = totlval ;
            
        }
        
    }

}