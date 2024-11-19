public class JSON_SOQL {
    
    public void sendAccountDetails(){
        
        System.JSONGenerator js = JSON.createGenerator(true);
        js.writeStartObject();
        try{
            
            List<Account> accList = [SELECT Name, Phone FROM Account Where Phone!=null];
            for(Account acc:accList){
                js.writeStringField('AccountName',acc.Name);
                js.writeStringField('Phone',acc.Phone);
                js.writeStringField('Status','Success');
            }
            
        }catch(Exception e){
            js.writeStringField('Status','Failed');
             js.writeStringField('message',e.getMessage());
            js.writeNumberField('code',401);
            
        }
        
        js.writeEndObject();
        
        String Result = js.getAsString();
        System.debug(Result);
    }

}