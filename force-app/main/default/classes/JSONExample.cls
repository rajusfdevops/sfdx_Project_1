public class JSONExample {
    
    public static void jsonExample1(){
       StaticResource st = [Select id,name,body from staticResource where name='JSONFormate' limit 1];
       System.debug('Json data from system 1 ='+st.Body.toString());
       JSONParser parser = JSON.createParser(st.Body.toString());
       parser.nextToken();
       parser.nextToken();
       System.debug(parser.getCurrentName());
        
    }

}