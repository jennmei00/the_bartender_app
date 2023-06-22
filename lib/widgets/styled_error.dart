import 'package:flutter/material.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';

class StyledError extends StatelessWidget {
  final String message;

  const StyledError({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      padding: const EdgeInsets.all(20),
      child: Card(
    child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          message,
          style: AppTheme.themeData.textTheme.headlineMedium,
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}