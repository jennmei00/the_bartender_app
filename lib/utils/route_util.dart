import 'package:auto_route/auto_route.dart';
import 'package:the_bartender_app/utils/routes/router.gr.dart';

enum DrawerView {
  home,
  myRecipes,
  recipes,
  yourCreation,
  newsAndEvents,
  contact,
  settings,
}

Map<DrawerView, PageRouteInfo> drawerViewMap = {
  DrawerView.home: const HomeViewRoute(),
  DrawerView.recipes: const RecipeViewRoute(),
  DrawerView.myRecipes:  const MyRecipeViewRoute(),
  DrawerView.yourCreation: const YourCreationViewRoute(),
  DrawerView.newsAndEvents: const NewsAndEventsViewRoute(),
  DrawerView.contact: const ContactViewRoute(),
  DrawerView.settings: SettingsViewRoute(),
};
