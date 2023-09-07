import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_bartender_app/data/api/api_response.dart';
import 'package:the_bartender_app/models/drink_type.dart';
import 'package:the_bartender_app/models/ingredient.dart';
import 'package:the_bartender_app/models/recipe.dart';
import 'package:the_bartender_app/models/season.dart';
import 'package:the_bartender_app/models/tool.dart';
import 'package:the_bartender_app/models/unit.dart';
import 'package:the_bartender_app/models/user.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/route_util.dart';
import 'package:the_bartender_app/utils/routes/router.gr.dart';
import 'package:the_bartender_app/viewmodels/recipe_detail_view_model.dart';
import 'package:the_bartender_app/viewmodels/season_view_model.dart';
import 'package:the_bartender_app/viewmodels/tool_view_model.dart';
import 'package:the_bartender_app/viewmodels/unit_view_model.dart';
import 'package:the_bartender_app/widgets/cocktail_image_widget.dart';
import 'package:the_bartender_app/widgets/custom_scaffold.dart';
import 'package:the_bartender_app/widgets/recipeDetail/infromation_card.dart';
import 'package:the_bartender_app/widgets/recipeDetail/ingredient_card.dart';
import 'package:the_bartender_app/widgets/recipeDetail/instruction_card.dart';
import 'package:the_bartender_app/widgets/styled_error.dart';
import 'package:uuid/uuid.dart';

class RecipeDetailView extends StatefulWidget {
  final String recipeName;
  final bool isEditable;

  const RecipeDetailView(
      {super.key, required this.recipeName, this.isEditable = false});

  @override
  State<RecipeDetailView> createState() => _RecipeDetailViewState();
}

class _RecipeDetailViewState extends State<RecipeDetailView> {
  final TextEditingController searchTextController = TextEditingController();
  bool isLoaded = false;

  final RecipeDetail recipeDetailDummy = RecipeDetail(
      id: const Uuid().v4(),
      name: 'Niks Cocktail',
      creationDate: DateTime.now(),
      prepTimeMinutes: 3,
      alcoholic: true,
      instruction: 'Mix all Ingredients in a glass full of Crushed Ice.',
      descriiption: '',
      user: User(id: const Uuid().v4(), username: 'jennmei00'),
      season: Season(id: const Uuid().v4(), name: 'Summer'),
      drinkType: DrinkType(id: const Uuid().v4(), name: 'Cocktail'),
      tools: [
        Tool(id: const Uuid().v4(), name: 'Shaker'),
        Tool(id: const Uuid().v4(), name: 'Teaspoon')
      ],
      ingredients: [
        Ingredient(
            id: const Uuid().v4(),
            name: 'Whiskey',
            unit: Unit(id: const Uuid().v4(), name: 'cl'),
            amount: 4),
        Ingredient(id: const Uuid().v4(), name: 'Ice Cubes'),
        Ingredient(id: const Uuid().v4(), name: 'Pepsi')
      ]);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      image: AppTheme.woodBackgroundImage,
      drawerView: DrawerView.recipes,
      appBar: true,
      drawer: false,
      title: Text(widget.recipeName),
      actions: widget.isEditable
          ? [
              IconButton(
                  onPressed: !isLoaded
                      ? null
                      : () {
                          RecipeDetail recipeDetail =
                              Provider.of<RecipeDetailViewModel>(context,
                                      listen: false)
                                  .recipe!;

                          List<Season>? seasonList =
                              Provider.of<SeasonViewModel>(context,
                                      listen: false)
                                  .seasonList;
                          if (seasonList == null || seasonList.isEmpty) {
                            Provider.of<SeasonViewModel>(context, listen: false)
                                .fetchData();
                          }

                          List<Tool>? toolList =
                              Provider.of<ToolViewModel>(context, listen: false)
                                  .toolList;
                          if (toolList == null || toolList.isEmpty) {
                            Provider.of<ToolViewModel>(context, listen: false)
                                .fetchData();
                          }

                          List<Unit>? unitList =
                              Provider.of<UnitViewModel>(context, listen: false)
                                  .unitList;
                          if (unitList == null || unitList.isEmpty) {
                            Provider.of<UnitViewModel>(context, listen: false)
                                .fetchData();
                          }
                          AutoRouter.of(context).push(
                              YourCreationDetailViewRoute(
                                  drinkType: recipeDetail.drinkType,
                                  name: recipeDetail.name,
                                  recipeDetail: recipeDetail));
                        },
                  icon: const Icon(CommunityMaterialIcons.pencil))
            ]
          : null,
      body: Consumer<RecipeDetailViewModel>(builder: (context, value, child) {
        switch (value.response.status) {
          case Status.initial || Status.loading:
            return const Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          case Status.completed:
            Future.delayed(Duration.zero, () {
              setState(() {
                isLoaded = true;
              });
            });
            return OrientationBuilder(builder: (context, orientation) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: RecipeDetailWidget(
                  recipe: value.recipe!,
                  orientation: orientation,
                ),
              );
            });
          case Status.error:
            return StyledError(message: '${value.response.message}');
        }
      }),
    );
  }
}

class RecipeDetailWidget extends StatelessWidget {
  final RecipeDetail recipe;
  final Orientation orientation;
  const RecipeDetailWidget({
    super.key,
    required this.recipe,
    required this.orientation,
  });

  @override
  Widget build(BuildContext context) {
    if (orientation == Orientation.portrait) {
      return Column(
        children: [
          CocktailImageWidget(
            name: recipe.name,
            drinkType: recipe.drinkType,
          ),
          InformationCard(recipe: recipe),
          const Divider(),
          IngredientExpansionTile(recipe: recipe),
          const Divider(),
          InstructionCard(recipe: recipe),
          const SizedBox(height: 10),
        ],
      );
    } else {
      return Column(
        children: [
          CocktailImageWidget(
            name: recipe.name,
            drinkType: recipe.drinkType,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: InformationCard(recipe: recipe),
                ),
              ),
              Expanded(
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: IngredientExpansionTile(recipe: recipe),
                ),
              ),
            ],
          ),
          const Divider(),
          InstructionCard(recipe: recipe),
          const SizedBox(height: 10),
        ],
      );
    }
  }
}
