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
    
    
    public QuestionaireImplementationController() {
         /*If(string.isnotempty(companyName))
         {
         searchList = [find :companyName  IN ALL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead];
        }
        If(string.isnotempty(Emailval))
        {
        searchListEmail = [find :Emailval IN EMAIL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead];
        }
        system.debug('@@'+searchList );
        system.debug('@@'+searchListEmail );*/
        //Account [] accounts = ((List<Account>)searchList[0]);
        //Contact [] contacts = ((List<Contact>)searchList[1]);
        //Opportunity [] opportunities = ((List<Opportunity>)searchList[2]);
        //Lead [] leads = ((List<Lead>)searchList[3]);
    }
    public PageReference Save()
    {
        try {
            quesObj = new Questionnaire_Implementation__c();
            quesObj.ALM_Tools__c = almTools;
            quesObj.Challenges__c= challenges;
            quesObj.Current_Version_Control_Tool_If_Exists__c = currentversionControl;
            quesObj.Deployment_User__c = deploymentUser;
            quesObj.Hours_of_effort__c = hoursEffort;
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