public class JSON_Genrator_Serialize {
    
    public void createJSON(String name, String phone, String ind){
        
        //JSONGenarator Class
        //Step 1 : Create Json generator.
        System.JSONGenerator js = JSON.createGenerator(true);
        // Step 2 : Start writing JSON , End the JSON
        js.writeStartObject();
        
        try{
            
            Account acc = new Account();
            acc.Name= name;
            acc.Phone=phone;
            acc.Industry=ind;
            insert acc;
            
            js.writeStringField('Status', 'Success');
            js.writeIdField('Id',acc.Id);
            js.writeStringField('Message ','Account created successfully');
            js.writeNumberField('code',201);
            
        }catch(Exception e){
            js.writeStringField('Status', 'Failed');
            js.writeStringField('Message ',e.getMessage());
            js.writeNumberField('Line Number',e.getLineNumber());
            js.writeStringField('Type Name',e.getTypeName());
            js.writeNumberField('code',401);
        }
        
        js.writeEndObject();
        // Step 3: Generate the file
        String Result = js.getAsString();
        System.debug(Result);
    }
    
}