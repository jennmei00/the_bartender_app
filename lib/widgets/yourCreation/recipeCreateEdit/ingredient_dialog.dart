import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/models/ingredient.dart';
import 'package:the_bartender_app/models/unit.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/widgets/styled_drop_down.dart';
import 'package:the_bartender_app/widgets/yourCreation/recipeCreateEdit/ingredient_textfield.dart';
import 'package:uuid/uuid.dart';

class IngredientDialog extends StatefulWidget {
  final List<Unit> unitList;
  final Function({Ingredient? ingredient}) addIngredient;
  const IngredientDialog(
      {super.key, required this.unitList, required this.addIngredient});

  @override
  State<IngredientDialog> createState() => _IngredientDialogState();
}

class _IngredientDialogState extends State<IngredientDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  Unit? selectedUnit;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.drawerBackgroundcolor,
      title: Text(
        'add_ingredient'.i18n(),
        style: AppTheme.themeData.textTheme.headlineMedium!
            .copyWith(color: AppTheme.themeData.colorScheme.primary),
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              IngredientTextField(
                controller: nameController,
                title: 'name'.i18n(),
                validator: (value) {
                  if (value == '') {
                    return 'name_validator'.i18n();
                  }
                  return null;
                },
              ),
              IngredientTextField(
                controller: amountController,
                title: 'amount'.i18n(),
                isNumeric: true,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('unit'.i18n(),
                      style: AppTheme.themeData.textTheme.bodySmall),
                  StatefulBuilder(builder: (context, setState) {
                    return StyledDropDown(
                      onChanged: (value) {
                        setState(() {
                          selectedUnit = widget.unitList.firstWhere((element) => element.id == value);
                        });
                      },
                      seasonDropDown: false,
                      unitList: widget.unitList,
                      unit: selectedUnit,
                    );
                  })
                ],
              )
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'cancel'.i18n().toUpperCase(),
              style: AppTheme.themeData.textTheme.headlineMedium!
                  .copyWith(color: AppTheme.themeData.colorScheme.primary),
            )),
        TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                widget.addIngredient(
                    ingredient: Ingredient(
                        id: const Uuid().v4(),
                        name: nameController.text,
                        amount: double.tryParse(amountController.text),
                        unit: selectedUnit));
              }
            },
            child: Text(
              'add'.i18n().toUpperCase(),
              style: AppTheme.themeData.textTheme.headlineMedium!
                  .copyWith(color: AppTheme.themeData.colorScheme.primary),
            ))
      ],
    );
  }
}
