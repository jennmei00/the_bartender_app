import 'dart:convert';
import 'dart:io';

import 'package:localization/localization.dart';
import 'package:the_bartender_app/data/api/api_exception.dart';
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
}
