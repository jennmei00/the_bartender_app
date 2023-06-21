import 'dart:convert';
import 'dart:io';

import 'package:the_bartender_app/data/services/base_service.dart';
import 'package:http/http.dart' as http;

class RecipeService extends BaseService {
  @override
  Future getResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(baseUrl + url));
      responseJson = returnResponse(response);
    } on SocketException {
      //TODOadd custom exceptions
      print('SOCKETEXCPETION');
      throw Exception();
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      //TODOadd custom exceptions
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw Exception();
      case 401:
      case 403:
        throw Exception();
      case 500:
      default:
        throw Exception();
    }
  }
}
