import 'package:auto_route/auto_route.dart';
import 'package:the_bartender_app/utils/routes/router.gr.dart';

enum DrawerView {
  home,
  recipe,
  yourCreation,
  newsAndEvents,
  contact,
}

Map<DrawerView, PageRouteInfo> drawerViewMap  = {
  DrawerView.home: const HomeViewRoute(),
  DrawerView.recipe: RecipeViewRoute(),
  DrawerView.yourCreation: YourCreationViewRoute(),
  DrawerView.newsAndEvents: const NewsAndEventsViewRoute(),
  DrawerView.contact: const ContactViewRoute(),
};