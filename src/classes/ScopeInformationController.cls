public class ScopeInformationController {

    public ScopeInformationController(ApexPages.StandardController controller) {

    }

    public String opptyId{get;set;}
    public Opportunity OppObj{get;set;}
    public Scope_Poc_Information__c scpVar2{get;set;}
    public List<Scope_Poc_Information__c> scopeObjList{get;set;}
    
    public ScopeInformationController()
    {
        opptyId = System.currentPageReference().getParameters().get('opptyId');
    }
    public List<Scope_Poc_Information__c> getScopinfo()
    {
        OppObj = [select id,Account.name from opportunity where id =:opptyId  ];
        try
        {
            scopeObjList = [Select id,name,Scope__c ,Approver__c,AutoRABIT_POC__c,AutoRABIT_POC__r.name,sign_off_Criteria__c,Assumptions__c,License_provision_complete__c,Demo_Completed__c,Opportunity__c,Opportunity__r.name,Opportunity__r.Account.name,Out_ofScope__c,Person_to_Contact__c,Poc_End_Date__c,Poc_Scope__c,Poc_Start_Date__c from Scope_Poc_Information__c where Opportunity__r.id = :opptyId and Is_primary__c=true];
            system.debug('@@'+scopeObjList);
            
        }
        Catch(Exception e)
        {
            System.debug('The following exception has occurred: ' + e.getMessage());

        }
        return scopeObjList;
    }    
}