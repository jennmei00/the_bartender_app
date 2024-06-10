import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/route_util.dart';
import 'package:the_bartender_app/widgets/styled_drawer.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final DrawerView drawerView;
  final AssetImage image;
  final bool appBar;
  final Widget? title;
  final bool drawer;
  final List<Widget>? actions;
  const CustomScaffold({
    super.key,
    required this.body,
    required this.drawerView,
    required this.image,
    this.appBar = false,
    this.title,
    this.drawer = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: image,
                fit: BoxFit.cover,
                colorFilter: const ColorFilter.mode(
                    Colors.black54, BlendMode.softLight))),
        child: BackdropFilter(
          filter: AppTheme.backgroundImageFilter,
          child: SafeArea(
            child: Scaffold(
              appBar: appBar
                  ? AppBar(
                      leading: Builder(builder: (context) {
                        return IconButton(
                          icon: drawer
                              ? const Icon(CommunityMaterialIcons.dots_vertical)
                              : const Icon(CommunityMaterialIcons.close),
                          onPressed: () => drawer
                              ? Scaffold.of(context).openDrawer()
                              : Navigator.of(context).pop(),
                        );
                      }),
                      title: title != null
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 0),
                              child: title,
                            )
                          : null,
                      actions: actions,
                    )
                  : null,
              drawer: StyledDrawer(
                drawerView: drawerView,
              ),
              body: body,
            ),
          ),
        ),
      ),
    );
  }
}
