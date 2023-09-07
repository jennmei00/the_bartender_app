import 'package:community_material_icon/community_material_icon.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:the_bartender_app/models/recipe.dart';
import 'package:the_bartender_app/models/season.dart';
import 'package:the_bartender_app/models/tool.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/id_util.dart';
import 'package:the_bartender_app/utils/string_util.dart';
import 'package:the_bartender_app/viewmodels/season_view_model.dart';
import 'package:the_bartender_app/viewmodels/tool_view_model.dart';
import 'package:the_bartender_app/widgets/styled_drop_down.dart';

class InformationEditCard extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final RecipeDetail? recipeDetail;
  final Function(
      {int? prepTime,
      Season? season,
      List<Tool>? toolList,
      bool? alcoholic}) update;
  const InformationEditCard({
    super.key,
    required this.update,
    required this.formKey,
    this.recipeDetail,
  });

  @override
  State<InformationEditCard> createState() => _InformationEditCardState();
}

class _InformationEditCardState extends State<InformationEditCard> {
  int prepTime = 1;
  List<Season> seasonList = [];
  Season? selectedSeason;
  List<Tool> toolList = [];
  Tool? selectedTool;
  List<Tool> selectedToolList = [];
  bool isAlchoholic = true;
  bool isValide = true;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    seasonList =
        Provider.of<SeasonViewModel>(context, listen: false).seasonList ?? [];
    toolList =
        Provider.of<ToolViewModel>(context, listen: false).toolList ?? [];
    if (widget.recipeDetail == null) {
      selectedSeason = seasonList.firstWhere((element) =>
          element.id ==
          'a7bedcc8-7be6-42bb-9214-51a2b8067c96'); //*All Season ID
      widget.update(season: selectedSeason);
    } else {
      prepTime = widget.recipeDetail!.prepTimeMinutes;
      selectedSeason = widget.recipeDetail!.season;
      selectedToolList = widget.recipeDetail!.tools ?? [];
      isAlchoholic = widget.recipeDetail!.alcoholic;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  CommunityMaterialIcons.information_outline,
                  color: AppTheme.themeData.colorScheme.primary,
                  size: 35,
                ),
                Text(
                  '   ${'information'.i18n()}',
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
                  child: Row(
                    children: [
                      const SizedBox(
                          width: 80, child: Icon(CommunityMaterialIcons.clock)),
                      Expanded(
                        child: Text(
                          '$prepTime min.',
                          style: AppTheme.themeData.textTheme.bodyMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: IconButton(
                          onPressed: () {
                            showDurationPicker(
                                    context: context,
                                    initialTime: Duration(minutes: prepTime))
                                .then((value) {
                              if (value != null) {
                                widget.update(prepTime: value.inMinutes);
                                setState(() => prepTime = value.inMinutes);
                              }
                            });
                          },
                          icon: Icon(CommunityMaterialIcons.circle_edit_outline,
                              color: AppTheme.secondaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 45,
                        child: seasonToIcon(selectedSeason!.id),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 70),
                        child: StyledDropDown(
                          seasonDropDown: true,
                          onChanged: (value) {
                            widget.update(season: seasonList.firstWhere((element) => element.id == value));
                            setState(() {
                              selectedSeason =  seasonList.firstWhere((element) => element.id == value);
                            });
                          },
                          season: selectedSeason,
                          seasonList: seasonList,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 80,
                          child: Icon(isAlchoholic
                              ? CommunityMaterialIcons.glass_cocktail
                              : CommunityMaterialIcons.glass_cocktail_off)),
                      Expanded(
                        child: Text(
                          isAlchoholic
                              ? 'alcoholic'.i18n()
                              : 'non_alcoholic'.i18n(),
                          style: AppTheme.themeData.textTheme.bodyMedium,
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Switch(
                          value: isAlchoholic,
                          onChanged: (value) => setState(() {
                            isAlchoholic = value;
                            widget.update(alcoholic: value);
                          }),
                          inactiveThumbColor: AppTheme.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Stack(
                    children: [
                      const SizedBox(
                          width: 80,
                          height: 45,
                          child: Icon(CommunityMaterialIcons.tools)),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 70),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...selectedToolList.map(
                              (tool) => Container(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          tool.name,
                                          style: AppTheme
                                              .themeData.textTheme.bodyMedium,
                                        ),
                                        IconButton(
                                          onPressed: () => setState(() {
                                            selectedToolList.remove(tool);
                                            widget.update(
                                                toolList: selectedToolList);
                                          }),
                                          icon: const Icon(
                                            CommunityMaterialIcons.delete,
                                          ),
                                          color: AppTheme
                                              .themeData.colorScheme.error,
                                        )
                                      ],
                                    )),
                              ),
                            ),
                            toolList.length == selectedToolList.length
                                ? const SizedBox()
                                : Container(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: PopupMenuButton<Tool>(
                                        color: AppTheme.styledTextFieldColor,
                                        icon: const Icon(
                                          CommunityMaterialIcons.plus,
                                          color: Colors.green,
                                        ),
                                        onSelected: (value) => setState(() {
                                          selectedToolList.add(value);
                                          widget.update(
                                              toolList: selectedToolList);
                                        }),
                                        itemBuilder: (BuildContext context) {
                                          return Set<Tool>.from(toolList)
                                              .difference(Set<Tool>.from(
                                                  selectedToolList))
                                              .toList()
                                              .map((e) => PopupMenuItem<Tool>(
                                                    value: e,
                                                    child: Text(
                                                      capitalizeFirstLetter(
                                                          e.name),
                                                      style: AppTheme.themeData
                                                          .textTheme.bodyMedium,
                                                    ),
                                                  ))
                                              .toList();
                                        },
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
