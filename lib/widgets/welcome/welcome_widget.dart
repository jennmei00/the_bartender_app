import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/widgets/styled_button.dart';

class WelcomeWidget extends StatelessWidget {
  final Function registerPressed;
  final Function loginPressed;
  final Function withoutPressed;

  const WelcomeWidget({
    super.key, required this.registerPressed, required this.loginPressed, required this.withoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CommunityMaterialIcons.account_plus,
              color: AppTheme.themeData.colorScheme.primary,
              size: 50,
            ),
            const SizedBox(width: 20),
            SizedBox(
              child: StyledButton(
                title: 'register'.i18n(),
                onButtonPressed: () => registerPressed(),
                color: Colors.white,
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CommunityMaterialIcons.login,
              color: AppTheme.themeData.colorScheme.primary,
              size: 50,
            ),
            const SizedBox(width: 20),
            SizedBox(
              child: StyledButton(
                title: 'login'.i18n(),
                onButtonPressed: () => loginPressed(),
                color: Colors.white,
              ),
            )
          ],
        ),
        const SizedBox(height: 40),
        TextButton(
            onPressed: () => withoutPressed(),
            child: Text(
              'welcome_continue_text'.i18n(),
              style: AppTheme.themeData.textTheme.headlineMedium!
                  .copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            )),
      ],
    );
  }
}