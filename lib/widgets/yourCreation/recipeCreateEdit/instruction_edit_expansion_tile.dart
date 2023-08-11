import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/widgets/styled_textfield.dart';

class InstructionEditExpansionTile extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function({String? instruction}) update;
  const InstructionEditExpansionTile(
      {super.key, required this.formKey, required this.update});

  @override
  State<InstructionEditExpansionTile> createState() =>
      _InstructionEditExpansionTileState();
}

class _InstructionEditExpansionTileState
    extends State<InstructionEditExpansionTile> {
  final TextEditingController instructionController = TextEditingController();
  bool isValide = true;
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: ExpansionTile(
        shape: const Border(),
        leading: Icon(
          CommunityMaterialIcons.glass_cocktail,
          color: AppTheme.themeData.colorScheme.primary,
          size: 40,
        ),
        title: Text(
          'instructions'.i18n(),
          style: AppTheme.themeData.textTheme.titleSmall!.copyWith(
            color: AppTheme.themeData.colorScheme.primary,
          ),
        ),
        subtitle: isValide
            ? null
            : Text(
                'There is an Error',
                style: TextStyle(color: AppTheme.themeData.colorScheme.error),
              ),
        iconColor: AppTheme.themeData.colorScheme.primary,
        maintainState: true,
        collapsedIconColor: AppTheme.themeData.colorScheme.primary,
        childrenPadding: const EdgeInsets.only(left: 30, bottom: 20),
        expandedAlignment: Alignment.centerLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'instruction'.i18n(),
                style: AppTheme.themeData.textTheme.bodySmall!.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 30.0),
                child: StyledTextfield(
                  controller: instructionController,
                  textInputType: TextInputType.multiline,
                  onTapOutside: () =>
                      widget.update(instruction: instructionController.text),
                      focusNode: focusNode,
                  validator: (value) {
                    print('VALUE:' + value);
                    if (value == '') {
                      setState(() {
                        isValide = false;
                      });
                      return 'Please enter some text';
                    }
                    setState(() {
                      isValide = true;
                    });
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
