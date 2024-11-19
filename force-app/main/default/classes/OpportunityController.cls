public with sharing class OpportunityController {

   @AuraEnabled(cacheable=true) //you can not perform any DML operation inside this method
   public static List<Opportunity> getAllOpportunities(){
       return [SELECT Name,StageName,CloseDate, Amount FROM Opportunity
       WITH SECURITY_ENFORCED];
   }

    @AuraEnabled(cacheable=true) //you can not perform any DML operation inside this method
   public static List<Opportunity> getWonOpportunities(){
       return [SELECT Name,StageName,CloseDate, Amount 
       FROM Opportunity
       WHERE StageName = 'Closed Won'
       WITH SECURITY_ENFORCED];
   }

   @AuraEnabled(cacheable=true) //you can not perform any DML operation inside this method
   public static List<Opportunity> get_Top10_Opportunities(){
       return [SELECT Name,StageName,CloseDate, Amount 
       FROM Opportunity
       WHERE Amount != null
       ORDER BY Amount DESC
       LIMIT 10];
   }



}