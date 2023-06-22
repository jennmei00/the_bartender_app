import 'package:flutter/material.dart';
import 'package:the_bartender_app/data/api/api_response.dart';
import 'package:the_bartender_app/models/recipe.dart';
import 'package:the_bartender_app/models/repositories/recipe_respository.dart';

class RecipeDetailViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  RecipeDetail? _recipe;

  ApiResponse get response {
    return _apiResponse;
  }

  RecipeDetail? get recipe {
    return _recipe;
  }

  //* Call the recipe service and gets the data of requested recipe data
  Future<void> fetchRecipeData(String recipeId) async {
    _apiResponse = ApiResponse.loading('Fetching recipe data');
    notifyListeners();
    try {
      RecipeDetail recipe =
          await RecipeRepository().fetchRecipeDetail(recipeId);
      setSelectedRecipe(recipe);
      _apiResponse = ApiResponse.completed(recipe);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  void setSelectedRecipe(RecipeDetail recipe) {
    _recipe = recipe;
    notifyListeners();
  }
}
