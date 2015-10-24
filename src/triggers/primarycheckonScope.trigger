trigger primarycheckonScope on Scope_Poc_Information__c (before insert,after insert,after update) {

    Id selectedRecId;
    List<Scope_Poc_Information__c> scopePOCneList = new List<Scope_Poc_Information__c>();
    list<Scope_Poc_Information__c> updateList=new list<Scope_Poc_Information__c >();
    List<id> scopeIDList = new List<id>();
    for(Scope_Poc_Information__c add:Trigger.new)
    {
        if(add.Is_primary__c)
        {
            selectedRecId = add.Id;
            scopeIDList.add(add.Id);
            scopePOCneList.add(add);
        }
    }
    list<Scope_Poc_Information__c> updatenewList = [select id,name,Is_primary__c from Scope_Poc_Information__c where id not in : scopeIDList];
    for(Scope_Poc_Information__c aa:updatenewList )
    {
        aa.Is_primary__c=false;
        updateList.add(aa);

    }

    update updateList;

}