import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:the_bartender_app/data/api/api_response.dart';
import 'package:the_bartender_app/models/drink_type.dart';
import 'package:the_bartender_app/models/ingredient.dart';
import 'package:the_bartender_app/models/recipe_create.dart';
import 'package:the_bartender_app/models/season.dart';
import 'package:the_bartender_app/models/tool.dart';
import 'package:the_bartender_app/models/user.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/globals.dart';
import 'package:the_bartender_app/utils/route_util.dart';
import 'package:the_bartender_app/viewmodels/recipe_create_view_model.dart';
import 'package:the_bartender_app/viewmodels/season_view_model.dart';
import 'package:the_bartender_app/viewmodels/tool_view_model.dart';
import 'package:the_bartender_app/viewmodels/unit_view_model.dart';
import 'package:the_bartender_app/widgets/cocktail_image_widget.dart';
import 'package:the_bartender_app/widgets/custom_scaffold.dart';
import 'package:the_bartender_app/widgets/yourCreation/recipeCreateEdit/information_edit_card.dart';
import 'package:the_bartender_app/widgets/yourCreation/recipeCreateEdit/ingredient_edit_card.dart';
import 'package:the_bartender_app/widgets/yourCreation/recipeCreateEdit/instruction_edit_card.dart';
import 'package:the_bartender_app/widgets/styled_button.dart';
import 'package:the_bartender_app/widgets/styled_error.dart';
import 'package:uuid/uuid.dart';

class YourCreationDetailView extends StatefulWidget {
  final DrinkType drinkType;
  final String name;

  const YourCreationDetailView(
      {super.key, required this.drinkType, required this.name});

  @override
  State<YourCreationDetailView> createState() => _YourCreationDetailViewState();
}

class _YourCreationDetailViewState extends State<YourCreationDetailView> {
  int prepTime = 1;
  Season? selectedSeason;
  List<Tool>? selectedTools;
  bool alcoholic = true;
  List<Ingredient>? ingredients;
  String? instructions;
  final GlobalKey<FormState> informationFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> ingredientsFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> instructionsFormKey = GlobalKey<FormState>();
  bool isIngredientsValide = false;
  bool isInstructionValide = false;

  void informationCallback(
      {int? prepTime, Season? season, List<Tool>? toolList, bool? alcoholic}) {
    if (prepTime != null) {
      this.prepTime = prepTime;
    } else if (season != null) {
      selectedSeason = season;
    } else if (toolList != null) {
      selectedTools = toolList;
    } else if (alcoholic != null) {
      this.alcoholic = alcoholic;
    }
  }

  void ingredientsCallback({List<Ingredient>? ingredientList}) {
    ingredients = ingredientList;
    if (!isIngredientsValide) {
      ingredientsFormKey.currentState!.validate();
    }
  }

  void instructionsCallback({String? instruction}) {
    instructions = instruction;
  }

  onSavePressed(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());

    if (ingredientsFormKey.currentState!.validate()) {
      isIngredientsValide = true;
    }
    if (instructionsFormKey.currentState!.validate()) {
      isInstructionValide = true;
    }
    if (isIngredientsValide && isInstructionValide) {
      User user =
          User(id: sharedPreferences!.getString('UserID') ?? '', username: '');
      RecipeCreate recipe = RecipeCreate(
        recipeId: const Uuid().v4(),
        name: widget.name,
        creationDate: DateTime.now(),
        editDate: null,
        prepTimeMinutes: prepTime,
        alcoholic: alcoholic,
        instruction: instructions!,
        description: '',
        rating: 0,
        seasonId: selectedSeason!.id,
        drinkTypeId: widget.drinkType.id,
        userId: user.id,
      );

      showDialog(
          context: context,
          barrierDismissible: false, //* Prevent closing on tap outside
          builder: (BuildContext context) {
            return const AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(), //* Loading indicator
                ],
              ),
            );
          });

      Provider.of<RecipeCreateViewModel>(context, listen: false)
          .postData(
        recipe: recipe,
        ingredientList: ingredients!,
        toolList: selectedTools ?? [],
      )
          .then((value) {
        Navigator.of(context, rootNavigator: true).pop(); //*Close the dialog
        if (value.status == Status.completed) {
          Navigator.of(context).pop(); //*Go to previous page
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Recipe sucessfully posted')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Something went wrong!')));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      image: AppTheme.woodBackgroundImage,
      drawerView: DrawerView.yourCreation,
      appBar: true,
      drawer: false,
      title: Text(widget.name),
      body: OrientationBuilder(builder: (context, orientation) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    CocktailImageWidget(
                      name: widget.name,
                      drinkType: widget.drinkType,
                      isCreation: true,
                    ),
                    const SizedBox(height: 20),
                    Consumer3<SeasonViewModel, ToolViewModel, UnitViewModel>(
                        builder: (context, seasonVM, toolVM, unitVM, child) =>
                            getCreationEditWidgets(seasonVM, toolVM, unitVM)),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 12),
              child: StyledButton(
                title: 'save'.i18n(),
                onButtonPressed: Provider.of<SeasonViewModel>(context)
                                .response
                                .status !=
                            Status.completed ||
                        Provider.of<ToolViewModel>(context).response.status !=
                            Status.completed
                    ? null
                    : () => onSavePressed(context),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget getCreationEditWidgets(
      SeasonViewModel seasonVM, ToolViewModel toolVM, UnitViewModel unitVM) {
    if (seasonVM.response.status == Status.error ||
        toolVM.response.status == Status.error ||
        unitVM.response.status == Status.error) {
      return StyledError(
          message:
              '${seasonVM.response.status == Status.error ? seasonVM.response.message : toolVM.response.status == Status.error ? toolVM.response.message : unitVM.response.message}');
    } else if (seasonVM.response.status == Status.completed &&
        toolVM.response.status == Status.completed &&
        unitVM.response.status == Status.completed) {
      return Column(
        children: [
          InformationEditCard(
            update: informationCallback,
            formKey: informationFormKey,
          ),
          const Divider(),
          IngredientEditCard(
            update: ingredientsCallback,
            formKey: ingredientsFormKey,
          ),
          const Divider(),
          InstructionEditCard(
            update: instructionsCallback,
            formKey: instructionsFormKey,
          ),
        ],
      );
    } else {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
  }
}
