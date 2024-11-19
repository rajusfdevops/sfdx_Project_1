public class JSON_Attachement{
    
    public void JSONAttachFile(){
        //***Serialize the Attachment***
        //Step 1 : Retrieve the text from the Document
        Document doc=[SELECT Id, Name, DeveloperName, Body FROM Document WHERE Name='SN_Integration_code'];
        String jsd1 = JSON.serialize(doc);
        System.debug(jsd1);
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
        
        //***Deserialize the Attachement***
        
        //Blob jsd2 = (Blob)JSON.deserialize(result,Blob.class);
        //System.debug(jsd2);
        //Step 1 : Create JSONParser
        System.JSONParser jp = JSON.createParser(result);
        //Step 2 : Loop through the token
        
        while(jp.nextToken()!=null){
            //Step 3 : text = 'Attachement', convert the JSON Format to the SFDC
            if(jp.getText()=='Attachement'){
                jp.nextToken();
              Blob jd2 = (Blob)jp.getBlobValue();
              System.debug(jd2);
                //insert Attachement into Document
                String folderId = [SELECT Id FROM Folder Where Name ='SN_Integration_code'].Id;
                Document doc1 = new Document();
                doc1.Name='JSONAttachement';
                doc1.Body=jd2;
                doc1.ContentType='code/text';
                doc1.Type='txt';
                doc1.FolderId=folderId;
                doc1.IsPublic=true;
                insert doc1;
            }
        }
    }

}