public class JSON_Parser_Ex2 {
    public String jsonString;
    
    public void readJSONData(){
        jsonString = '{"LastName":"Kumar","FirstName":"Sri","Customer":{"Name":"Pwc","Phone":"6789987578"},"Salary":35000}';
        //Step 1 --> Create a JSON Parser
        System.JSONParser jp= JSON.createParser(jsonString);
        
        //Step 2 --> Loop if Parser is not null
        
        while(jp.nextToken()!=null){
            //Step 3 ---> Based on business requirment , get text from JSON
            if(jp.getText()=='Customer'){
                
                //Step 4 --> Move to next token for data/value
                jp.nextToken();
                //Step 5 --> Read the values and convert to SFDC type
                Account acc=(Account)jp.readValueAs(Account.class);
                //Step 6 --> Perform Action SFDC action
                insert acc;
            }
            if(jp.getText()=='Salary'){
                jp.nextToken();
                Decimal sal=(Decimal)jp.getDecimalValue();
                System.debug(sal);
            }
            if(jp.getText()=='FirstName'){
                jp.nextToken();
                String EmpName=jp.getText();
                System.debug(EmpName);
            }
        }
    }
    
}