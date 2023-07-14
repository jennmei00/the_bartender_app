import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/route_util.dart';
import 'package:the_bartender_app/widgets/custom_scaffold.dart';
import 'package:the_bartender_app/widgets/styled_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      image: AppTheme.backgroundImage,
      appBar: true,
      drawerView: DrawerView.home,
      body: OrientationBuilder(builder: (context, orientation) {
        return orientation == Orientation.portrait
            ? Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/cocktails_sign.svg',
                    height: MediaQuery.of(context).size.height / 2.3,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'home_text'.i18n(),
                      style: AppTheme.themeData.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(bottom: 12),
                      child: StyledButton(
                        title: 'learn_more'.i18n(),
                        onButtonPressed: () {},
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/cocktails_sign.svg',
                    width: MediaQuery.of(context).size.width * 0.50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 12),
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Text(
                          'home_text'.i18n(),
                          style: AppTheme.themeData.textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      StyledButton(
                        title: 'learn_more'.i18n(),
                        onButtonPressed: () {},
                      ),
                    ],
                  ),
                ],
              );
      }),
    );
  }
}
