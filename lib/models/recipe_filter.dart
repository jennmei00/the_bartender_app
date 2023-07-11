import 'package:the_bartender_app/models/drink_type.dart';
import 'package:the_bartender_app/models/season.dart';

class RecipeFilter {
  final List<Season> seasonnList;
  final List<DrinkType> drinkTypeList;
  final bool alcoholicYes;
  final bool alcoholicNo;

  RecipeFilter({
    required this.seasonnList,
    required this.drinkTypeList,
    required this.alcoholicYes,
    required this.alcoholicNo,
  });
}
