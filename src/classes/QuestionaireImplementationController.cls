public class QuestionaireImplementationController
{
public Questionnaire_Implementation__c quesObj{get;set;}

public QuestionaireImplementationController() {
Id id = ApexPages.currentPage().getParameters().get('id');
quesObj = (id == null) ? new Questionnaire_Implementation__c() :
[SELECT Name, Release_Duration__c FROM Questionnaire_Implementation__c WHERE Id = :id];
}
public pagereference save()
{
try {

insert quesObj;
} catch(System.DMLException e) {
ApexPages.addMessages(e);
return null;
}
PageReference pg = new PageReference('http://www.autorabit.com/');
     pg.setRedirect(true);
       return pg;

}



}