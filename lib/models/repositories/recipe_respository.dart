import 'package:the_bartender_app/data/services/base_service.dart';
import 'package:the_bartender_app/data/services/general_service.dart';
import 'package:the_bartender_app/models/recipe.dart';
import 'package:the_bartender_app/models/recipe_filter.dart';

class RecipeRepository {
  final BaseService _recipeService = GeneralService();

  Future<List<Recipe>> fetchRecipeList(String searchText,
      {RecipeFilter? recipeFilter}) async {
    String baseURL =
        'recipe?select=recipe_id,name,rating,alcoholic,user(user_id,username),season(season_id,name,name_de),drink_type(drink_type_id, name, name_de)&name=ilike.*$searchText*';

    //*Transform filters into PostgREST Statement
    String seasonFilter = '';
    String drinkTypeFilter = '';
    String alcoholicFilter = '';

    if (recipeFilter != null) {
      if (recipeFilter.seasonnList.isNotEmpty) {
        seasonFilter += '&or=(';
        for (var e in recipeFilter.seasonnList) {
          seasonFilter += 'season_id.eq.${e.id}';
          if (e != recipeFilter.seasonnList.last) {
            seasonFilter += ',';
          }
        }
        seasonFilter += ')';
      }

      if (recipeFilter.drinkTypeList.isNotEmpty) {
        drinkTypeFilter += '&or=(';
        for (var e in recipeFilter.drinkTypeList) {
          drinkTypeFilter += 'drink_type_id.eq.${e.id}';
          if (e != recipeFilter.drinkTypeList.last) {
            drinkTypeFilter += ',';
          }
        }
        drinkTypeFilter += ')';
      }

      if (recipeFilter.alcoholicNo || recipeFilter.alcoholicYes) {
        alcoholicFilter += '&or=(';

        if (recipeFilter.alcoholicNo) {
          alcoholicFilter += 'alcoholic.is.false';
        }
        if (recipeFilter.alcoholicNo && recipeFilter.alcoholicYes) {
          alcoholicFilter += ',';
        }
        if (recipeFilter.alcoholicYes) {
          alcoholicFilter += 'alcoholic.is.true';
        }

        alcoholicFilter += ')';
      }
    }

    dynamic response = await _recipeService.getResponse(baseURL + seasonFilter + drinkTypeFilter + alcoholicFilter);
    final List<dynamic> jsonData = response;
    List<Recipe> recipeList =
        jsonData.map((json) => Recipe.fromMap(json)).toList();
    return recipeList;
  }

  Future<RecipeDetail> fetchRecipeDetail(String recipeId) async {
    dynamic response = await _recipeService
        .getResponse('detail_recipe_view?recipe_id=eq.$recipeId');
    final dynamic jsonData = response;
    RecipeDetail recipe = RecipeDetail.fromMap(jsonData[0]);
    return recipe;
  }
}
