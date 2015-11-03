trigger primarycheckonScope on Scope_Poc_Information__c (before insert,before update) {

    list<Scope_Poc_Information__c> updateList=new list<Scope_Poc_Information__c >();
    List<id> scopeIDList = new List<id>();
    List<String> selectedVal =  new List<String>();
    List<String> availableVal =  new List<String>();
    Schema.DescribeFieldResult fieldResult = Scope_Poc_Information__c.Scope__c.getDescribe();
    List<Schema.PicklistEntry> pleList = fieldResult.getPicklistValues();
    
    for(Schema.PicklistEntry pleVar :pleList)
    {
        availableVal.add(pleVar.getLabel());
    }
    system.debug('@@@'+availableVal);
    
    if(trigger.isbefore)
    {
        for(Scope_Poc_Information__c add:Trigger.new)
        {
           if(add.Is_primary__c)
            {
                selectedVal.add(add.Scope__c);
                scopeIDList.add(add.Id);
                system.debug('@@@@'+selectedVal);
            }
            for(Integer i=0;i<=selectedVal.size();i++)
            {
                availableVal.remove(i); 
            
            if(availableVal.size()>0)
            {
                system.debug('@@@@ after remving'+availableVal);
                add.Out_ofScope__c = string.join(availableVal,',');
            }
            else{
            add.Out_ofScope__c = 'None';
            }
            }
            
           updateList.add(add);
 
        }
        
    }
   
    system.debug('@@'+selectedVal);
    list<Scope_Poc_Information__c> updatenewList = [select id,name,Is_primary__c from Scope_Poc_Information__c where id not in : scopeIDList];
    for(Scope_Poc_Information__c aa:updatenewList )
    {
        aa.Is_primary__c=false;
        updateList.add(aa);

    }
    //update updateList;
}