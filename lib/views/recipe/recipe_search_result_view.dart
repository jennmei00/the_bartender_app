import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/enums.dart';
import 'package:the_bartender_app/widgets/cocktail_card.dart';
import 'package:the_bartender_app/widgets/styled_drawer.dart';

class RecipeSearchResultView extends StatelessWidget {
  final TextEditingController searchTextController = TextEditingController();

  RecipeSearchResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AppTheme.backgroundImage,
        fit: BoxFit.cover,
      )),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
        child: Scaffold(
          drawer: const StyledDrawer(
            drawerView: DrawerView.recipe,
          ),
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            key: GlobalKey(),
            slivers: [
              SliverAppBar(
                title: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 0),
                  child: Text(
                    'recipes'.i18n().toUpperCase(),
                  ),
                ),
                leading: Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(CommunityMaterialIcons.close),
                    onPressed: () => AutoRouter.of(context).pop(),
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SvgPicture.asset(
                      'assets/svg/neon_find.svg',
                      width: MediaQuery.of(context).size.width * 0.85,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Text(
                        'results_for'.i18n(),
                        style: AppTheme.themeData.textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Text(
                        '"Apple juice" + "Longdrink"',
                        style: AppTheme.themeData.textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SliverGrid.count(
                crossAxisCount:
                    (MediaQuery.of(context).size.width / 200).round(),
                mainAxisSpacing: 20,
                crossAxisSpacing: 10,
                childAspectRatio: (180 / 250),
                children: List.generate(5, (index) => const CocktailCard()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
