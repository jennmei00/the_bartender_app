import 'dart:convert';
import 'dart:io';

import 'package:localization/localization.dart';
import 'package:the_bartender_app/data/api/api_exception.dart';
import 'package:the_bartender_app/data/services/base_service.dart';
import 'package:http/http.dart' as http;
import 'package:the_bartender_app/models/ingredient.dart';
import 'package:the_bartender_app/models/recipe_create.dart';
import 'package:the_bartender_app/models/tool.dart';
import 'package:uuid/uuid.dart';

class GeneralService extends BaseService {
  @override
  Future getResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(baseUrl + url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader:
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidGhlX2JhcnRlbmRlciJ9.rBZOey3_D5-A05DRRQD8IDLYXfHhtQjAg0u-g4zQ_XU'
      });
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('no_internet_connection'.i18n());
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            '${'fetch_data_exception_text'.i18n()} ${response.statusCode}');
    }
  }

  @override
  Future postData(
      {required RecipeCreate recipe,
      required List<Tool> toolList,
      required List<Ingredient> ingredientList}) async {
    dynamic responseJson;

    try {
      //* Post Recipe
      await http.post(Uri.parse('${baseUrl}recipe'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidGhlX2JhcnRlbmRlciJ9.rBZOey3_D5-A05DRRQD8IDLYXfHhtQjAg0u-g4zQ_XU'
          },
          body: jsonEncode(recipe.toMap()));

      //* Post Recipe2Tool
      if (toolList.isNotEmpty) {
        await http.post(
          Uri.parse('${baseUrl}recipe2tool'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidGhlX2JhcnRlbmRlciJ9.rBZOey3_D5-A05DRRQD8IDLYXfHhtQjAg0u-g4zQ_XU'
          },
          body: jsonEncode(toolList
              .map((e) => {
                    'recipe2tool_id': const Uuid().v4(),
                    'recipe_id': recipe.recipeId,
                    'tool_id': e.id,
                  })
              .toList()),
        );
      }

      //* Check if Ingredients exists
      //* If it not exists, then post new ingredient
      //* If it exists, then replace ingredient id with existing id
      for (final element in ingredientList) {
        final response = await http.get(
            Uri.parse('${baseUrl}ingredient?name=eq.${element.name}'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.authorizationHeader:
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidGhlX2JhcnRlbmRlciJ9.rBZOey3_D5-A05DRRQD8IDLYXfHhtQjAg0u-g4zQ_XU'
            });

        if (returnResponse(response).length == 0) {
          await http.post(
            Uri.parse('${baseUrl}ingredient'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.authorizationHeader:
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidGhlX2JhcnRlbmRlciJ9.rBZOey3_D5-A05DRRQD8IDLYXfHhtQjAg0u-g4zQ_XU'
            },
            body: jsonEncode({
              'ingredient_id': element.id,
              'name': element.name,
            }),
          );
        } else {
          ingredientList[
                  ingredientList.indexWhere((element) => element == element)]
              .id = returnResponse(response).first['ingredient_id'];
        }

        //* Post Recipe2Ingredient
        await http.post(
          Uri.parse('${baseUrl}recipe2ingredient'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidGhlX2JhcnRlbmRlciJ9.rBZOey3_D5-A05DRRQD8IDLYXfHhtQjAg0u-g4zQ_XU'
          },
          body: jsonEncode(ingredientList
              .map((e) => {
                    "recipe2ingredient_id": const Uuid().v4(),
                    "recipe_id": recipe.recipeId,
                    "ingredient_id": e.id,
                    "unit_id": e.unit.id,
                    "amount": e.amount,
                  })
              .toList()),
        );
      }
    } on SocketException {
      throw FetchDataException('no_internet_connection'.i18n());
    }
    return responseJson;
  }
}
