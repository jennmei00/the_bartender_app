import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_bartender_app/models/drink_type.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';

class CocktailImageWidget extends StatelessWidget {
  final String name;
  final DrinkType drinkType;
  const CocktailImageWidget(
      {super.key, required this.name, required this.drinkType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: AppTheme.themeData.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        Stack(
          children: [
            Container(
              alignment: Alignment.center,
              height: 150,
              width: 150,
              child: SvgPicture.asset(
                'assets/svg/cocktail.svg',
                height: 150,
              ),
            ),
            Container(
              height: 160,
              width: 150,
              alignment: Alignment.bottomRight,
              child: Transform.rotate(
                angle: -0.60,
                child: Text(
                  drinkType.name,
                  style: AppTheme.themeData.textTheme.titleSmall,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
