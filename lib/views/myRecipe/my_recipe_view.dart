import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:the_bartender_app/data/api/api_response.dart';
import 'package:the_bartender_app/models/recipe.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/route_util.dart';
import 'package:the_bartender_app/viewmodels/recipe_view_model.dart';
import 'package:the_bartender_app/widgets/cocktail_card.dart';
import 'package:the_bartender_app/widgets/custom_scaffold.dart';
import 'package:the_bartender_app/widgets/styled_error.dart';

class MyRecipeView extends StatefulWidget {
  const MyRecipeView({super.key});

  @override
  State<MyRecipeView> createState() => _MyRecipeViewState();
}

class _MyRecipeViewState extends State<MyRecipeView> {
  bool searchActive = false;
  TextEditingController searchTextController = TextEditingController();
  List<Recipe> recipeListShow = [];
  List<Recipe> recipeList = [];

  @override
  Widget build(BuildContext context) {
    if (searchTextController.text != '') {
      recipeListShow = recipeList
          .where(
            (element) => element.name
                .toUpperCase()
                .contains(searchTextController.text.toUpperCase()),
          )
          .toList();
    } else {
      recipeListShow = recipeList;
    }

    return CustomScaffold(
      image: AppTheme.backgroundImage,
      appBar: true,
      title: !searchActive
          ? Text('my_recipes'.i18n().toUpperCase())
          : TextField(
              controller: searchTextController,
              onChanged: (query) {
                setState(() {});
              },
              autofocus: true,
              style: AppTheme.themeData.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: 'search'.i18n(),
                hintStyle: AppTheme.themeData.textTheme.bodyMedium!
                    .copyWith(color: Colors.white30),
                border: const UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
      actions: [
        searchActive
            ? IconButton(
                onPressed: () {
                  setState(() {
                    searchTextController.text = '';
                    searchActive = false;
                  });
                },
                icon: const Icon(CommunityMaterialIcons.close))
            : IconButton(
                onPressed: () {
                  setState(() {
                    searchActive = true;
                  });
                },
                icon: const Icon(CommunityMaterialIcons.magnify)),
      ],
      drawerView: DrawerView.myRecipes,
      body: Consumer<RecipeViewModel>(
          builder: (context, value, child) =>
              getRecipeWidgetList(context, value)),
    );
  }

  Widget getRecipeWidgetList(BuildContext context, RecipeViewModel value) {
    ApiResponse apiResponse = value.response;

    switch (apiResponse.status) {
      case Status.loading:
        return const Center(child: CircularProgressIndicator.adaptive());
      case Status.completed:
        recipeList = apiResponse.data as List<Recipe>;
        if (!searchActive) {
          recipeListShow = recipeList;
        }
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: GridView.count(
            crossAxisCount: (MediaQuery.of(context).size.width / 200).round(),
            mainAxisSpacing: 20,
            crossAxisSpacing: 10,
            childAspectRatio: (180 / 250),
            children: recipeListShow
                .map((val) => CocktailCard(
                      recipe: val,
                      isEditable: true,
                    ))
                .toList(),
          ),
        );
      case Status.initial:
      case Status.error:
        return StyledError(message: '${apiResponse.message}');
    }
  }
}
