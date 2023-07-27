import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/globals.dart';
import 'package:the_bartender_app/utils/route_util.dart';
import 'package:the_bartender_app/utils/routes/router.gr.dart';
import 'package:the_bartender_app/widgets/custom_scaffold.dart';
import 'package:the_bartender_app/widgets/styled_button.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  final bool loginActive = sharedPreferences!.getBool('loginActive') ?? false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      image: AppTheme.backgroundImage,
      appBar: true,
      title: Text(
        'settings'.i18n().toUpperCase(),
      ),
      drawerView: DrawerView.settings,
      body: OrientationBuilder(builder: (context, orientation) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListTile(
                  leading: Icon(
                    CommunityMaterialIcons.account,
                    size: 50,
                    color: loginActive
                        ? null
                        : AppTheme.themeData.colorScheme.primary,
                  ),
                  title: loginActive
                      ? Text(
                          'account'.i18n(),
                          style: AppTheme.themeData.textTheme.headlineSmall!
                              .copyWith(color: Colors.white, fontSize: 50),
                        )
                      : StyledButton(
                          title: 'login'.i18n(),
                          color: Colors.white,
                          onButtonPressed: () {
                            sharedPreferences!
                                .setBool('isFirstStart', true)
                                .then((value) =>
                                    AutoRouter.of(context).pushAndPopUntil(
                                      const WelcomeViewRoute(),
                                      predicate: (route) => false,
                                    ));
                          },
                        ),
                ),
              ),
              loginActive
                  ? Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(bottom: 12),
                      child: StyledButton(
                        title: 'logout'.i18n(),
                        color: Colors.red,
                        onButtonPressed: () {
                          sharedPreferences!.setBool('loginActive', false);
                          sharedPreferences!.setString('UserID', '');

                          AutoRouter.of(context).pushAndPopUntil(
                              const HomeViewRoute(),
                              predicate: (route) => false);
                        },
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      }),
    );
  }
}
