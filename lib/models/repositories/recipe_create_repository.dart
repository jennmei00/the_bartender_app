import 'package:the_bartender_app/data/services/base_service.dart';
import 'package:the_bartender_app/data/services/general_service.dart';
import 'package:the_bartender_app/models/ingredient.dart';
import 'package:the_bartender_app/models/recipe_create.dart';
import 'package:the_bartender_app/models/tool.dart';

class RecipeCreateRepository {
  final BaseService _recipeService = GeneralService();

  Future<dynamic> postData(
      {required RecipeCreate recipe,
      required List<Tool> toolList,
      required List<Ingredient> ingredientList}) async {

    dynamic response = await _recipeService.postData(
        recipe: recipe, ingredientList: ingredientList, toolList: toolList);

    return response;
  }
}
