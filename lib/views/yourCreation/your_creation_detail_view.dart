import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/enums.dart';
import 'package:the_bartender_app/widgets/recipeCreateEdit/information_edit_expansion_tile.dart';
import 'package:the_bartender_app/widgets/recipeCreateEdit/ingredient_edit_expansion_tile.dart';
import 'package:the_bartender_app/widgets/recipeCreateEdit/instruction_edit_expansion_tile.dart';
import 'package:the_bartender_app/widgets/styled_drawer.dart';

class YourCreationDetailView extends StatelessWidget {
  final TextEditingController searchTextController = TextEditingController();

  YourCreationDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AppTheme.woodBackgroundImage,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
        fit: BoxFit.cover,
      )),
      child: BackdropFilter(
        filter: AppTheme.backgroundImageFilter,
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
                    'your_creation'.i18n().toUpperCase(),
                  ),
                ),
                leading: Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(CommunityMaterialIcons.close),
                    onPressed: () => AutoRouter.of(context).pop(),
                  );
                }),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Column(
                    children: [
                      Text(
                        'Fruit Punch',
                        style: AppTheme.themeData.textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      Stack(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 200,
                            width: 150,
                            child: SvgPicture.asset(
                              'assets/svg/cocktail.svg',
                              height: 200,
                            ),
                          ),
                          Container(
                            height: 210,
                            width: 150,
                            alignment: Alignment.bottomRight,
                            child: Transform.rotate(
                              angle: -0.60,
                              child: Text(
                                'Longdrink',
                                style: AppTheme.themeData.textTheme.titleMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'recipe_detail_text'.i18n(),
                        style: AppTheme.themeData.textTheme.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      InformationEditExpansionTile(),
                      const Divider(),
                      const IngredientEditExpansionTile(),
                      const Divider(),
                      const InstructionEditExpansionTile(),
                      RatingStars(
                        starBuilder: (index, color) {
                          return color == Colors.transparent
                              ? const Icon(CommunityMaterialIcons.star_outline)
                              : const Icon(CommunityMaterialIcons.star);
                        },
                        value: 3,
                        starColor: Colors.white,
                        starOffColor: Colors.transparent,
                        valueLabelVisibility: false,
                        starSize: 25,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                  childCount: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
