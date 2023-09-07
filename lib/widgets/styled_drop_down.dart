import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:the_bartender_app/models/season.dart';
import 'package:the_bartender_app/models/unit.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/string_util.dart';

class StyledDropDown extends StatelessWidget {
  final Function onChanged;
  final Season? season;
  final List<Season> seasonList;
  final Unit? unit;
  final List<Unit> unitList;
  final bool seasonDropDown;
  const StyledDropDown({
    super.key,
    required this.onChanged,
    this.season,
    this.seasonList = const [],
    this.unit,
    this.unitList = const [],
    required this.seasonDropDown,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: AppTheme.styledTextFieldColor.withOpacity(0.6),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: DropdownButton<String>(
              value: seasonDropDown ? season!.id : unit == null ? null : unit!.id,
              items: seasonDropDown
                  ? seasonList
                      .map((e) => DropdownMenuItem(
                            value: e.id,
                            child: Text(capitalizeFirstLetter(e.name)),
                          ))
                      .toList()
                  : unitList
                      .map((e) => DropdownMenuItem(
                            value: e.id,
                            child: Text(seasonDropDown
                                ? capitalizeFirstLetter(e.name)
                                : e.name),
                          ))
                      .toList(),
              onChanged: (value) => onChanged(value),
              icon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    CommunityMaterialIcons.chevron_down,
                    color: AppTheme.secondaryColor,
                  )),
              style: AppTheme.themeData.textTheme.bodyMedium,
              underline: Container(),
              isExpanded: true,
            )));
  }
}
