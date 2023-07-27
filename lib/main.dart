import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/globals.dart';
import 'package:the_bartender_app/utils/routes/router.gr.dart';
import 'package:the_bartender_app/viewmodels/drink_type_view_model.dart';
import 'package:the_bartender_app/viewmodels/season_view_model.dart';
import 'package:the_bartender_app/viewmodels/recipe_detail_view_model.dart';
import 'package:the_bartender_app/viewmodels/recipe_view_model.dart';
import 'package:the_bartender_app/viewmodels/tool_view_model.dart';
import 'package:the_bartender_app/viewmodels/unit_view_model.dart';
import 'package:the_bartender_app/viewmodels/user_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  MyApp({super.key});

  //* This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(
          AppTheme.backgroundImage, context); //TODOLoad Image before starting
      precacheImage(AppTheme.woodBackgroundImage, context);
    });

    //TODODelete this row 
      // prefs.setBool('isFirstStart', true);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: RecipeViewModel()),
        ChangeNotifierProvider.value(value: RecipeDetailViewModel()),
        ChangeNotifierProvider.value(value: SeasonViewModel()),
        ChangeNotifierProvider.value(value: DrinkTypeViewModel()),
        ChangeNotifierProvider.value(value: ToolViewModel()),
        ChangeNotifierProvider.value(value: UnitViewModel()),
        ChangeNotifierProvider.value(value: UserViewModel()),
      ],
      child: MaterialApp.router(
        title: 'The Bartender',
        theme: AppTheme.themeData,
        routerDelegate: _appRouter.delegate(
            initialRoutes: sharedPreferences!.getBool('isFirstStart') ?? true
                ? [const WelcomeViewRoute()]
                : [const HomeViewRoute()]),
        routeInformationParser: _appRouter.defaultRouteParser(),
        localizationsDelegates: [
          //* delegate from flutter_localization
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          //* delegate from localization package.
          LocalJsonLocalization.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('de', 'DE'),
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          //TODOcheck Localization
          // if(supportedLocales.contains(locale)) {
          //   return locale;
          // }

          //*define en_US as default when de language code is 'en'
          if (locale?.languageCode == 'en') {
            return const Locale('en', 'US');
          }

          //*default language
          // return const Locale('de', 'DE');
          return const Locale('en', 'US');
        },
      ),
    );
  }
}
