import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:the_bartender_app/data/api/api_response.dart';
import 'package:the_bartender_app/models/drink_type.dart';
import 'package:the_bartender_app/models/recipe_filter.dart';
import 'package:the_bartender_app/models/season.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/route_util.dart';
import 'package:the_bartender_app/utils/routes/router.gr.dart';
import 'package:the_bartender_app/viewmodels/drink_type_view_model.dart';
import 'package:the_bartender_app/viewmodels/recipe_view_model.dart';
import 'package:the_bartender_app/viewmodels/season_view_model.dart';
import 'package:the_bartender_app/widgets/custom_scaffold.dart';
import 'package:the_bartender_app/widgets/styled_button.dart';
import 'package:the_bartender_app/widgets/styled_error.dart';
import 'package:the_bartender_app/widgets/styled_textfield.dart';

class RecipeView extends StatefulWidget {
  const RecipeView({super.key});

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  final TextEditingController searchTextController = TextEditingController();
  final GlobalKey expansionTileKey = GlobalKey();
  final GlobalKey customScrollViewKey = GlobalKey();

  List<Season> filteredSeason = [];
  List<DrinkType> filteredDrinkType = [];
  bool alcoholicYesFiltered = false;
  bool alcobolicNoFiltered = false;

  void _onClearSearchPressed() {
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      searchTextController.text = '';
      filteredSeason = [];
      filteredDrinkType = [];
      alcobolicNoFiltered = false;
      alcoholicYesFiltered = false;
    });
  }

  void onSearchPressed(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());

    Provider.of<RecipeViewModel>(context, listen: false)
        .setSearchText(searchTextController.text);

    Provider.of<RecipeViewModel>(context, listen: false)
        .fetchRecipeData(searchTextController.text,
            recipeFilter: RecipeFilter(
              seasonnList: filteredSeason,
              drinkTypeList: filteredDrinkType,
              alcoholicYes: alcoholicYesFiltered,
              alcoholicNo: alcobolicNoFiltered,
            ));

    AutoRouter.of(context).push(RecipeSearchResultViewRoute());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      image: AppTheme.backgroundImage,
      drawerView: DrawerView.recipes,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              key: customScrollViewKey,
              slivers: [
                SliverAppBar(
                  title: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 0),
                    child: Text(
                      'recipes'.i18n().toUpperCase(),
                    ),
                  ),
                  leading: Builder(builder: (context) {
                    return IconButton(
                      icon: const Icon(CommunityMaterialIcons.dots_vertical),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    );
                  }),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Column(
                      children: [
                        const SizedBox(height: 20),
                        SvgPicture.asset(
                          'assets/svg/neon_find.svg',
                          width: MediaQuery.of(context).size.width * 0.50,
                        ),
                        Container(
                          padding: const EdgeInsets.all(25),
                          child: Text(
                            'search_text'.i18n(),
                            style: AppTheme.themeData.textTheme.titleSmall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Consumer2<SeasonViewModel, DrinkTypeViewModel>(
                          builder: (context, seasonVM, drinkTypeVM, child) {
                            if (seasonVM.response.status == Status.error ||
                                drinkTypeVM.response.status == Status.error) {
                              return StyledError(
                                  message:
                                      '${seasonVM.response.status == Status.error ? seasonVM.response.message : drinkTypeVM.response.message}');
                            } else if (seasonVM.response.status ==
                                    Status.completed &&
                                drinkTypeVM.response.status ==
                                    Status.completed) {
                              return getLoadedData();
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator.adaptive());
                            }
                          },
                        )
                      ],
                    ),
                    childCount: 1,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 12),
            child: StyledButton(
              title: 'search'.i18n(),
              onButtonPressed: () => onSearchPressed(context),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getChildren(BuildContext context, Orientation orientation) {
    var verticalDivider = SizedBox(
      width: 40,
      height: 150,
      child: VerticalDivider(
        thickness: 2,
        color: AppTheme.secondaryColor,
        indent: 35,
        endIndent: 10,
      ),
    );

    var horizontalDivider = Divider(
      thickness: 2,
      color: AppTheme.secondaryColor,
      indent: 10,
      endIndent: 10,
    );

    SeasonViewModel seasonVM =
        Provider.of<SeasonViewModel>(context, listen: false);
    DrinkTypeViewModel drinkTypeVM =
        Provider.of<DrinkTypeViewModel>(context, listen: false);

    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('season'.i18n()),
          ...seasonVM.seasonList!.map((e) => Row(
                children: [
                  Checkbox(
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: filteredSeason.contains(e),
                      onChanged: (val) {
                        if (val!) {
                          setState(() {
                            filteredSeason.add(e);
                          });
                        } else {
                          setState(() {
                            filteredSeason.remove(e);
                          });
                        }
                      }),
                  Text(
                    e.name,
                    style: AppTheme.themeData.textTheme.bodySmall!
                        .copyWith(fontSize: 20),
                  ),
                ],
              )),
        ],
      ),
      orientation == Orientation.landscape
          ? verticalDivider
          : horizontalDivider,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('alcoholic'.i18n()),
          Row(
            children: [
              Checkbox(
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: alcoholicYesFiltered,
                  onChanged: (val) {
                    setState(() {
                      alcoholicYesFiltered = val!;
                    });
                  }),
              Text(
                'yes'.i18n(),
                style: AppTheme.themeData.textTheme.bodySmall!
                    .copyWith(fontSize: 20),
              ),
            ],
          ),
          Row(
            children: [
              Checkbox(
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: alcobolicNoFiltered,
                  onChanged: (val) {
                    setState(() {
                      alcobolicNoFiltered = val!;
                    });
                  }),
              Text(
                'no'.i18n(),
                style: AppTheme.themeData.textTheme.bodySmall!
                    .copyWith(fontSize: 20),
              ),
            ],
          ),
        ],
      ),
      orientation == Orientation.landscape
          ? verticalDivider
          : horizontalDivider,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('drink_type'.i18n()),
          ...drinkTypeVM.drinkTypeList!.map((e) => Row(
                children: [
                  Checkbox(
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: filteredDrinkType.contains(e),
                      onChanged: (val) {
                        if (val!) {
                          setState(() {
                            filteredDrinkType.add(e);
                          });
                        } else {
                          setState(() {
                            filteredDrinkType.remove(e);
                          });
                        }
                      }),
                  Text(
                    e.name,
                    style: AppTheme.themeData.textTheme.bodySmall!
                        .copyWith(fontSize: 20),
                  ),
                ],
              )),
        ],
      )
    ];
  }

  Widget getLoadedData() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            '${'search'.i18n()}...',
            style: AppTheme.themeData.textTheme.titleSmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: StyledTextfield(
            controller: searchTextController,
            suffixIcon: CommunityMaterialIcons.magnify,
            onSuffixIconPressed: () {},
          ),
        ),
        const SizedBox(height: 15),
        Text(
          'and'.i18n(),
          style: AppTheme.themeData.textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
        Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.styledTextFieldColor.withOpacity(0.6),
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            border: Border.all(
              width: 3,
              color: Colors.white,
            ),
          ),
          child: ExpansionTile(
              key: expansionTileKey,
              shape: const Border(),
              leading: const Icon(
                CommunityMaterialIcons.filter,
                size: 30,
              ),
              title: Text(
                'filter'.i18n(),
                style: const TextStyle(fontSize: 30),
              ),
              childrenPadding: const EdgeInsets.only(left: 10),
              children: [
                MediaQuery.of(context).orientation == Orientation.landscape
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: getChildren(
                            context, MediaQuery.of(context).orientation),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: getChildren(
                            context, MediaQuery.of(context).orientation),
                      )
              ]),
        ),
        TextButton(
          onPressed: () => _onClearSearchPressed(),
          child: Text('Clear Search',
              style: AppTheme.themeData.textTheme.headlineMedium!.copyWith(
                color: Colors.white,
              )),
        ),
      ],
    );
  }
}
