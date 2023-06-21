import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/models/recipe.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';

class InstructionExpansionTile extends StatelessWidget {
  final RecipeDetail recipe;

  const InstructionExpansionTile({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const Border(),
      leading: Icon(
        CommunityMaterialIcons.glass_cocktail,
        color: AppTheme.themeData.colorScheme.primary,
        size: 40,
      ),
      title: Text(
        'instructions'.i18n(),
        style: AppTheme.themeData.textTheme.titleSmall!.copyWith(
          color: AppTheme.themeData.colorScheme.primary,
        ),
      ),
      iconColor: AppTheme.themeData.colorScheme.primary,
      collapsedIconColor: AppTheme.themeData.colorScheme.primary,
      childrenPadding: const EdgeInsets.only(left: 30, bottom: 20),
      expandedAlignment: Alignment.centerLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'instruction'.i18n(),
              style: AppTheme.themeData.textTheme.bodySmall!.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                recipe.instruction,
                softWrap: true,
                textAlign: TextAlign.justify,
                style: AppTheme.themeData.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
