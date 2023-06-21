import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/route_util.dart';
import 'package:the_bartender_app/widgets/styled_drawer.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

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
          appBar: AppBar(
            leading: Builder(builder: (context) {
              return IconButton(
                icon: const Icon(CommunityMaterialIcons.dots_vertical),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            }),
          ),
          drawer: const StyledDrawer(
            drawerView: DrawerView.contact,
          ),
          body: OrientationBuilder(builder: (context, orientation) {
            return const Placeholder();
          }),
        ),
      ),
    );
  }
}
