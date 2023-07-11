import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:the_bartender_app/models/season.dart';
import 'package:the_bartender_app/models/tool.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/string_util.dart';
import 'package:the_bartender_app/viewmodels/season_view_model.dart';
import 'package:the_bartender_app/viewmodels/tool_view_model.dart';
import 'package:the_bartender_app/widgets/styled_drop_down.dart';
import 'package:the_bartender_app/widgets/styled_textfield.dart';

class InformationEditExpansionTile extends StatefulWidget {
  const InformationEditExpansionTile({super.key});

  @override
  State<InformationEditExpansionTile> createState() =>
      _InformationEditExpansionTileState();
}

class _InformationEditExpansionTileState
    extends State<InformationEditExpansionTile> {
  final TextEditingController prepTimeController =
      TextEditingController(text: '10');
  List<Season> seasonList = [];
  Season? selectedSeason;
  List<Tool> toolList = [];
  Tool? selectedTool;
  List<Tool> selectedToolList = [];

  @override
  void initState() {
    super.initState();
    seasonList =
        Provider.of<SeasonViewModel>(context, listen: false).seasonList ?? [];
    selectedSeason = seasonList.first;

    toolList =
        Provider.of<ToolViewModel>(context, listen: false).toolList ?? [];
    selectedTool = toolList.first;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const Border(),
      leading: Icon(
        CommunityMaterialIcons.information_outline,
        color: AppTheme.themeData.colorScheme.primary,
        size: 40,
      ),
      title: Text(
        'information'.i18n(),
        style: AppTheme.themeData.textTheme.titleSmall!.copyWith(
          color: AppTheme.themeData.colorScheme.primary,
        ),
      ),
      iconColor: AppTheme.themeData.colorScheme.primary,
      collapsedIconColor: AppTheme.themeData.colorScheme.primary,
      childrenPadding: const EdgeInsets.only(left: 30),
      expandedAlignment: Alignment.center,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      initiallyExpanded: true, //TODOCLOSE
      children: [
        Table(
          defaultColumnWidth: const IntrinsicColumnWidth(),
          children: [
            TableRow(
              children: [
                Text(
                  'prepare_time'.i18n(),
                  style: AppTheme.themeData.textTheme.bodySmall!.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Stack(
                    children: [
                      StyledTextfield(
                        controller: prepTimeController,
                        width: 130,
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 135.0, top: 10, bottom: 20.0),
                        child: Text(
                          'minutes'.i18n().toUpperCase(),
                          style: AppTheme.themeData.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Text(
                  'season'.i18n(),
                  style: AppTheme.themeData.textTheme.bodySmall!.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, bottom: 20.0),
                  child: StyledDropDown(
                    onSeasonChanged: (value) {
                      setState(() {
                        selectedSeason = value;
                      });
                    },
                    season: selectedSeason!,
                    seasonList: seasonList,
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Text(
                  'tools'.i18n(),
                  style: AppTheme.themeData.textTheme.bodySmall!.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Column(
                  children: [
                    ...selectedToolList.map(
                      (e) => Padding(
                        padding:
                            const EdgeInsets.only(left: 30.0, bottom: 20.0),
                        child: Stack(
                          children: [
                            StyledTextfield(
                              controller: TextEditingController(text: e.name),
                              width: 200,
                              height: 40,
                              enabled: false,
                            ),
                            Container(
                              width: 200,
                              height: 40,
                              padding: const EdgeInsets.only(right: 10),
                              child: IconButton(
                                alignment: Alignment.centerRight,
                                icon: const Icon(CommunityMaterialIcons.minus),
                                onPressed: () => setState(() {
                                  selectedToolList.remove(e);
                                }),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, bottom: 20.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: PopupMenuButton<Tool>(
                          color: AppTheme.styledTextFieldColor,
                          icon: const Icon(
                            CommunityMaterialIcons.plus,
                            color: Colors.white,
                          ),
                          onSelected: (value) => setState(() {
                            selectedToolList.add(value);
                          }),
                          itemBuilder: (BuildContext context) {
                            return Set<Tool>.from(toolList)
                                .difference(Set<Tool>.from(selectedToolList))
                                .toList()
                                .map((e) => PopupMenuItem<Tool>(
                                      value: e,
                                      child: Text(
                                        capitalizeFirstLetter(e.name),
                                        style: AppTheme
                                            .themeData.textTheme.bodyMedium,
                                      ),
                                    ))
                                .toList();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            TableRow(
              children: [
                Text(
                  'alcoholic'.i18n(),
                  style: AppTheme.themeData.textTheme.bodySmall!.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2, left: 20),
                      child: Row(
                        children: [
                          Transform.scale(
                            scale: 0.8,
                            child: Radio(
                              value: false,
                              groupValue: true,
                              onChanged: (value) {},
                              activeColor: AppTheme.secondaryColor,
                            ),
                          ),
                          Text(
                            'yes'.i18n(),
                            style: AppTheme.themeData.textTheme.bodySmall,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Transform.scale(
                            scale: 0.8,
                            child: Radio(
                              value: true,
                              groupValue: true,
                              onChanged: (value) {},
                              activeColor: AppTheme.secondaryColor,
                            ),
                          ),
                          Text(
                            'no'.i18n(),
                            style: AppTheme.themeData.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
