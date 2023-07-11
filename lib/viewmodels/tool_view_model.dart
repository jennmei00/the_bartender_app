import 'package:flutter/material.dart';
import 'package:the_bartender_app/data/api/api_response.dart';
import 'package:the_bartender_app/models/repositories/tool_repository.dart';
import 'package:the_bartender_app/models/tool.dart';

class ToolViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  List<Tool>? _toolList;

  ApiResponse get response {
    return _apiResponse;
  }

  List<Tool>? get toolList {
    return _toolList;
  }

  //* Call the tool service and gets the data of requested tool data
  Future<void> fetchData() async {
    _apiResponse = ApiResponse.loading('Fetching recipe data');
    notifyListeners();
    try {
      List<Tool> tools =
          await ToolRepository().fetchData();
      setSelectedTool(tools);
      _apiResponse = ApiResponse.completed(tools);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  void setSelectedTool(List<Tool> tools) {
    _toolList = tools;
  }
}
