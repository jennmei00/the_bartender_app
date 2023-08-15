import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/widgets/yourCreation/recipeCreateEdit/ingredient_textfield.dart';

class InstructionEditCard extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function({String? instruction}) update;
  const InstructionEditCard(
      {super.key, required this.formKey, required this.update});

  @override
  State<InstructionEditCard> createState() => _InstructionEditCardState();
}

class _InstructionEditCardState extends State<InstructionEditCard> {
  final TextEditingController instructionController = TextEditingController();

  final FocusNode focusNode = FocusNode();

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
                    CommunityMaterialIcons.glass_cocktail,
                    color: AppTheme.themeData.colorScheme.primary,
                    size: 35,
                  ),
                  Text(
                    '   ${'instructions'.i18n()}',
                    style: AppTheme.themeData.textTheme.titleSmall!.copyWith(
                      color: AppTheme.themeData.colorScheme.primary,
                    ),
                  ),
                ],
              ), //* Body
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IngredientTextField(
                          controller: instructionController,
                          isMultiline: true,
                          onTapOutside: () => widget.update(
                              instruction: instructionController.text),
                          focusNode: focusNode,
                          validator: (value) {
                            if (value == '') {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        )),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
