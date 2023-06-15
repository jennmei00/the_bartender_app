import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/routes/router.gr.dart';

class CocktailCard extends StatelessWidget {
  const CocktailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AutoRouter.of(context).push(RecipeDetailViewRoute()),
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
                    'Snowy Apple',
                    style: AppTheme.themeData.textTheme.titleSmall!
                        .copyWith(fontSize: 25),
                  ),
                  const SizedBox(height: 20),
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
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(CommunityMaterialIcons.weather_sunny),
                        Icon(CommunityMaterialIcons.glass_cocktail_off),
                      ],
                    ),
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     const  Icon(
                        CommunityMaterialIcons.account_edit,
                        size: 15,
                      ),
                      Text(
                        'NIKmigg',
                        style: AppTheme.themeData.textTheme.bodySmall!.copyWith(fontSize: 15),
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
}
