import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/enums.dart';
import 'package:the_bartender_app/utils/routes/router.gr.dart';
import 'package:the_bartender_app/widgets/styled_button.dart';
import 'package:the_bartender_app/widgets/styled_drawer.dart';
import 'package:the_bartender_app/widgets/styled_textfield.dart';

class RecipeView extends StatelessWidget {
  final TextEditingController searchTextController = TextEditingController();

  RecipeView({super.key});

  void onSearchPressed(BuildContext context) {
    AutoRouter.of(context).push(RecipeSearchResultViewRoute());
  }

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
          drawer: const StyledDrawer(
            drawerView: DrawerView.recipe,
          ),
          body: Column(
            children: [
              Expanded(
                child: CustomScrollView(
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
                          icon:
                              const Icon(CommunityMaterialIcons.dots_vertical),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        );
                      }),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            OrientationBuilder(builder: (context, orientation) {
                          return Column(
                            children: [
                              const SizedBox(height: 20),
                              SvgPicture.asset(
                                'assets/svg/neon_find.svg',
                                width: MediaQuery.of(context).size.width * 0.85,
                              ),
                              Container(
                                padding: const EdgeInsets.all(25),
                                child: Text(
                                  'search_text'.i18n(),
                                  style:
                                      AppTheme.themeData.textTheme.titleSmall,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  '${'search'.i18n()}...',
                                  style:
                                      AppTheme.themeData.textTheme.titleSmall,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20),
                                child: StyledTextfield(
                                  controller: searchTextController,
                                  suffixIcon: CommunityMaterialIcons.magnify,
                                  onSuffixIconPressed: () {},
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'or'.i18n(),
                                style: AppTheme.themeData.textTheme.titleSmall,
                                textAlign: TextAlign.center,
                              ),
                              IconButton(
                                onPressed: () {},
                                padding: const EdgeInsets.only(right: 20),
                                icon: const Icon(
                                  CommunityMaterialIcons.filter_outline,
                                  size: 50,
                                ),
                              ),
                            ],
                          );
                        }),
                        childCount: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 12),
                child: StyledButton(
                  title: 'search'.i18n(),
                  onButtonPressed: () => onSearchPressed(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
