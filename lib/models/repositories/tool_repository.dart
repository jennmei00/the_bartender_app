import 'package:the_bartender_app/data/services/base_service.dart';
import 'package:the_bartender_app/data/services/general_service.dart';
import 'package:the_bartender_app/models/tool.dart';

class ToolRepository {
  final BaseService _tooleService = GeneralService();

  Future<List<Tool>> fetchData() async {
    dynamic response = await _tooleService.getResponse('tool');
    final List<dynamic> jsonData = response;
    List<Tool> toolList = jsonData.map((json) => Tool.fromMap(json)).toList();
    return toolList;
  }
}