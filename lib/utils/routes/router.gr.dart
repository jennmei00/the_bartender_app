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
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../../views/contact_view.dart' as _i5;
import '../../views/home_view.dart' as _i1;
import '../../views/news_and_events_view.dart' as _i4;
import '../../views/recipe/recipe_detail_view.dart' as _i7;
import '../../views/recipe/recipe_search_result_view.dart' as _i6;
import '../../views/recipe/recipe_view.dart' as _i2;
import '../../views/yourCreation/your_creation_detail_view.dart' as _i8;
import '../../views/yourCreation/your_creation_view.dart' as _i3;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    HomeViewRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomeView(),
      );
    },
    RecipeViewRoute.name: (routeData) {
      final args = routeData.argsAs<RecipeViewRouteArgs>(
          orElse: () => const RecipeViewRouteArgs());
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.RecipeView(key: args.key),
      );
    },
    YourCreationViewRoute.name: (routeData) {
      final args = routeData.argsAs<YourCreationViewRouteArgs>(
          orElse: () => const YourCreationViewRouteArgs());
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.YourCreationView(key: args.key),
      );
    },
    NewsAndEventsViewRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.NewsAndEventsView(),
      );
    },
    ContactViewRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.ContactView(),
      );
    },
    RecipeSearchResultViewRoute.name: (routeData) {
      final args = routeData.argsAs<RecipeSearchResultViewRouteArgs>(
          orElse: () => const RecipeSearchResultViewRouteArgs());
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.RecipeSearchResultView(key: args.key),
      );
    },
    RecipeDetailViewRoute.name: (routeData) {
      final args = routeData.argsAs<RecipeDetailViewRouteArgs>(
          orElse: () => const RecipeDetailViewRouteArgs());
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.RecipeDetailView(key: args.key),
      );
    },
    YourCreationDetailViewRoute.name: (routeData) {
      final args = routeData.argsAs<YourCreationDetailViewRouteArgs>(
          orElse: () => const YourCreationDetailViewRouteArgs());
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.YourCreationDetailView(key: args.key),
      );
    },
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(
          HomeViewRoute.name,
          path: '/',
        ),
        _i9.RouteConfig(
          RecipeViewRoute.name,
          path: '/recipe-view',
        ),
        _i9.RouteConfig(
          YourCreationViewRoute.name,
          path: '/your-creation-view',
        ),
        _i9.RouteConfig(
          NewsAndEventsViewRoute.name,
          path: '/news-and-events-view',
        ),
        _i9.RouteConfig(
          ContactViewRoute.name,
          path: '/contact-view',
        ),
        _i9.RouteConfig(
          RecipeSearchResultViewRoute.name,
          path: '/recipe-search-result-view',
        ),
        _i9.RouteConfig(
          RecipeDetailViewRoute.name,
          path: '/recipe-detail-view',
        ),
        _i9.RouteConfig(
          YourCreationDetailViewRoute.name,
          path: '/your-creation-detail-view',
        ),
      ];
}

/// generated route for
/// [_i1.HomeView]
class HomeViewRoute extends _i9.PageRouteInfo<void> {
  const HomeViewRoute()
      : super(
          HomeViewRoute.name,
          path: '/',
        );

  static const String name = 'HomeViewRoute';
}

/// generated route for
/// [_i2.RecipeView]
class RecipeViewRoute extends _i9.PageRouteInfo<RecipeViewRouteArgs> {
  RecipeViewRoute({_i10.Key? key})
      : super(
          RecipeViewRoute.name,
          path: '/recipe-view',
          args: RecipeViewRouteArgs(key: key),
        );

  static const String name = 'RecipeViewRoute';
}

class RecipeViewRouteArgs {
  const RecipeViewRouteArgs({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return 'RecipeViewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.YourCreationView]
class YourCreationViewRoute
    extends _i9.PageRouteInfo<YourCreationViewRouteArgs> {
  YourCreationViewRoute({_i10.Key? key})
      : super(
          YourCreationViewRoute.name,
          path: '/your-creation-view',
          args: YourCreationViewRouteArgs(key: key),
        );

  static const String name = 'YourCreationViewRoute';
}

class YourCreationViewRouteArgs {
  const YourCreationViewRouteArgs({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return 'YourCreationViewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.NewsAndEventsView]
class NewsAndEventsViewRoute extends _i9.PageRouteInfo<void> {
  const NewsAndEventsViewRoute()
      : super(
          NewsAndEventsViewRoute.name,
          path: '/news-and-events-view',
        );

  static const String name = 'NewsAndEventsViewRoute';
}

/// generated route for
/// [_i5.ContactView]
class ContactViewRoute extends _i9.PageRouteInfo<void> {
  const ContactViewRoute()
      : super(
          ContactViewRoute.name,
          path: '/contact-view',
        );

  static const String name = 'ContactViewRoute';
}

/// generated route for
/// [_i6.RecipeSearchResultView]
class RecipeSearchResultViewRoute
    extends _i9.PageRouteInfo<RecipeSearchResultViewRouteArgs> {
  RecipeSearchResultViewRoute({_i10.Key? key})
      : super(
          RecipeSearchResultViewRoute.name,
          path: '/recipe-search-result-view',
          args: RecipeSearchResultViewRouteArgs(key: key),
        );

  static const String name = 'RecipeSearchResultViewRoute';
}

class RecipeSearchResultViewRouteArgs {
  const RecipeSearchResultViewRouteArgs({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return 'RecipeSearchResultViewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.RecipeDetailView]
class RecipeDetailViewRoute
    extends _i9.PageRouteInfo<RecipeDetailViewRouteArgs> {
  RecipeDetailViewRoute({_i10.Key? key})
      : super(
          RecipeDetailViewRoute.name,
          path: '/recipe-detail-view',
          args: RecipeDetailViewRouteArgs(key: key),
        );

  static const String name = 'RecipeDetailViewRoute';
}

class RecipeDetailViewRouteArgs {
  const RecipeDetailViewRouteArgs({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return 'RecipeDetailViewRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.YourCreationDetailView]
class YourCreationDetailViewRoute
    extends _i9.PageRouteInfo<YourCreationDetailViewRouteArgs> {
  YourCreationDetailViewRoute({_i10.Key? key})
      : super(
          YourCreationDetailViewRoute.name,
          path: '/your-creation-detail-view',
          args: YourCreationDetailViewRouteArgs(key: key),
        );

  static const String name = 'YourCreationDetailViewRoute';
}

class YourCreationDetailViewRouteArgs {
  const YourCreationDetailViewRouteArgs({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return 'YourCreationDetailViewRouteArgs{key: $key}';
  }
}
