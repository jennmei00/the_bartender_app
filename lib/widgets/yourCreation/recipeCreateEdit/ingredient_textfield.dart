import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';

class IngredientTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? title;
  final Function? validator;
  final bool isNumeric;
  final bool isMultiline;
  final Function? onTapOutside;
  final FocusNode? focusNode;

  const IngredientTextField({
    super.key,
    required this.controller,
    this.title,
    this.validator,
    this.isNumeric = false,
    this.isMultiline = false,
    this.onTapOutside,
    this.focusNode,
  });

  final OutlineInputBorder _outlineInputBorder = const OutlineInputBorder(
    borderSide: BorderSide.none,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == null
            ? const SizedBox()
            : Text(title!, style: AppTheme.themeData.textTheme.bodySmall),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: AppTheme.styledTextFieldColor.withOpacity(0.6),
          ),
          child: TextFormField(
            focusNode: focusNode,
            maxLines: isMultiline ? null : 1,
            inputFormatters: isNumeric
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,1}')),
                  ]
                : null,
            onTapOutside: onTapOutside == null
                ? (_) => FocusScope.of(context).requestFocus(FocusNode())
                : (_) => focusNode?.hasFocus ?? false ? onTapOutside!() : null,
            validator: validator == null ? null : (value) => validator!(value),
            style: AppTheme.themeData.textTheme.bodyMedium,
            controller: controller,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              enabledBorder: _outlineInputBorder,
              disabledBorder: _outlineInputBorder,
              border: _outlineInputBorder,
              errorBorder: _outlineInputBorder.copyWith(
                borderSide: BorderSide(
                    width: 3, color: AppTheme.themeData.colorScheme.error),
              ),
              filled: true,
              fillColor: AppTheme.styledTextFieldColor.withOpacity(0.6),
            ),
          ),
        ),
      ],
    );
  }
}
