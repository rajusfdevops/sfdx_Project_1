public class JSON_SOQL_EX {
    public void sendAccountDetails(){
        System.JSONGenerator js = JSON.createGenerator(true);
        js.writeStartObject();
        try{
            
            List<Account> accList = [SELECT Name, Phone, Industry FROM Account Where Phone!=null];
            
            for(Account acc:accList){
                js.writeStringField('AccountName',acc.Name);
                js.writeStringField('Phone',acc.Phone);
                js.writeStringField('Phone',acc.Industry);
                js.writeStringField('Status','Success');
                js.writeNumberField('Code', 201);
            }
            
        }catch(Exception e){
            js.writeStringField('Status','Failed');
            js.writeStringField('Message',e.getMessage());
            js.writeNumberField('Code', 401);
            
        }
        js.writeEndObject();
        
        String Result = js.getAsString();
        System.debug(Result);
    }
}