public with sharing class SpoonacularController {
    public String recipeId { get; set; }
    public String ingredients { get; set; }
    public String recipeImage { get; set; }
    public String recipeDescription { get; set; }

    // Method to get a random recipe
    public void getRandomRecipe() {
        String response = Spoonacular.getRandomRecipe();
        parseSingleRecipeResponse(response);
    }

    // Method to get a recipe by ID
    public void getRecipe() {
        String response = Spoonacular.getRecipe(recipeId);
        parseSingleRecipeResponse(response);
    }

    // Method to get recipes by ingredients
    public void getRecipeByIngredients() {
        String response = Spoonacular.getRecipeByIngredients(ingredients);
        parseMultipleRecipesResponse(response);
    }

    // Helper method to parse the JSON response for a single recipe
    private void parseSingleRecipeResponse(String response) {
        if (String.isNotBlank(response)) {
            Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(response);
            if (jsonResponse.containsKey('recipes')) {
                List<Object> recipes = (List<Object>) jsonResponse.get('recipes');
                if (!recipes.isEmpty()) {
                    Map<String, Object> recipe = (Map<String, Object>) recipes[0];
                    recipeImage = (String) recipe.get('image');
                    recipeDescription = (String) recipe.get('summary');
                }
            } else {
                recipeImage = (String) jsonResponse.get('image');
                recipeDescription = (String) jsonResponse.get('summary');
            }
        } else {
            recipeImage = '';
            recipeDescription = 'No recipe found.';
        }
    }

    // Helper method to parse the JSON response for multiple recipes
    private void parseMultipleRecipesResponse(String response) {
        if (String.isNotBlank(response)) {
            List<Object> jsonResponse = (List<Object>) JSON.deserializeUntyped(response);
            if (!jsonResponse.isEmpty()) {
                Map<String, Object> recipe = (Map<String, Object>) jsonResponse[0];
                recipeImage = (String) recipe.get('image');
                recipeDescription = (String) recipe.get('title'); // Assuming 'title' is the description for ingredients search
            } else {
                recipeImage = '';
                recipeDescription = 'No recipes found.';
            }
        } else {
            recipeImage = '';
            recipeDescription = 'No recipes found.';
        }
    }
}