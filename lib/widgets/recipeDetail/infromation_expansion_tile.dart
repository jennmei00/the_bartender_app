import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/models/recipe.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/string_util.dart';

class InformationExpansionTile extends StatelessWidget {
  final RecipeDetail recipe;
  const InformationExpansionTile({super.key, required this.recipe});

  final bool radioAlcoholicGroupValue = true;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const Border(),
      leading: Icon(
        CommunityMaterialIcons.information_outline,
        color: AppTheme.themeData.colorScheme.primary,
        size: 40,
      ),
      title: Text(
        'information'.i18n(),
        style: AppTheme.themeData.textTheme.titleSmall!.copyWith(
          color: AppTheme.themeData.colorScheme.primary,
        ),
      ),
      iconColor: AppTheme.themeData.colorScheme.primary,
      collapsedIconColor: AppTheme.themeData.colorScheme.primary,
      childrenPadding: const EdgeInsets.only(left: 30),
      expandedAlignment: Alignment.center,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Table(
          defaultColumnWidth: const IntrinsicColumnWidth(),
          children: [
            TableRow(
              children: [
                Text(
                  'prepare_time'.i18n(),
                  style: AppTheme.themeData.textTheme.bodySmall!.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Row(
                    children: [
                      Text(
                        recipe.prepTimeMinutes.toString(),
                        style: AppTheme.themeData.textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 30),
                      Text(
                        'minutes'.i18n().toUpperCase(),
                        style: AppTheme.themeData.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const TableRow(children: [
              SizedBox(height: 20),
              SizedBox(),
            ]),
            TableRow(
              children: [
                Text(
                  'season'.i18n(),
                  style: AppTheme.themeData.textTheme.bodySmall!.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(
                    capitalizeFirstLetter(recipe.season.name),
                    style: AppTheme.themeData.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const TableRow(children: [
              SizedBox(height: 20),
              SizedBox(),
            ]),
            TableRow(
              children: [
                Text(
                  'tools'.i18n(),
                  style: AppTheme.themeData.textTheme.bodySmall!.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: recipe.tools
                        .map(
                          (e) => Text(
                            e.name,
                            style: AppTheme.themeData.textTheme.bodyMedium,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
            const TableRow(children: [
              SizedBox(height: 20),
              SizedBox(),
            ]),
            TableRow(
              children: [
                Text(
                  'alcoholic'.i18n(),
                  style: AppTheme.themeData.textTheme.bodySmall!.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2, left: 25),
                      child: Row(
                        children: [
                          Transform.scale(
                            scale: 0.8,
                            child: Radio(
                              value:  recipe.alcoholic,
                              groupValue: radioAlcoholicGroupValue,
                              onChanged: (value) {},
                              activeColor: AppTheme.secondaryColor,
                            ),
                          ),
                          Text(
                            'yes'.i18n(),
                            style: AppTheme.themeData.textTheme.bodySmall,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 25),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Transform.scale(
                            scale: 0.8,
                            child: Radio(
                              value: !recipe.alcoholic,
                              groupValue: radioAlcoholicGroupValue,
                              onChanged: (value) {},
                              activeColor: AppTheme.secondaryColor,
                            ),
                          ),
                          Text(
                            'no'.i18n(),
                            style: AppTheme.themeData.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
