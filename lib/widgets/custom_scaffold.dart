import 'package:flutter/material.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/route_util.dart';
import 'package:the_bartender_app/widgets/styled_drawer.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final DrawerView drawerView;
  const CustomScaffold(
      {super.key, required this.body, required this.drawerView});

  //TODOChange all Scaffolds with background to customScaffold

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AppTheme.backgroundImage,
        fit: BoxFit.cover,
      )),
      child: BackdropFilter(
        filter: AppTheme.backgroundImageFilter,
        child: Scaffold(
          drawer: StyledDrawer(
            drawerView: drawerView,
          ),
          body: body,
        ),
      ),
    );
  }
}
