import 'package:the_bartender_app/models/ingredient.dart';
import 'package:the_bartender_app/models/recipe_create.dart';
import 'package:the_bartender_app/models/tool.dart';

abstract class BaseService {
  final String baseUrl = 'http://192.168.1.2:3000/'; //  /192.168.178.164 => PC *.95 => Laptop

  Future<dynamic> getResponse(String url);
  Future<dynamic> postData({required RecipeCreate recipe,
      required List<Tool> toolList,
      required List<Ingredient> ingredientList});
}