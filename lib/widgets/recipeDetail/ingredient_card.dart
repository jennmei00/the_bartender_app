import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/models/recipe.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';

class IngredientExpansionTile extends StatelessWidget {
  final RecipeDetail recipe;

  const IngredientExpansionTile({super.key, required this.recipe});

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
                  CommunityMaterialIcons.fruit_citrus,
                  color: AppTheme.themeData.colorScheme.primary,
                  size: 35,
                ),
                Text(
                  '   ${'ingredients'.i18n()}',
                  style: AppTheme.themeData.textTheme.titleSmall!.copyWith(
                    color: AppTheme.themeData.colorScheme.primary,
                  ),
                ),
              ],
            ), //* Body
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: recipe.ingredients
                          .map(
                            (ingredient) => Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: AppTheme.styledTextFieldColor
                                    .withOpacity(0.6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      child: Text(
                                        ingredient.amount?.toStringAsFixed(
                                                ingredient.amount
                                                            ?.truncateToDouble() ==
                                                        ingredient.amount
                                                    ? 0
                                                    : 1) ??
                                            '',
                                        style: AppTheme
                                            .themeData.textTheme.bodyMedium,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 80,
                                      child: Text(
                                        ingredient.unit?.name ?? '',
                                        style: AppTheme
                                            .themeData.textTheme.bodyMedium,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        ingredient.name,
                                        softWrap: true,
                                        style: AppTheme
                                            .themeData.textTheme.bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
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
