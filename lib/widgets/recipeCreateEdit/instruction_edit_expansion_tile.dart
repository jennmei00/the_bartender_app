import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/widgets/styled_textfield.dart';

class InstructionEditExpansionTile extends StatelessWidget {
  const InstructionEditExpansionTile({super.key});

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
              padding: const EdgeInsets.only(left: 0.0, right: 30.0),
              child: StyledTextfield(
                controller: TextEditingController(text: 'Fill the Apple juice in the glass :D And the rest of the ingredients xD'),
                textInputType: TextInputType.multiline
              ),
            ),
          ],
        ),
      ],
    );
  }
}
