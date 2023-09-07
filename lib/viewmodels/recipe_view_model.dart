import 'package:flutter/foundation.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/data/api/api_response.dart';
import 'package:the_bartender_app/models/recipe.dart';
import 'package:the_bartender_app/models/recipe_filter.dart';
import 'package:the_bartender_app/models/repositories/recipe_respository.dart';

class RecipeViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  List<Recipe>? _recipeList;
  String? _searchText;

  ApiResponse get response {
    return _apiResponse;
  }

  List<Recipe>? get recipe {
    return _recipeList;
  }

  String? get searchText {
    return _searchText;
  }

  //* Call the recipe service and gets the data of requested recipe data
  Future<void> fetchRecipeData(String searchText,
      {RecipeFilter? recipeFilter, bool isUserRecipes = false}) async {
    _apiResponse = ApiResponse.loading('Fetching recipe data');
    notifyListeners();
    try {
      List<Recipe> recipeList =
          await RecipeRepository().fetchRecipeList(searchText, recipeFilter: recipeFilter, isUserRecipes: isUserRecipes,);
      setSelectedRecipe(recipe);
      _apiResponse = ApiResponse.completed(recipeList);
    } catch (e) {
      _apiResponse = ApiResponse.error('something_went_wrong'.i18n());
      if (kDebugMode) {
        print(e);
      }
    }
    notifyListeners();
  }

  void setSelectedRecipe(List<Recipe>? recipeList) {
    _recipeList = recipe;
  }

  void setSearchText(String searchText) {
    _searchText = searchText;
  }
}
