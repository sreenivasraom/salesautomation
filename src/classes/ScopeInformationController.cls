public class ScopeInformationController {

    public ScopeInformationController(ApexPages.StandardController controller) {

    }

    
    public String opptyId{get;set;}
    public Opportunity OppObj{get;set;}
    public Scope_Poc_Information__c scopeObj{get;set;}
    public List<Scope_Poc_Information__c> scopeObjList{get;set;}
    
    public ScopeInformationController()
    {
        opptyId = System.currentPageReference().getParameters().get('opptyId');
        
        
    }
    public List<Scope_Poc_Information__c> getScopinfo()
    {
    scopeObjList = [Select id,name,Approver__c,AutoRABIT_POC__c,Opportunity__c,Opportunity__r.name,Out_ofScope__c,Person_to_Contact__c,Poc_End_Date__c,Poc_Scope__c,Poc_Start_Date__c from Scope_Poc_Information__c where Opportunity__r.id = :opptyId];
    system.debug('@@'+scopeObjList);
     return scopeObjList;
    }
       
}