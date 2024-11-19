public class CaseTriggerHandler {

    public static void preventDeletionOfClosedcases(List<Case> caseList){
        for(Case caseRecord : caseList){
            if(caseRecord.Status == 'Closed'){
                caseRecord.addError('You cannot delete a Closed case');
            } 
        }        
    }
}