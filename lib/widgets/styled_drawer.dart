import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';

import 'package:the_bartender_app/utils/enums.dart';
import 'package:the_bartender_app/utils/routes/router.gr.dart';

class StyledDrawer extends StatelessWidget {
  final DrawerView drawerView;

  const StyledDrawer({
    Key? key,
    required this.drawerView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: GestureDetector(
          onTap: () => onTapPressed(context, DrawerView.home),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/logo.svg',
                    height: 130,
                  ),
                  Text(
                    'the_bartender'.i18n(),
                    style: AppTheme.themeData.textTheme.headlineSmall,
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ListTile(
                    titleTextStyle: drawerView == DrawerView.recipe
                        ? AppTheme.themeData.textTheme.headlineMedium!
                            .copyWith(color: AppTheme.themeData.colorScheme.primary)
                        : AppTheme.themeData.textTheme.headlineMedium,
                    contentPadding: const EdgeInsets.only(bottom: 20, left: 50),
                    title: Text(
                      'recipes'.i18n().toUpperCase(),
                    ),
                    onTap: () => onTapPressed(context, DrawerView.recipe),
                  ),
                  ListTile(
                    titleTextStyle: drawerView == DrawerView.yourCreation
                        ? AppTheme.themeData.textTheme.headlineMedium!
                            .copyWith(color: AppTheme.themeData.colorScheme.primary)
                        : AppTheme.themeData.textTheme.headlineMedium,
                    contentPadding: const EdgeInsets.only(bottom: 20, left: 50),
                    title: Text(
                      'your_creation'.i18n().toUpperCase(),
                    ),
                    onTap: () => onTapPressed(context, DrawerView.yourCreation),
                  ),
                  ListTile(
                    titleTextStyle: drawerView == DrawerView.newsAndEvents
                        ? AppTheme.themeData.textTheme.headlineMedium!
                            .copyWith(color: AppTheme.themeData.colorScheme.primary)
                        : AppTheme.themeData.textTheme.headlineMedium,
                    contentPadding: const EdgeInsets.only(bottom: 20, left: 50),
                    title: Text(
                      'news_and_events'.i18n().toUpperCase(),
                    ),
                    onTap: () =>
                        onTapPressed(context, DrawerView.newsAndEvents),
                  ),
                  ListTile(
                    titleTextStyle: drawerView == DrawerView.contact
                        ? AppTheme.themeData.textTheme.headlineMedium!
                            .copyWith(color: AppTheme.themeData.colorScheme.primary)
                        : AppTheme.themeData.textTheme.headlineMedium,
                    contentPadding: const EdgeInsets.only(bottom: 20, left: 50),
                    title: Text(
                      'contact'.i18n().toUpperCase(),
                    ),
                    onTap: () => onTapPressed(context, DrawerView.contact),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  onTapPressed(BuildContext context, DrawerView view) {
    //*closes the Drawer when navigation to another view
    AutoRouter.of(context).pop();

    switch (view) {
      case DrawerView.home:
        AutoRouter.of(context).popAndPush(const HomeViewRoute());
        break;
      case DrawerView.recipe:
        AutoRouter.of(context).popAndPush(RecipeViewRoute());
        break;
      case DrawerView.yourCreation:
        AutoRouter.of(context).popAndPush(YourCreationViewRoute());
        break;
      case DrawerView.newsAndEvents:
        AutoRouter.of(context).popAndPush(const NewsAndEventsViewRoute());
        break;
      case DrawerView.contact:
        AutoRouter.of(context).popAndPush(const ContactViewRoute());
        break;
      default:
        AutoRouter.of(context).popAndPush(const HomeViewRoute());
        break;
    }
  }
}
