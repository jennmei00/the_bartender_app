import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';

import 'package:the_bartender_app/utils/route_util.dart';
import 'package:the_bartender_app/utils/string_util.dart';
import 'package:the_bartender_app/viewmodels/drink_type_view_model.dart';
import 'package:the_bartender_app/viewmodels/season_view_model.dart';

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
            onTap: () => onTapPressed(context, DrawerView.home),
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
                  onTap: () => onTapPressed(context, val),
                ),
        )
        .toList();
  }

  onTapPressed(BuildContext context, DrawerView val) {
    //*closes the Drawer when navigation to another view
    AutoRouter.of(context).pop();
    AutoRouter.of(context).popAndPush(drawerViewMap[val]!);
    if (val == DrawerView.recipes) {
      SeasonViewModel seasonVM =
          Provider.of<SeasonViewModel>(context, listen: false);
      DrinkTypeViewModel drinkTypeVM =
          Provider.of<DrinkTypeViewModel>(context, listen: false);

      if (seasonVM.seasonList == null) {
        seasonVM.fetchData();
      }
      if (drinkTypeVM.drinkTypeList == null) {
        drinkTypeVM.fetchData();
      }
    } else if (val == DrawerView.recipes) {
      DrinkTypeViewModel drinkTypeVM =
          Provider.of<DrinkTypeViewModel>(context, listen: false);
      if (drinkTypeVM.drinkTypeList == null) {
        drinkTypeVM.fetchData();
      }
    }
  }
}
