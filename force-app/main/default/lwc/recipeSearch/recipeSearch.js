import { LightningElement } from "lwc";
import getRandomRecipe from "@salesforce/apex/Spoonacular.getRandomRecipe";
import getRecipeByIngredients from "@salesforce/apex/Spoonacular.getRecipeByIngredients";
import getRecipe from "@salesforce/apex/Spoonacular.getRecipe";

export default class RecipeSearch extends LightningElement {
  recipes = [];
  fetchRandomRecipe() {
    getRandomRecipe()
      .then((data) => {
        this.recipes =
          JSON.parse(data) && JSON.parse(data).recipes
            ? JSON.parse(data).recipes
            : [];
      })
      .catch((error) => {
        console.error(error);
      });
  }

  handleSearch() {
    const searchInput = this.template.querySelector(".search-input").value;
    if (isNaN(searchInput)) {
      this.fetchRecipesByIngredients(searchInput);
    } else {
      this.fetchRecipeById(searchInput);
    }
  }

  fetchRecipesByIngredients(ingredients) {
    getRecipeByIngredients({ ingredients })
      .then((data) => {
        this.recipes = JSON.parse(data);
      })
      .catch((error) => {
        console.error(error);
      });
  }

  fetchRecipeById(recipeId) {
    getRecipe({ recipeId })
      .then((data) => {
        this.recipes = [JSON.parse(data)];
      })
      .catch((error) => {
        console.error(error);
      });
  }
}
