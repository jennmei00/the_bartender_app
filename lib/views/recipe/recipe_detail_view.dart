import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:the_bartender_app/data/api/api_response.dart';
import 'package:the_bartender_app/models/recipe.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/route_util.dart';
import 'package:the_bartender_app/viewmodels/recipe_detail_view_model.dart';
import 'package:the_bartender_app/widgets/cocktail_image_widget.dart';
import 'package:the_bartender_app/widgets/custom_scaffold.dart';
import 'package:the_bartender_app/widgets/recipeDetail/infromation_expansion_tile.dart';
import 'package:the_bartender_app/widgets/recipeDetail/ingredient_expansion_tile.dart';
import 'package:the_bartender_app/widgets/recipeDetail/instruction_expansion_tile.dart';
import 'package:the_bartender_app/widgets/styled_error.dart';

class RecipeDetailView extends StatelessWidget {
  final TextEditingController searchTextController = TextEditingController();

  RecipeDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      image: AppTheme.woodBackgroundImage,
      drawerView: DrawerView.recipes,
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
                    return StyledError(message: '${value.response.message}');
                }
              }),
              childCount: 1,
            ),
          ),
        ],
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
        CocktailImageWidget(
          name: recipe.name,
          drinkType: recipe.drinkType,
        ),
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
