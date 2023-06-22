import 'package:flutter/material.dart';
import 'package:the_bartender_app/data/api/api_response.dart';
import 'package:the_bartender_app/models/repositories/season_repository.dart';
import 'package:the_bartender_app/models/season.dart';

class CreationViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  List<Season>? _seasonList;

  ApiResponse get response {
    return _apiResponse;
  }

  List<Season>? get seasonList {
    return _seasonList;
  }

  //* Call the recipe service and gets the data of requested recipe data
  Future<void> fetchSeasonData() async {
    _apiResponse = ApiResponse.loading('Fetching recipe data');
    notifyListeners();
    try {
      List<Season> seasons =
          await SeasonRepository().fetchSeasonData();
      setSelctedSeason(seasons);
      _apiResponse = ApiResponse.completed(seasons);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  void setSelctedSeason(List<Season> seasons) {
    _seasonList = seasons;
  }
}
