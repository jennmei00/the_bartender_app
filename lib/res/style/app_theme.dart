import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppTheme {
  AppTheme._();

  static final Color _primaryColor = HexColor('BC9635');
  static final Color secondaryColor = HexColor('F0DBA4');
  static final Color _errorColor = HexColor('FF5656');
  static final Color _elevatedButtonBackgroundColor = HexColor('484040');
  static final Color normalCardBackgroundcolor = HexColor('484040').withOpacity(0.4);
  static final Color drawerBackgroundcolor = HexColor('32241F');

  static const AssetImage backgroundImage =
      AssetImage('assets/images/background.jpg');
  static const AssetImage woodBackgroundImage =
      AssetImage('assets/images/background_wood.png');
  static final ImageFilter backgroundImageFilter =
      ImageFilter.blur(sigmaX: 0.7, sigmaY: 0.7);

  static final Color styledTextFieldColor = _elevatedButtonBackgroundColor;
  static final BoxDecoration recipeCardBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    gradient: LinearGradient(
      colors: [
        AppTheme._elevatedButtonBackgroundColor.withOpacity(0.09),
        AppTheme._elevatedButtonBackgroundColor.withOpacity(0.72),
        AppTheme._elevatedButtonBackgroundColor,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );

  static final ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.dark,
      primary: _primaryColor,
      error: _errorColor,
    ),
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      color: Colors.white.withOpacity(0.2),
      titleTextStyle: const TextStyle(
        fontFamily: 'Jomhuria',
        fontSize: 40,
      ),
      centerTitle: true,
    ),
    textTheme: TextTheme(
      //*style for titles of TextFields and view texts
      titleSmall: const TextStyle(
        fontFamily: 'GrandHotel',
        fontSize: 30,
      ),
      //*style for titles with GrandHotel fontFamily
      titleMedium: const TextStyle(
        fontFamily: 'GrandHotel',
        fontSize: 40,
      ),
      //*style for titles with GrandHotel fontFamily: for title of recipe_detail and add_creation
      titleLarge: TextStyle(
        fontFamily: 'GrandHotel',
        fontSize: 65,
        decorationStyle: TextDecorationStyle.dashed,
        decorationColor: secondaryColor,
        decoration: TextDecoration.underline,
        decorationThickness: 2,
      ),
      //*style for appdrawer headline
      headlineSmall: TextStyle(
        fontFamily: 'Jomhuria',
        fontSize: 47,
        color: _primaryColor,
      ),
      //*style for appdrawer navigationitems
      headlineMedium: const TextStyle(
        fontFamily: 'Jomhuria',
        fontSize: 40,
      ),
      //*style for recipeCard creatorname
      displaySmall: const TextStyle(
        fontFamily: 'CreteRound',
        fontSize: 10,
      ),
      //*style for CreteRound
      displayMedium: const TextStyle(
        fontFamily: 'CreteRound',
        fontSize: 23,
        color: Colors.white,
      ),
      bodySmall: const TextStyle(
        fontFamily: 'CreteRound',
        fontSize: 16,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'CreteRound',
        fontSize: 20,
        color: secondaryColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontFamily: 'Jomhuria', fontSize: 45),
        foregroundColor: _primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: _primaryColor, width: 3)),
        backgroundColor: _elevatedButtonBackgroundColor.withOpacity(0.6),
      ),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: drawerBackgroundcolor.withOpacity(0.90),
      width: 240,
    ),
    dividerTheme: DividerThemeData(
      color: _primaryColor,
      thickness: 3,
      endIndent: 20,
      indent: 20,
    ),
    cardColor: secondaryColor.withOpacity(0.8),
  );
}
