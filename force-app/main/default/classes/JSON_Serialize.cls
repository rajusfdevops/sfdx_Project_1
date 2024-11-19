public class JSON_Serialize {
    
    public void creatJSON(String name, String phone, String ind){
        System.JSONGenerator js = JSON.createGenerator(true); //step1 - Create JSON Generator.
        
        js.writeStartObject();//Step 2.1 - Start writing the JSON
        
        try{
            Account acc= new Account();
            acc.Name=name;
            acc.Phone=phone;
            acc.Industry=ind;            
            insert acc;
            
            js.writeStringField('Status','Success');
            js.writeIdField('Id',acc.Id);
            js.writeStringField('message','Account created successfully');
            js.writeNumberField('code',201);
            
        }catch(Exception e){
            
            js.writeStringField('Status','Failed');
            js.writeStringField('message',e.getMessage());
            js.writeNumberField('Line Number',e.getLineNumber());
            js.writeStringField('Type Name',e.getTypeName());
            js.writeNumberField('code',401);
            
        }
        
        js.writeEndObject(); //Step 2.2 - Ending the JSON
        
        String Result = js.getAsString(); //step 3 Get the final Output JSON.
        
        System.debug(Result);
    }

}