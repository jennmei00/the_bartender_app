import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:the_bartender_app/data/api/api_response.dart';
import 'package:the_bartender_app/models/recipe.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/route_util.dart';
import 'package:the_bartender_app/viewmodels/recipe_detail_view_model.dart';
import 'package:the_bartender_app/widgets/recipeDetail/infromation_expansion_tile.dart';
import 'package:the_bartender_app/widgets/recipeDetail/ingredient_expansion_tile.dart';
import 'package:the_bartender_app/widgets/recipeDetail/instruction_expansion_tile.dart';
import 'package:the_bartender_app/widgets/styled_drawer.dart';
import 'package:the_bartender_app/widgets/styled_error.dart';

class RecipeDetailView extends StatelessWidget {
  final TextEditingController searchTextController = TextEditingController();

  RecipeDetailView({super.key});

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
                    'recipe_detail'.i18n().toUpperCase(),
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
                  (context, index) => Consumer<RecipeDetailViewModel>(
                      builder: (context, value, child) {
                    switch (value.response.status) {
                      case Status.initial || Status.loading:
                        return const Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        );
                      case Status.completed:
                        return RecipeDetailWidget(recipe: value.recipe!);
                      case Status.error:
                        return StyledError(
                            message: '${value.response.message}');
                    }
                  }),
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

class RecipeDetailWidget extends StatelessWidget {
  final RecipeDetail recipe;
  const RecipeDetailWidget({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          recipe.name,
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
                  recipe.drinkType.name,
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
        InformationExpansionTile(recipe: recipe),
        const Divider(),
        IngredientExpansionTile(recipe: recipe),
        const Divider(),
        InstructionExpansionTile(recipe: recipe),
        RatingStars(
          starBuilder: (index, color) {
            return recipe.rating < index
                ? const Icon(CommunityMaterialIcons.star_outline)
                : const Icon(CommunityMaterialIcons.star);
          },
          value: recipe.rating.toDouble(),
          starColor: Colors.white,
          starOffColor: Colors.transparent,
          valueLabelVisibility: false,
          starSize: 25,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
