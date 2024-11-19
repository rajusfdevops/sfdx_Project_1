public class JSON_Attachement_Exam {

    public void JSON_AttachementFile(){
        
        //** Sirialize the Attachement***
        //Step 1 : Retrieve the image from the Document
        Document doc = [SELECT Id, Name, DeveloperName, ContentType, Type, Body FROM Document Where Name='SN_Integration_code'];
       // String jsd1 = JSON.serialize(doc);
       // System.debug(jsd1);
        //Step 2 : Serialize the attachement --> JSON Generator
        System.JSONGenerator js = JSON.createGenerator(true);
        //Step 3 : Writte Start Object, Write End Object
        js.writeStartObject();
        js.writeStringField('Name', 'Sevicenow_integration');
        //Blob (Binary Large Object)
        js.writeBlobField('Attachement', doc.Body);
        js.writeEndObject();
        // Step 4 : Generate the file
        String result =js.getAsString();
        System.debug(result);
        
        //***Deserialize the Attachement
        //Blob jsd2 =(Blob)JSON.deserialize(jsd1,Blob.class);
        //System.debug(jsd2);
     
        //Step1 : Create JSONParser
         System.JSONParser jp = JSON.createParser(result);
        //Step 2: Loop through the Token
        while(jp.nextToken()!=null){
          //Step 3 : Text = 'Attachement,  covert the JSON Format to the SFDC
            if(jp.getText()=='Attachement'){
                jp.nextToken();
                Blob jd2 = (Blob)jp.getBlobValue();
                System.debug(jd2);
                //insert Attachement into Document
                String folderId = [SELECT Id FROM Folder Where Name='SN_Integration_code'].Id;
                Document doc1 = new Document();
                doc1.Name= 'JSONAttachement_1';
                doc1.Body=jd2;
                doc1.ContentType='text/plain';
                doc1.type='txt';
                doc1.FolderId=folderId;
                doc1.IsPublic=true;
                insert doc1;
                
            }
        }
        
            }
}