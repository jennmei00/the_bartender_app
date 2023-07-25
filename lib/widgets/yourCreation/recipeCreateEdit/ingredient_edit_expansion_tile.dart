import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:the_bartender_app/models/ingredient.dart';
import 'package:the_bartender_app/models/unit.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/viewmodels/unit_view_model.dart';
import 'package:the_bartender_app/widgets/styled_drop_down.dart';
import 'package:the_bartender_app/widgets/styled_textfield.dart';
import 'package:uuid/uuid.dart';

class IngredientEditExpansionTile extends StatefulWidget {
  const IngredientEditExpansionTile({super.key});

  @override
  State<IngredientEditExpansionTile> createState() =>
      _IngredientEditExpansionTileState();
}

class _IngredientEditExpansionTileState
    extends State<IngredientEditExpansionTile> {
  List<Ingredient> ingredients = [];

  List<Unit> unitList = [];
  Unit? selectedUnit;

  //* Key(String) as IngredeintId
  //* List<dynamic> with [TextEditingController(NAME), TextEditingCtontroller(AMOUNT), UNIT]
  Map<String, List<dynamic>> controllerMap = {};

  @override
  void initState() {
    super.initState();
    unitList =
        Provider.of<UnitViewModel>(context, listen: false).unitList ?? [];
    selectedUnit = unitList.first;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const Border(),
      leading: Icon(
        CommunityMaterialIcons.fruit_citrus,
        color: AppTheme.themeData.colorScheme.primary,
        size: 40,
      ),
      title: Text(
        'ingredients'.i18n(),
        style: AppTheme.themeData.textTheme.titleSmall!.copyWith(
          color: AppTheme.themeData.colorScheme.primary,
        ),
      ),
      iconColor: AppTheme.themeData.colorScheme.primary,
      collapsedIconColor: AppTheme.themeData.colorScheme.primary,
      childrenPadding: const EdgeInsets.only(left: 10, bottom: 20, right: 10),
      expandedAlignment: Alignment.center,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Table(
            defaultColumnWidth: const IntrinsicColumnWidth(),
            children: [
              TableRow(children: [
                const SizedBox(),
                Text(
                  'ingredient'.i18n(),
                  style: AppTheme.themeData.textTheme.bodySmall!
                      .copyWith(fontStyle: FontStyle.italic),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(
                    'amount'.i18n(),
                    style: AppTheme.themeData.textTheme.bodySmall!
                        .copyWith(fontStyle: FontStyle.italic),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(
                    'unit'.i18n(),
                    style: AppTheme.themeData.textTheme.bodySmall!
                        .copyWith(fontStyle: FontStyle.italic),
                  ),
                ),
              ]),
              ...ingredients.map(
                (i) => TableRow(children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(CommunityMaterialIcons.minus),
                      onPressed: () {
                        setState(() {
                          ingredients.remove(i);
                          controllerMap.remove(i.id);
                        });
                      },
                    ),
                  ),
                  //* Ingredientname Textfield
                  StyledTextfield(
                    controller: controllerMap[i.id]![0],
                    width: 160,
                    height: 40,
                  ),
                  //* Amount Textfield
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: StyledTextfield(
                      onlyInteger: true,
                      textInputType: TextInputType.number,
                      controller: controllerMap[i.id]![1],
                      width: 60,
                      height: 40,
                    ),
                  ),
                  //* Unit DropDown
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, bottom: 10),
                    child: StyledDropDown(
                      seasonDropDown: false,
                      onChanged: (value) {
                        setState(() {
                          controllerMap[i.id]![2] = value;
                        });
                      },
                      unit: controllerMap[i.id]![2],
                      unitList: unitList,
                    ),
                  ),
                ]),
              ),
              TableRow(children: [
                Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(CommunityMaterialIcons.plus),
                    onPressed: () {
                      setState(() {
                        String uuid = const Uuid().v4();
                        ingredients.add(Ingredient(
                            id: uuid,
                            name: '',
                            unit: unitList.first,
                            amount: 0));
                       controllerMap.addAll({uuid: [TextEditingController(), TextEditingController(), unitList.first]});
                      });
                    },
                  ),
                ),
                const SizedBox(),
                const SizedBox(),
                const SizedBox(),
              ]),
            ],
          ),
        )
      ],
    );
  }
}
