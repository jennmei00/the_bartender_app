import 'package:the_bartender_app/data/services/base_service.dart';
import 'package:the_bartender_app/data/services/recipe_service.dart';
import 'package:the_bartender_app/models/recipe.dart';

class RecipeRepository {
  final BaseService _recipeService = RecipeService();

  Future<List<Recipe>> fetchRecipeList (String searchText) async {
    dynamic response = await _recipeService.getResponse('recipe?select=recipe_id,name,rating,alcoholic,season(season_id,name),drink_type(drink_type_id, name)&name=ilike.*$searchText*');
    final List<dynamic> jsonData = response;
    List<Recipe> recipeList = jsonData.map((json) => Recipe.fromMap(json)).toList();
    return recipeList;
  }

  
  Future<RecipeDetail> fetchRecipeDetail (String recipeId) async {
    dynamic response = await _recipeService.getResponse('detail_recipe_view?recipe_id=eq.$recipeId');
    final dynamic jsonData = response;
    RecipeDetail recipe = RecipeDetail.fromMap(jsonData[0]);
    return recipe;
  }
}