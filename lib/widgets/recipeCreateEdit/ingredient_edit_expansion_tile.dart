import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/widgets/styled_textfield.dart';

class IngredientEditExpansionTile extends StatelessWidget {
  const IngredientEditExpansionTile({super.key});

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
      childrenPadding: const EdgeInsets.only(left: 10, bottom: 20, right: 10),
      expandedAlignment: Alignment.center,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Table(
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
              ]),
              TableRow(children: [
                Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Icon(CommunityMaterialIcons.minus),
                ),
                StyledTextfield(
                  controller: TextEditingController(text: 'Apple juice'),
                  width: 160,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: StyledTextfield(
                    controller: TextEditingController(text: '500'),
                    width: 60,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: StyledTextfield(
                    controller: TextEditingController(text: 'ml'),
                    width: 60,
                  ),
                ),
              ]),
              TableRow(children: [
                Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  alignment: Alignment.centerLeft,
                  child: const Icon(CommunityMaterialIcons.plus),
                ),
                const SizedBox(),
                const SizedBox(),
                const SizedBox(),
              ]),
            ],
          ),
        )
      ],
    );
  }
}
