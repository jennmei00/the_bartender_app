import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';

class StyledTextfield extends StatelessWidget {
  final TextEditingController controller;
  final IconData? suffixIcon;
  final Function? onSuffixIconPressed;
  final double? height;
  final double? width;
  final TextInputType? textInputType;
  final Function? validator;
  final bool enabled;
  final bool onlyInteger;
  final bool obscureText;
  final Function? onTapOutside;
  final Function? onChanged;

  final FocusNode? focusNode;

  const StyledTextfield({
    super.key,
    required this.controller,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.height,
    this.width,
    this.textInputType,
    this.validator,
    this.enabled = true,
    this.onlyInteger = false,
    this.obscureText = false,
    this.onTapOutside,
    this.focusNode,
    this.onChanged,
  });

  final OutlineInputBorder _outlineInputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
    borderSide: BorderSide(width: 3, color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: textInputType == TextInputType.multiline ? null : height,
      width: width,
      child: TextFormField(
        focusNode: focusNode,
        obscureText: obscureText,
        inputFormatters: onlyInteger
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ]
            : null,
        enabled: enabled,
        onTapOutside: onTapOutside == null
            ? null
            : (_) => focusNode?.hasFocus ?? false ? onTapOutside!() : null,
        onChanged: onChanged == null ? null : (value) => onChanged!(),
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
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: () => onSuffixIconPressed,
                  icon: Icon(suffixIcon, size: 30),
                )
              : null,
          suffixIconColor: Colors.white,
        ),
        keyboardType: textInputType,
        maxLines: textInputType == TextInputType.multiline ? null : 1,
      ),
    );
  }
}
