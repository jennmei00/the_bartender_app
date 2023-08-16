import 'package:flutter/foundation.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/data/api/api_response.dart';
import 'package:the_bartender_app/models/repositories/unit_repository.dart';
import 'package:the_bartender_app/models/unit.dart';

class UnitViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  List<Unit>? _unitList;

  ApiResponse get response {
    return _apiResponse;
  }

  List<Unit>? get unitList {
    return _unitList;
  }

  //* Call the unit service and gets the data of requested unit data
  Future<void> fetchData() async {
    _apiResponse = ApiResponse.loading('Fetching recipe data');
    notifyListeners();
    try {
      List<Unit> units =
          await UnitRepository().fetchData();
      setSelectedUnit(units);
      _apiResponse = ApiResponse.completed(units);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      _apiResponse = ApiResponse.error('something_went_wrong'.i18n());
    }
    notifyListeners();
  }

  void setSelectedUnit(List<Unit> units) {
    _unitList = units;
  }
}
