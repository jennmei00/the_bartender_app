import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/models/recipe.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';

class InstructionCard extends StatelessWidget {
  final RecipeDetail recipe;

  const InstructionCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: AppTheme.drawerBackgroundcolor.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(children: [
            //* Header
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CommunityMaterialIcons.glass_cocktail,
                  color: AppTheme.themeData.colorScheme.primary,
                  size: 35,
                ),
                Text(
                  '   ${'instructions'.i18n()}',
                  style: AppTheme.themeData.textTheme.titleSmall!.copyWith(
                    color: AppTheme.themeData.colorScheme.primary,
                  ),
                ),
              ],
            ), //* Body
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 5.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: AppTheme.styledTextFieldColor.withOpacity(0.6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        recipe.instruction,
                        style: AppTheme.themeData.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
