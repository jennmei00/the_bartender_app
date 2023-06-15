import 'package:flutter/material.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';

class StyledTextfield extends StatelessWidget {
  final TextEditingController controller;
  final IconData? suffixIcon;
  final Function? onSuffixIconPressed;
  final double height;
  final double? width;
  final TextInputType? textInputType;

  const StyledTextfield({
    super.key,
    required this.controller,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.height = 40,
    this.width,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: textInputType != null ? null : height,
      width: width,
      child: TextField(
        style: AppTheme.themeData.textTheme.bodyMedium,
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 3, color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(width: 3, color: Colors.white),
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
        maxLines: textInputType != null ? null : 1,
      ),
    );
  }
}
