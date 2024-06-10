// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;

import '../../models/drink_type.dart' as _i14;
import '../../models/recipe.dart' as _i15;
import '../../views/contact_view.dart' as _i6;
import '../../views/home_view.dart' as _i2;
import '../../views/myRecipe/my_recipe_view.dart' as _i10;
import '../../views/news_and_events_view.dart' as _i5;
import '../../views/recipe/recipe_detail_view.dart' as _i8;
import '../../views/recipe/recipe_search_result_view.dart' as _i7;
import '../../views/recipe/recipe_view.dart' as _i3;
import '../../views/settings/settings_view.dart' as _i11;
import '../../views/welcome_view.dart' as _i1;
import '../../views/yourCreation/your_creation_detail_view.dart' as _i9;
import '../../views/yourCreation/your_creation_view.dart' as _i4;

class AppRouter extends _i12.RootStackRouter {
  AppRouter([_i13.GlobalKey<_i13.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    WelcomeViewRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.WelcomeView(),
      );
    },
    HomeViewRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.HomeView(),
      );
    },
    RecipeViewRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.RecipeView(),
      );
    },
    YourCreationViewRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.YourCreationView(),
      );
    },
    NewsAndEventsViewRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.NewsAndEventsView(),
      );
    },
    ContactViewRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.ContactView(),
      );
    },
    RecipeSearchResultViewRoute.name: (routeData) {
      final args = routeData.argsAs<RecipeSearchResultViewRouteArgs>(
          orElse: () => const RecipeSearchResultViewRouteArgs());
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.RecipeSearchResultView(key: args.key),
      );
    },
    RecipeDetailViewRoute.name: (routeData) {
      final args = routeData.argsAs<RecipeDetailViewRouteArgs>();
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.RecipeDetailView(
          key: args.key,
          recipeName: args.recipeName,
          isEditable: args.isEditable,
        ),
      );
    },
    YourCreationDetailViewRoute.name: (routeData) {
      final args = routeData.argsAs<YourCreationDetailViewRouteArgs>();
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.YourCreationDetailView(
          key: args.key,
          drinkType: args.drinkType,
          name: args.name,
          recipeDetail: args.recipeDetail,
        ),
      );
    },
    MyRecipeViewRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.MyRecipeView(),
      );
    },
    SettingsViewRoute.name: (routeData) {
      final args = routeData.argsAs<SettingsViewRouteArgs>(
          orElse: () => const SettingsViewRouteArgs());
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.SettingsView(key: args.key),
      );
    },
  };

  @override
  List<_i12.RouteConfig> get routes => [
        _i12.RouteConfig(
          WelcomeViewRoute.name,
          path: '/welcome_view',
        ),
        _i12.RouteConfig(
          HomeViewRoute.name,
          path: '/home-view',
        ),
        _i12.RouteConfig(
          RecipeViewRoute.name,
          path: '/recipe-view',
        ),
        _i12.RouteConfig(
          YourCreationViewRoute.name,
          path: '/your-creation-view',
        ),
        _i12.RouteConfig(
          NewsAndEventsViewRoute.name,
          path: '/news-and-events-view',
        ),
        _i12.RouteConfig(
          ContactViewRoute.name,
          path: '/contact-view',
        ),
        _i12.RouteConfig(
          RecipeSearchResultViewRoute.name,
          path: '/recipe-search-result-view',
        ),
        _i12.RouteConfig(
          RecipeDetailViewRoute.name,
          path: '/recipe-detail-view',
        ),
        _i12.RouteConfig(
          YourCreationDetailViewRoute.name,
          path: '/your-creation-detail-view',
        ),
        _i12.RouteConfig(
          MyRecipeViewRoute.name,
          path: '/my-recipe-view',
        ),
        _i12.RouteConfig(
          SettingsViewRoute.name,
          path: '/settings-view',
        ),
      ];
}

/// generated route for
/// [_i1.WelcomeView]
class WelcomeViewRoute extends _i12.PageRouteInfo<void> {
  const WelcomeViewRoute()
      : super(
          WelcomeViewRoute.name,
          path: '/welcome_view',
        );

  static const String name = 'WelcomeViewRoute';
}

/// generated route for
/// [_i2.HomeView]
class HomeViewRoute extends _i12.PageRouteInfo<void> {
  const HomeViewRoute()
      : super(
          HomeViewRoute.name,
          path: '/home-view',
        );

  static const String name = 'HomeViewRoute';
}

/// generated route for
/// [_i3.RecipeView]
class RecipeViewRoute extends _i12.PageRouteInfo<void> {
  const RecipeViewRoute()
      : super(
          RecipeViewRoute.name,
          path: '/recipe-view',
        );

  static const String name = 'RecipeViewRoute';
}

/// generated route for
/// [_i4.YourCreationView]
class YourCreationViewRoute extends _i12.PageRouteInfo<void> {
  const YourCreationViewRoute()
      : super(
          YourCreationViewRoute.name,
          path: '/your-creation-view',
        );

  static const String name = 'YourCreationViewRoute';
}

/// generated route for
/// [_i5.NewsAndEventsView]
class NewsAndEventsViewRoute extends _i12.PageRouteInfo<void> {
  const NewsAndEventsViewRoute()
      : super(
          NewsAndEventsViewRoute.name,
          path: '/news-and-events-view',
        );

  static const String name = 'NewsAndEventsViewRoute';
}

/// generated route for
/// [_i6.ContactView]
class ContactViewRoute extends _i12.PageRouteInfo<void> {
  const ContactViewRoute()
      : super(
          ContactViewRoute.name,
          path: '/contact-view',
        );

  static const String name = 'ContactViewRoute';
}

/// generated route for
/// [_i7.RecipeSearchResultView]
class RecipeSearchResultViewRoute
    extends _i12.PageRouteInfo<RecipeSearchResultViewRouteArgs> {
  RecipeSearchResultViewRoute({_i13.Key? key})
      : super(
          RecipeSearchResultViewRoute.name,
          path: '/recipe-search-result-view',
          args: RecipeSearchResultViewRouteArgs(key: key),
        );

  static const String name = 'RecipeSearchResultViewRoute';
}

class RecipeSearchResultViewRouteArgs {
  const RecipeSearchResultViewRouteArgs({this.key});

  final _i13.Key? key;

  @override
  String toString() {
    return 'RecipeSearchResultViewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.RecipeDetailView]
class RecipeDetailViewRoute
    extends _i12.PageRouteInfo<RecipeDetailViewRouteArgs> {
  RecipeDetailViewRoute({
    _i13.Key? key,
    required String recipeName,
    bool isEditable = false,
  }) : super(
          RecipeDetailViewRoute.name,
          path: '/recipe-detail-view',
          args: RecipeDetailViewRouteArgs(
            key: key,
            recipeName: recipeName,
            isEditable: isEditable,
          ),
        );

  static const String name = 'RecipeDetailViewRoute';
}

class RecipeDetailViewRouteArgs {
  const RecipeDetailViewRouteArgs({
    this.key,
    required this.recipeName,
    this.isEditable = false,
  });

  final _i13.Key? key;

  final String recipeName;

  final bool isEditable;

  @override
  String toString() {
    return 'RecipeDetailViewRouteArgs{key: $key, recipeName: $recipeName, isEditable: $isEditable}';
  }
}

/// generated route for
/// [_i9.YourCreationDetailView]
class YourCreationDetailViewRoute
    extends _i12.PageRouteInfo<YourCreationDetailViewRouteArgs> {
  YourCreationDetailViewRoute({
    _i13.Key? key,
    required _i14.DrinkType drinkType,
    required String name,
    _i15.RecipeDetail? recipeDetail,
  }) : super(
          YourCreationDetailViewRoute.name,
          path: '/your-creation-detail-view',
          args: YourCreationDetailViewRouteArgs(
            key: key,
            drinkType: drinkType,
            name: name,
            recipeDetail: recipeDetail,
          ),
        );

  static const String name = 'YourCreationDetailViewRoute';
}

class YourCreationDetailViewRouteArgs {
  const YourCreationDetailViewRouteArgs({
    this.key,
    required this.drinkType,
    required this.name,
    this.recipeDetail,
  });

  final _i13.Key? key;

  final _i14.DrinkType drinkType;

  final String name;

  final _i15.RecipeDetail? recipeDetail;

  @override
  String toString() {
    return 'YourCreationDetailViewRouteArgs{key: $key, drinkType: $drinkType, name: $name, recipeDetail: $recipeDetail}';
  }
}

/// generated route for
/// [_i10.MyRecipeView]
class MyRecipeViewRoute extends _i12.PageRouteInfo<void> {
  const MyRecipeViewRoute()
      : super(
          MyRecipeViewRoute.name,
          path: '/my-recipe-view',
        );

  static const String name = 'MyRecipeViewRoute';
}

/// generated route for
/// [_i11.SettingsView]
class SettingsViewRoute extends _i12.PageRouteInfo<SettingsViewRouteArgs> {
  SettingsViewRoute({_i13.Key? key})
      : super(
          SettingsViewRoute.name,
          path: '/settings-view',
          args: SettingsViewRouteArgs(key: key),
        );

  static const String name = 'SettingsViewRoute';
}

class SettingsViewRouteArgs {
  const SettingsViewRouteArgs({this.key});

  final _i13.Key? key;

  @override
  String toString() {
    return 'SettingsViewRouteArgs{key: $key}';
  }
}
