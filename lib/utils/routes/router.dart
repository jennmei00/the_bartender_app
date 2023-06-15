import 'package:auto_route/auto_route.dart';
import 'package:the_bartender_app/views/contact_view.dart';
import 'package:the_bartender_app/views/home_view.dart';
import 'package:the_bartender_app/views/news_and_events_view.dart';
import 'package:the_bartender_app/views/recipe/recipe_detail_view.dart';
import 'package:the_bartender_app/views/recipe/recipe_search_result_view.dart';
import 'package:the_bartender_app/views/recipe/recipe_view.dart';
import 'package:the_bartender_app/views/yourCreation/your_creation_detail_view.dart';
import 'package:the_bartender_app/views/yourCreation/your_creation_view.dart';

// * * Run the generator with
// * * dart run build_runner watch/build
// * * [watch] flag to watch the files' system for edits and rebuild as necessary
// * * [build] flag if you want the generator to run one time and exit

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: HomeView, initial: true),
    AutoRoute(page: RecipeView),
    AutoRoute(page: YourCreationView),
    AutoRoute(page: NewsAndEventsView),
    AutoRoute(page: ContactView),
    AutoRoute(page: RecipeSearchResultView),
    AutoRoute(page: RecipeDetailView),
    AutoRoute(page: YourCreationDetailView),
  ],
)
class $AppRouter {}
