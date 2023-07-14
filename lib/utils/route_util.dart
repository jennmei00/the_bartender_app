import 'package:auto_route/auto_route.dart';
import 'package:the_bartender_app/utils/routes/router.gr.dart';

enum DrawerView {
  home,
  recipes,
  yourCreation,
  newsAndEvents,
  contact,
}

Map<DrawerView, PageRouteInfo> drawerViewMap  = {
  DrawerView.home: const HomeViewRoute(),
  DrawerView.recipes: RecipeViewRoute(),
  DrawerView.yourCreation: YourCreationViewRoute(),
  DrawerView.newsAndEvents: const NewsAndEventsViewRoute(),
  DrawerView.contact: const ContactViewRoute(),
};