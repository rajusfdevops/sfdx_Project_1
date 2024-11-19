public class http_postalcode {
    public List<String> places{set;get;}
    public string pincode{set;get;}
    
    public void getPostalDetails(){
        String endpoint='https://api.postalpincode.in/pincode/'+pincode;
        places = new List<String>();
        HTTP p=new HTTP();
        HTTPRequest request=new HTTPRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        
        HTTPResponse response = p.send(request);
        String jsonString=response.getBody();
        
        // Deserialize JSON
        System.JSONParser jp=JSON.createParser(jsonString);
        while(jp.nextToken()!=null){
            if(jp.getText()=='Name'){
                jp.nextToken();
                if(jp.getText()!=null){
                   places.add(jp.getText()); 
                }
            }
        }
        
        
    }

}