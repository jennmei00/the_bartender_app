import 'package:the_bartender_app/data/services/base_service.dart';
import 'package:the_bartender_app/data/services/general_service.dart';
import 'package:the_bartender_app/models/unit.dart';

class UnitRepository {
  final BaseService _unitService = GeneralService();

  Future<List<Unit>> fetchData() async {
    dynamic response = await _unitService.getResponse('unit');
    final List<dynamic> jsonData = response;
    List<Unit> unitList = jsonData.map((json) => Unit.fromMap(json)).toList();
    return unitList;
  }
}
