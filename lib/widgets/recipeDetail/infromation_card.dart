import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/models/recipe.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/widgets/recipeDetail/information_item.dart';

class InformationCard extends StatelessWidget {
  final RecipeDetail recipe;
  const InformationCard({super.key, required this.recipe});

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
                  CommunityMaterialIcons.information_outline,
                  color: AppTheme.themeData.colorScheme.primary,
                  size: 35,
                ),
                Text(
                  '   ${'information'.i18n()}',
                  style: AppTheme.themeData.textTheme.titleSmall!.copyWith(
                    color: AppTheme.themeData.colorScheme.primary,
                  ),
                ),
              ],
            ), //* Body
            Column(
              children: [
                InformationItem(
                  icon: CommunityMaterialIcons.timer,
                  info: '${recipe.prepTimeMinutes} min.',
                ),
                InformationItem(
                  icon: recipe.season.name == 'Summer'
                      ? CommunityMaterialIcons.weather_sunny
                      : recipe.season.name == 'Winter'
                          ? CommunityMaterialIcons.snowflake
                          : CommunityMaterialIcons.weather_partly_snowy,
                  info: recipe.season.name,
                ),
                InformationItem(
                  icon: CommunityMaterialIcons.glass_cocktail,
                  info: recipe.alcoholic ? 'Alcoholic' : 'Non Alcoholic',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Stack(
                    children: [
                      const SizedBox(
                          width: 80, child: Icon(CommunityMaterialIcons.tools)),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 70),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: recipe.tools
                              .map(
                                (tool) => Container(
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
                                    child: Text(
                                      tool.name,
                                      style: AppTheme
                                          .themeData.textTheme.bodyMedium,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      )
                    ],
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
