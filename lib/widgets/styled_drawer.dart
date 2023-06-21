import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';

import 'package:the_bartender_app/utils/route_util.dart';
import 'package:the_bartender_app/utils/routes/router.gr.dart';
import 'package:the_bartender_app/utils/string_util.dart';

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
        child: Column(children: [
          GestureDetector(
            onTap: () => onTapPressed(context, const HomeViewRoute()),
            child: Padding(
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
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: drawerListViewTiles(context),
            ),
          )
        ]),
      ),
    );
  }

  List<Widget> drawerListViewTiles(BuildContext context) {
    return drawerViewMap.keys
        .map(
          (val) => val == DrawerView.home
              ? Container()
              : ListTile(
                  titleTextStyle: drawerView == val
                      ? AppTheme.themeData.textTheme.headlineMedium!.copyWith(
                          color: AppTheme.themeData.colorScheme.primary)
                      : AppTheme.themeData.textTheme.headlineMedium,
                  contentPadding: const EdgeInsets.only(bottom: 20, left: 50),
                  title: Text(
                    convertToSnakeCase(val.name).i18n().toUpperCase(),
                  ),
                  onTap: () => onTapPressed(context, drawerViewMap[val]!),
                ),
        )
        .toList();
  }

  onTapPressed(BuildContext context, PageRouteInfo<dynamic> route) {
    //*closes the Drawer when navigation to another view
    AutoRouter.of(context).pop();
    AutoRouter.of(context).popAndPush(route);
  }
}
