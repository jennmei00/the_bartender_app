import 'package:flutter/material.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';

class StyledButton extends StatelessWidget {
  final String title;
  final Color? color;
  final Function()? onButtonPressed;

  const StyledButton(
      {Key? key,
      required this.title,
      required this.onButtonPressed,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onButtonPressed,
      style: color != null
          ? AppTheme.themeData.elevatedButtonTheme.style!.copyWith(
              foregroundColor: MaterialStateProperty.all(color),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: color!, width: 3)),
              ))
          : null,
      child: Padding(
        padding: const EdgeInsets.only(top: 4, right: 8, left: 8, bottom: 0),
        child: Text(
          title.toUpperCase(),
        ),
      ),
    );
  }
}
