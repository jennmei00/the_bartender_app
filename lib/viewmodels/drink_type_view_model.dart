import 'package:flutter/material.dart';
import 'package:the_bartender_app/data/api/api_response.dart';
import 'package:the_bartender_app/models/drink_type.dart';
import 'package:the_bartender_app/models/repositories/drink_type_repository.dart';

class DrinkTypeViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  List<DrinkType>? _drinkTypeList;

  ApiResponse get response {
    return _apiResponse;
  }

  List<DrinkType>? get drinkTypeList {
    return _drinkTypeList;
  }

  //* Call the drinkType service and gets the data of requested drinkType data
  Future<void> fetchData() async {
    _apiResponse = ApiResponse.loading('Fetching recipe data');
    notifyListeners();
    try {
      List<DrinkType> drinkTypes =
          await DrinkTypeRepository().fetchData();
      setSelectedDrinkType(drinkTypes);
      _apiResponse = ApiResponse.completed(drinkTypes);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  void setSelectedDrinkType(List<DrinkType> drinkTypes) {
    _drinkTypeList = drinkTypes;
  }
}
