import 'package:flutter/material.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/route_util.dart';
import 'package:the_bartender_app/widgets/custom_scaffold.dart';

class NewsAndEventsView extends StatelessWidget {
  const NewsAndEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      image: AppTheme.backgroundImage,
      appBar: true,
      drawerView: DrawerView.newsAndEvents,
      body: OrientationBuilder(builder: (context, orientation) {
        return const Placeholder();
      }),
    );
  }
}
