public class QuestionaireImplementationController
{
    public Questionnaire_Implementation__c quesObj{get;set;}
    Public string companyName{get;set;}
    public string Emailval {get;set;}
    public List<List<SObject>> searchList{get;set;}
    public List<List<SObject>> searchListEmail{get;set;}
    Public string almTools{get;set;}
    public string challenges{get;set;}
    Public string currentversionControl{get;set;}
    public string deploymentUser{get;set;}
    Public string hoursEffort{get;set;}
    public string longTermGoals{get;set;}
    Public string noOfSandbox{get;set;}
    public string releaseDuration{get;set;}
    //Public string noOfSandbox{get;set;}
    public string shortTermGoals{get;set;}
    Public string sizeOfSandbox{get;set;}
    public string testAutomation{get;set;}
    public boolean isclick{get;set;}
    public Account [] accounts{get;set;}
    public Contact [] contacts{get;set;}
    public Lead [] leads{get;set;}
    public Opportunity [] opportunities{get;set;}
    
    
    public QuestionaireImplementationController() {
    isclick = false;
    
    }
    public void searchdata()
    {
    searchList = new List<List<SObject>>();
    searchListEmail  = new List<List<SObject>>();
        If(string.isnotempty(companyName))
        {
         searchList = [find :companyName  IN ALL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead];
        }
        If(string.isnotempty(Emailval))
        {
        searchListEmail = [find :Emailval IN EMAIL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead];
        }
        system.debug('@@'+searchList);
        system.debug('@@'+searchListEmail );
        if(searchList.size()>0)
        {
        if(searchList[0]!=null&& searchList[0].size()>0){
        accounts = ((List<Account>)searchList[0]);
        }
        if(searchList[1]!=null&& searchList[1].size()>0){
        contacts = ((List<Contact>)searchList[1]);
        }
        if(searchList[2]!=null && searchList[2].size()>0){
        opportunities = ((List<Opportunity>)searchList[2]);
        }
        if(searchList[3]!=null&& searchList[3].size()>0){
        leads = ((List<Lead>)searchList[3]);
        }
        }
        if(searchListEmail.size()>0)
        {
        if(searchListEmail[0]!=null&& searchListEmail[0].size()>0){
        accounts = ((List<Account>)searchListEmail[0]);
        }
        if(searchListEmail[1]!=null&& searchListEmail[1].size()>0){
        contacts = ((List<Contact>)searchListEmail[1]);
        }
        if(searchListEmail[2]!=null && searchListEmail[2].size()>0){
        opportunities = ((List<Opportunity>)searchListEmail[2]);
        }
        if(searchListEmail[3]!=null&& searchListEmail[3].size()>0){
        leads = ((List<Lead>)searchListEmail[3]);
        }
    }
    }
    public PageReference Save()
    {
    system.debug('@@@@@'+companyName);
    searchdata();
    isclick = true;
        try {
            quesObj = new Questionnaire_Implementation__c();
            quesObj.ALM_Tools__c = almTools;
            quesObj.Challenges__c= challenges;
            quesObj.Current_Version_Control_Tool_If_Exists__c = currentversionControl;
            quesObj.Deployment_User__c = deploymentUser;
            quesObj.Hours_of_effort__c = hoursEffort;
            quesObj.Email__c = Emailval;
            quesObj.Company_Name__c = companyName;
            quesObj.Long_Term_Goals__c = longTermGoals;
            quesObj.No_of_Sanbox_in_Release__c = noOfSandbox;
            quesObj.Release_Duration__c = releaseDuration;
            quesObj.Short_Term_Goals_with_current_RLM__c = shortTermGoals;
            quesObj.Size_of_Sanboxes__c = sizeOfSandbox;
            quesObj.Size_of_Sanboxes__c = testAutomation;
            insert quesObj;
        } catch(System.DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }
        PageReference pg = page.ThankYouPage;
        pg.setRedirect(true);
        return pg;

    }
}