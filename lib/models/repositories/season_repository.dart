import 'package:the_bartender_app/data/services/base_service.dart';
import 'package:the_bartender_app/data/services/general_service.dart';
import 'package:the_bartender_app/models/season.dart';

class SeasonRepository {
  final BaseService _seasonService = GeneralService();

  Future<List<Season>> fetchSeasonData() async {
    dynamic response = await _seasonService.getResponse('season');
    final List<dynamic> jsonData = response;
    List<Season> seasonList = jsonData.map((json) => Season.fromMap(json)).toList();
    return seasonList;
  }
}