import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/models/drink_type.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';

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
                  ? 'recipe_detail_text'.i18n()
                  : 'General Useful Informations For Your Drink',
              style: AppTheme.themeData.textTheme.displayMedium,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
          Image.asset(
            drinkType.name == 'Cocktail'
                ? 'assets/images/cocktail.png'
                : drinkType.name == 'Shot'
                    ? 'assets/images/shot.png'
                    : 'assets/images/other.png',
            height: 100,
          ),
        ],
      ),
    );
  }
}
