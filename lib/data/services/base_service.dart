import 'package:the_bartender_app/models/ingredient.dart';
import 'package:the_bartender_app/models/recipe_create.dart';
import 'package:the_bartender_app/models/tool.dart';
import 'package:the_bartender_app/utils/globals.dart';

abstract class BaseService {
  final String baseUrl = ipAdress ??
      'http://192.168.178.164:3000/'; //  /192.168.178.164 => PC *.95 => Laptop

  Future<dynamic> getResponse(String url);
  Future<dynamic> postData(
      {required RecipeCreate recipe,
      required List<Tool> toolList,
      required List<Ingredient> ingredientList,
      required bool isEdited});
}
