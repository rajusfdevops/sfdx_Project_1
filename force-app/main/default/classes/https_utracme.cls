public class https_utracme {
    
    public String ipAddress{set;get;}
    public String xml {set;get;}
    
    public void getipAddress(){
        String endpoint='https://utrace.me/?query='+ipAddress;      //Step 1 : Creat Endpoint
        //Step2 : Initialize the http protocol
        Http hp=new Http(); 
        //Step 3 : create request structure
        HTTPRequest request = new HTTPRequest();
        request.setEndpoint(endpoint);  //Step 4 : On request structure x, set endpoint(address)
        request.setMethod('GET');        //Step 5 : on request , set Method - GET, POST, PUT, DELETE
        request.setTimeout(20000);
        try{
        HTTPResponse response = hp.send(request);
        xml =response.getBody();  // XML format 
        
        //Deserialize XML
        DOM.Document doc =new DOM.Document();
        doc.load(xml);
        DOM.XmlNode root=doc.getRootElement();
            }catch(Exception e){
                
                System.debug('Error : '+e.getMessage());
                xml='Error : '+e.getMessage();
            }
    }

}