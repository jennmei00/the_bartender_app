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
    return ExpansionTile(
      shape: const Border(),
      leading: Icon(
        CommunityMaterialIcons.fruit_citrus,
        color: AppTheme.themeData.colorScheme.primary,
        size: 40,
      ),
      title: Text(
        'ingredients'.i18n(),
        style: AppTheme.themeData.textTheme.titleSmall!.copyWith(
          color: AppTheme.themeData.colorScheme.primary,
        ),
      ),
      iconColor: AppTheme.themeData.colorScheme.primary,
      collapsedIconColor: AppTheme.themeData.colorScheme.primary,
      childrenPadding: const EdgeInsets.only(left: 30, bottom: 20),
      expandedAlignment: Alignment.center,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Table(
          defaultColumnWidth: const IntrinsicColumnWidth(),
          children: [
            TableRow(children: [
              const SizedBox(),
              Text(
                'ingredient'.i18n(),
                style: AppTheme.themeData.textTheme.bodySmall!
                    .copyWith(fontStyle: FontStyle.italic),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text(
                  'amount'.i18n(),
                  style: AppTheme.themeData.textTheme.bodySmall!
                      .copyWith(fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text(
                  'unit'.i18n(),
                  style: AppTheme.themeData.textTheme.bodySmall!
                      .copyWith(fontStyle: FontStyle.italic),
                ),
              ),
            ]), ...recipe.ingredients.map((e) => TableRow(children: [
              const Icon(CommunityMaterialIcons.circle_small),
              Text(
                e.name,
                style: AppTheme.themeData.textTheme.bodyMedium,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text(
                  '${e.amount}',
                  style: AppTheme.themeData.textTheme.bodyMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text(
                  e.unit.name.i18n(), //TODOi18n add units
                  style: AppTheme.themeData.textTheme.bodyMedium,
                ),
              ),
            ]),).toList(),
          ],
        )
      ],
    );
  }
}
