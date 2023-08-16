import 'package:flutter/material.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';

class InformationItem extends StatelessWidget {
  final Icon icon;
  final String info;
  const InformationItem({super.key, required this.icon, required this.info});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          SizedBox(width: 80, child: icon),
          Text(
            info,
            style: AppTheme.themeData.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
