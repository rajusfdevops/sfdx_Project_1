public with sharing class ContactController {
 
@AuraEnabled(cacheable=true)
public static List<Contact> getContacts(String accId){
    String query;
    if(accId == ''){
        query = 'SELECT FirstName,LastName,Email,Phone FROM Contact WITH SECURITY_ENFORCED';

    }else {
        query = 'SELECT FirstName,LastName,Email,Phone FROM Contact WHERE AccountId= :accId WITH SECURITY_ENFORCED';
    }

    return Database.query(query);
    // return [SELECT FirstName, LastName, Email, Phone
    //         FROM Contact 
    //         WITH SECURITY_ENFORCED];
}


 @AuraEnabled(cacheable=true)
 public static List<Account> getAccounts(){
     return [SELECT Name
               FROM Account
               WITH SECURITY_ENFORCED];
 }
 
}