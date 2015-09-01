public class OrderFormController
{

    public quote quoteObj{get;set;}
    public Order__c orderObj {get;set;}
    public string accountid{get;set;}
    public string quoteid{get;set;}
    public map<id,decimal> priceperProduct{get;set;}
    public id quoteObjid{get;set;}
    public decimal totalVal{get;set;}
    public decimal  grandTotal{get;set;}
    public List<Quote_Line_Item__c> qlList = new list<Quote_Line_Item__c>();
    public list<product__c> selectedprd = new list<product__c>();
    
    public OrderFormController(ApexPages.StandardController controller) {
        
        
        quoteObjid = ApexPages.currentPage().getParameters().get('id'); 
        quoteObj = [select id,Accountid,name,Status,Discount,Opportunityid,TotalPrice from Quote where id =: ApexPages.currentPage().getParameters().get('id')];
        orderObj = new order__C();
        orderObj.Account__c = quoteObj.accountid;
        orderObj.Quote__c = quoteObjid;
        grandTotal = 0.0;
    }
    public list<productWrapper> prdWrapList = new list<productWrapper>();
    
    
    public list<productWrapper> getProductList()
    {
        for(product__c prdObj : [SELECT Price_per_Product__c,Active__c,Name,Price__c,Product_Code__c,Quantity__c,Product_Description__c,createdby.name FROM product__c where Active__c =true and createdby.name = 'Bhargavi V' limit 10])
        {
            prdObj.Quantity__c = 1;
            prdWrapList.add(new productWrapper(prdObj));
        }
        
        return prdWrapList;
    }
    public PageReference getSelected()
    {
        //selectedprd = new list<product__c>();
        selectedprd.clear();
        for(productWrapper prdWrapper: prdWrapList){
            
            if(prdWrapper.isselected == true)
            {
                selectedprd.add(prdWrapper.ProductWrapObj);
            }
        }
        return null;
    }  
    
    
    public List<product__c> GetSelectedPrdcts()
    {
        
        priceperProduct = new map<id,decimal>();
        if(selectedprd.size()>0){
            for(product__c prd: selectedprd)
            {
                decimal subtotal = prd.Quantity__c*prd.Price__c;
                priceperProduct.put(prd.id,subtotal);
                grandTotal = grandTotal + subtotal ;
            }
            return selectedprd;
        }
        else{
            return null;
        }
    }
    public pagereference grandtotal()
    {
     return null;
    }
    public decimal getgrandtotalDec()
    {
        system.debug('@@@grandtotal'+grandtotal);
        return grandTotal;
    }
    
    
    public void insertquoteLineItems()
    {
        //system.debug('Qunat'+quantitystr);
        for(product__c prdLoopVar :selectedprd)
        {
            Quote_Line_Item__c qlObj = new Quote_Line_Item__c();
            qlObj.Quotes__c= quoteObjid;
            qlObj.name = prdLoopVar.name;
            qlObj.Product__c = prdLoopVar.id;
            qlObj.Quantity__c = prdLoopVar.Quantity__c;
            qlObj.Total_Price__c = prdLoopVar.Quantity__c*prdLoopVar.Price__c;
            qlList.add(qlObj);
        }
        insert qlList;
        
    }
    public pagereference save()
    {
        insertquoteLineItems();
        quoteObj.Total_Price_on_Quote__c = grandtotal;
        update quoteObj;
        //quoteObj.Discount = orderObj.Discount__c;
        //orderObj.Quantity__c= quantitystr;
        insert orderObj;
        pagereference pg = new pagereference('/' + quoteObjid);
        pg.setRedirect(true);
        return pg;
    }
    
    public class productWrapper{
        
        public boolean isselected{get;set;}
        public product__c ProductWrapObj{get;set;}
        
        public productWrapper(product__c prd)
        {
            ProductWrapObj =prd;
            isselected = false;
            
        }
        
    }

}