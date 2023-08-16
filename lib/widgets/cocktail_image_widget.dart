import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/models/drink_type.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/id_util.dart';

class CocktailImageWidget extends StatelessWidget {
  final String name;
  final DrinkType drinkType;
  final bool isCreation;
  const CocktailImageWidget({
    super.key,
    required this.name,
    required this.drinkType,
    this.isCreation = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: Text(
              isCreation
                  ? 'your_creation_detail_text'.i18n()
                  : 'recipe_detail_text'.i18n(),
              style: AppTheme.themeData.textTheme.displayMedium,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
          Image.asset(
            drinkTypeToImagePath(drinkType.id),
            height: 100,
          ),
        ],
      ),
    );
  }
}
