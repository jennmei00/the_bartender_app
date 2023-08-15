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
import 'package:the_bartender_app/viewmodels/recipe_detail_view_model.dart';
import 'package:the_bartender_app/widgets/cocktail_image_widget.dart';
import 'package:the_bartender_app/widgets/custom_scaffold.dart';
import 'package:the_bartender_app/widgets/recipeDetail/infromation_card.dart';
import 'package:the_bartender_app/widgets/recipeDetail/ingredient_card.dart';
import 'package:the_bartender_app/widgets/recipeDetail/instruction_card.dart';
import 'package:the_bartender_app/widgets/styled_error.dart';
import 'package:uuid/uuid.dart';

class RecipeDetailView extends StatelessWidget {
  final TextEditingController searchTextController = TextEditingController();
  final String recipeName;
  final RecipeDetail recipeDetail = RecipeDetail(
      id: const Uuid().v4(),
      name: 'Niks Cocktail',
      creationDate: DateTime.now(),
      prepTimeMinutes: 3,
      alcoholic: true,
      instruction: 'Mix all Ingredients in a glass full of Crushed Ice.',
      descriiption: '',
      rating: 0,
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

  RecipeDetailView({super.key, required this.recipeName});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      image: AppTheme.woodBackgroundImage,
      drawerView: DrawerView.recipes,
      appBar: true,
      drawer: false,
      title: Text(recipeName),
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
