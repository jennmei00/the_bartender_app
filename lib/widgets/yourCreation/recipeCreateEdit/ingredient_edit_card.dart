import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:the_bartender_app/models/ingredient.dart';
import 'package:the_bartender_app/models/recipe.dart';
import 'package:the_bartender_app/models/unit.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/viewmodels/unit_view_model.dart';
import 'package:the_bartender_app/widgets/yourCreation/recipeCreateEdit/ingredient_dialog.dart';

class IngredientEditCard extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final RecipeDetail? recipeDetail;
  final Function({List<Ingredient>? ingredientList}) update;
  const IngredientEditCard(
      {super.key,
      required this.formKey,
      required this.update,
      this.recipeDetail});

  @override
  State<IngredientEditCard> createState() => _IngredientEditCardState();
}

class _IngredientEditCardState extends State<IngredientEditCard> {
  List<Ingredient> ingredients = [];
  List<Unit> unitList = [];
  Unit? selectedUnit;

  //* Key(String) as IngredeintId
  //* List<dynamic> with [TextEditingController(NAME), TextEditingCtontroller(AMOUNT), UNIT]
  Map<String, List<dynamic>> controllerMap = {};
  bool isValide = true;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    unitList =
        Provider.of<UnitViewModel>(context, listen: false).unitList ?? [];
    if (widget.recipeDetail != null) {
      ingredients = widget.recipeDetail!.ingredients;
    }
  }

  void addIngredient({Ingredient? ingredient}) {
    setState(() {
      ingredients.add(ingredient!);
    });
    widget.update(ingredientList: ingredients);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: AppTheme.drawerBackgroundcolor.withOpacity(0.8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(children: [
              //* Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CommunityMaterialIcons.fruit_citrus,
                    color: AppTheme.themeData.colorScheme.primary,
                    size: 35,
                  ),
                  Text(
                    '   ${'ingredients'.i18n()}',
                    style: AppTheme.themeData.textTheme.titleSmall!.copyWith(
                      color: AppTheme.themeData.colorScheme.primary,
                    ),
                  ),
                ],
              ), //* Body
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...ingredients.map(
                            (ingredient) => Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: AppTheme.styledTextFieldColor
                                    .withOpacity(0.6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      child: Text(
                                        ingredient.amount?.toStringAsFixed(
                                                ingredient.amount
                                                            ?.truncateToDouble() ==
                                                        ingredient.amount
                                                    ? 0
                                                    : 2) ??
                                            '',
                                        style: AppTheme
                                            .themeData.textTheme.bodyMedium,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 90,
                                      child: Text(
                                        ingredient.unit?.name ?? '',
                                        style: AppTheme
                                            .themeData.textTheme.bodyMedium,
                                      ),
                                    ),
                                    Text(
                                      ingredient.name,
                                      softWrap: true,
                                      style: AppTheme
                                          .themeData.textTheme.bodyMedium,
                                    ),
                                    Flexible(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: Icon(
                                            CommunityMaterialIcons.delete,
                                            color: AppTheme
                                                .themeData.colorScheme.error,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              ingredients.remove(ingredient);
                                            });
                                            widget.update(
                                                ingredientList: ingredients);
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FormField(
                                builder: (field) => Flexible(
                                    child: Text(
                                  field.errorText ?? '',
                                  style: AppTheme.themeData.textTheme.bodySmall!
                                      .copyWith(
                                          color: AppTheme
                                              .themeData.colorScheme.error),
                                  softWrap: true,
                                )),
                                validator: (_) {
                                  if (ingredients.isEmpty) {
                                    return 'ingredient_validator'.i18n();
                                  }
                                  return null;
                                },
                              ),
                              Container(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: const Icon(
                                      CommunityMaterialIcons.plus,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return IngredientDialog(
                                                unitList: unitList,
                                                addIngredient: addIngredient,
                                              );
                                            });
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
