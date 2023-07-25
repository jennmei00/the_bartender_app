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
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.styledTextFieldColor.withOpacity(0.6),
          border: Border.all(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: DropdownButton(
              value: seasonDropDown ? season! : unit!,
              items: seasonDropDown
                  ? seasonList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(capitalizeFirstLetter(e.name)),
                          ))
                      .toList()
                  : unitList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(seasonDropDown
                                ? capitalizeFirstLetter(e.name)
                                : e.name),
                          ))
                      .toList(),
              onChanged: (value) => onChanged(value),
              icon: const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Icon(CommunityMaterialIcons.chevron_down)),
              style: AppTheme.themeData.textTheme.bodyMedium,
              underline: Container(),
              isExpanded: true,
            )));
  }
}
