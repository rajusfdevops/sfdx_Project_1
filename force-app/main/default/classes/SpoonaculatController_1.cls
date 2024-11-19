public with sharing class SpoonaculatController_1 {
    
    public String receipeId{set;get;}
    public String ingredients{set;get;}
    public String receipeImage{set;get;}
    public String receipeDescription{set;get;}
    
    //Method to get a Random receipe 
    public void getRandomReceipe(){
        String response = Spoonacular.getRandomRecipe();
        parseSingleReceipeResponse(response);
        System.debug('Response'+response);
    }
    
    //Method to get Receipe by Id
    public void getReceipe(){
        String response = Spoonacular.getRecipe(receipeId);
        parseSingleReceipeResponse(response);
    }
    
    //Method to get by Ingredients
    public void getRecipeByIngredients(){
        String response = Spoonacular.getRecipeByIngredients(ingredients);
        parseMultipleReceipeResponse(response);
    }
    
    //Helper method tp parse Json response for the single receipe
    private void parseSingleReceipeResponse(String response){
        System.debug('Before Response '+response);
        if(String.isNotBlank(response)){
        Map<String,Object> jsonResponse = (Map<String,Object>) JSON.deserializeUntyped(response);
        System.debug('After using Map Response '+response);
        if(jsonResponse.containsKey('recipes')) {
        List<Object> receipes = (List<Object>) jsonResponse.get('recipes');
        System.debug('After using List Response '+response);
        
        if(!receipes.isEmpty()){
           Map<String, Object> receipe= (Map<String, Object>) receipes[0];
            receipeImage=(String) receipe.get('image');
            receipeDescription=(String) receipe.get('summary');
        }
        }else{
             receipeImage = (String) jsonResponse.get('image');
             receipeDescription = (String) jsonResponse.get('summary');
        }
        }else{
            receipeImage='';
            receipeDescription='No receipe found';
        }
    }
    
    //Helper method to parse Json response for Multiple receipe
    private void parseMultipleReceipeResponse(String response){
        System.debug('Before Response '+response);
        if(String.isNotBlank(response)){
        List<Object> jsonResponse= (List<Object>) JSON.deserializeUntyped(response);
              System.debug('After using List Response '+response);
        if(!jsonResponse.isEmpty()){
            Map<String, Object> receipe = (Map<String,Object>) jsonResponse[2];
             System.debug('After using Map Response '+response);
            receipeImage=(String) receipe.get('image');
            receipeDescription=(String) receipe.get('title');
        }else{
            receipeImage='';
            receipeDescription='No receipes found';            
        }
        }else{
            receipeImage='';
            receipeDescription='No receipes found';
        }
    }

}