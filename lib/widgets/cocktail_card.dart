import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:the_bartender_app/models/recipe.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/routes/router.gr.dart';
import 'package:the_bartender_app/viewmodels/recipe_detail_view_model.dart';

class CocktailCard extends StatelessWidget {
  final Recipe recipe;
  const CocktailCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapped(context),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 30),
                Container(
                  decoration: AppTheme.recipeCardBoxDecoration,
                  height: 210,
                  width: 170,
                ),
              ],
            ),
            SizedBox(
              height: 250,
              width: 180,
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/svg/cocktail.svg',
                    height: 100,
                    alignment: Alignment.center,
                  ),
                  Text(
                    recipe.name,
                    style: AppTheme.themeData.textTheme.titleSmall!
                        .copyWith(fontSize: 25),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        recipe.season.name == 'summer'
                            ? const Icon(CommunityMaterialIcons.weather_sunny)
                            : const Icon(CommunityMaterialIcons.snowflake),
                        recipe.alcoholic
                            ? const Icon(CommunityMaterialIcons.glass_cocktail)
                            : const Icon(
                                CommunityMaterialIcons.glass_cocktail_off),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        CommunityMaterialIcons.account_edit,
                        size: 15,
                      ),
                      Text(
                        recipe.user.username,
                        style: AppTheme.themeData.textTheme.bodySmall!
                            .copyWith(fontSize: 15),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onTapped(BuildContext context) {
    RecipeDetail? rp =
        Provider.of<RecipeDetailViewModel>(context, listen: false).recipe;
    if (rp == null || rp.id != recipe.id) {
      Provider.of<RecipeDetailViewModel>(context, listen: false)
          .fetchRecipeData(recipe.id);
    }

    AutoRouter.of(context).push(RecipeDetailViewRoute());
  }
}
