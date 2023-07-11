import 'package:the_bartender_app/data/services/base_service.dart';
import 'package:the_bartender_app/data/services/general_service.dart';
import 'package:the_bartender_app/models/drink_type.dart';

class DrinkTypeRepository {
  final BaseService _drinkTypeService = GeneralService();

  Future<List<DrinkType>> fetchSeasonData() async {
    dynamic response = await _drinkTypeService.getResponse('drink_type');
    final List<dynamic> jsonData = response;
    List<DrinkType> drinkTypeList = jsonData.map((json) => DrinkType.fromMap(json)).toList();
    return drinkTypeList;
  }
}