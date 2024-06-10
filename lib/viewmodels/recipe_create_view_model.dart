import 'package:flutter/foundation.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/data/api/api_response.dart';
import 'package:the_bartender_app/models/ingredient.dart';
import 'package:the_bartender_app/models/recipe_create.dart';
import 'package:the_bartender_app/models/repositories/recipe_create_repository.dart';
import 'package:the_bartender_app/models/tool.dart';

class RecipeCreateViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Init');

  ApiResponse get response {
    return _apiResponse;
  }

  //* Call the recipe creation service and gets the apiresult of post method
  Future<ApiResponse> postData(
      {required RecipeCreate recipe,
      required List<Tool> toolList,
      required List<Ingredient> ingredientList,
      required bool isEdited}) async {
    _apiResponse = ApiResponse.loading('Posting recipe data');

    try {
      await RecipeCreateRepository().postData(
        recipe: recipe,
        ingredientList: ingredientList,
        toolList: toolList,
        isEdited: isEdited,
      );
      _apiResponse = ApiResponse.completed('SUCCESS');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      _apiResponse = ApiResponse.error('something_went_wrong'.i18n());
    }

    return _apiResponse;
  }
}
