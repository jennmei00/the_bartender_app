import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  final String title;
  final Function()? onButtonPressed;

  const StyledButton({Key? key, required this.title, required this.onButtonPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onButtonPressed,
      child: Padding(
        padding: const EdgeInsets.only(top: 4, right: 8, left: 8, bottom: 0),
        child: Text(
          title.toUpperCase(),
        ),
      ),
    );
  }
}
