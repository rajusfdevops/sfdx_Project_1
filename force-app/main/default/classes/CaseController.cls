public class CaseController {

@AuraEnabled(cacheable=true)
public static List<Case> getAllCases(){
    try{
        return [SELECT CaseNumber,Status,Origin,Priority,ClosedDate
             FROM Case 
             WITH SECURITY_ENFORCED];
    }catch(Exception ex){ //As a best practice
        throw new AuraHandledException(ex.getMessage());
    }
}
@AuraEnabled // You cannot use cacheable=true as we are performing a DML
public static void deleteCase(String sid){
    try{
        Case caseRecord = new Case();
        caseRecord.Id = sid;
        delete caseRecord;

    }catch(Exception ex){//As a best practice
        throw new AuraHandledException(ex.getMessage());
    }
}
}