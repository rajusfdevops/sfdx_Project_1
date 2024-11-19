public class JSON_Attachement_1{
    
    public void JSONAttachFile(){
        //***Serialize the Attachment***
        //Step 1 : Retrieve the text from the Document
        Document doc=[SELECT Id, Name, DeveloperName, Body FROM Document WHERE Name='SN_Integration_code'];
        //Step 2 : Serialize the Attachment --> Create JSONGenerator
        System.JSONGenerator js = JSON.createGenerator(true);
        //Step 3 : Write Start Object , writeEnd Object
        js.writeStartObject();
        //Blob (Binary Large Object)
        js.writeBlobField('Attachement', doc.Body);        
        js.writeEndObject();
        //Step 4 : Generate a file
        String result=js.getAsString();
        System.debug(result);
    }

}