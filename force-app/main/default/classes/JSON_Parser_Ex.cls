public class JSON_Parser_Ex {
    public String jData{get;set;}
    public Map<String,Object> result{set;get;}
    public JSON_Parser_Ex(){
        result=new Map<String, Object>();
        jData = '{"Name": "Ashwini","Marks":[45,67,89], "city": "Bangalore"}';
        System.JSONParser jp= JSON.createParser(jData);
        
        while(jp.nextToken()!=null){
            result.put(jp.getText(),jp.getCurrentToken());
        }
    }
    
}