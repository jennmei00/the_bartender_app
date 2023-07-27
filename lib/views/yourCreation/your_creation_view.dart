import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:the_bartender_app/data/api/api_response.dart';
import 'package:the_bartender_app/models/drink_type.dart';
import 'package:the_bartender_app/models/season.dart';
import 'package:the_bartender_app/models/tool.dart';
import 'package:the_bartender_app/models/unit.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/globals.dart';
import 'package:the_bartender_app/utils/route_util.dart';
import 'package:the_bartender_app/utils/routes/router.gr.dart';
import 'package:the_bartender_app/viewmodels/drink_type_view_model.dart';
import 'package:the_bartender_app/viewmodels/season_view_model.dart';
import 'package:the_bartender_app/viewmodels/tool_view_model.dart';
import 'package:the_bartender_app/viewmodels/unit_view_model.dart';
import 'package:the_bartender_app/widgets/custom_scaffold.dart';
import 'package:the_bartender_app/widgets/yourCreation/animated_carousel.dart';
import 'package:the_bartender_app/widgets/styled_button.dart';
import 'package:the_bartender_app/widgets/styled_error.dart';
import 'package:the_bartender_app/widgets/styled_textfield.dart';

class YourCreationView extends StatefulWidget {
  const YourCreationView({super.key});

  @override
  State<YourCreationView> createState() => _YourCreationViewState();
}

class _YourCreationViewState extends State<YourCreationView> {
  final TextEditingController nameController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int _carouselIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  void onCreatePressed(BuildContext context) {
    if (formKey.currentState!.validate()) {
      DrinkType drinkType =
          Provider.of<DrinkTypeViewModel>(context, listen: false)
              .drinkTypeList![_carouselIndex];
      String name = nameController.text;

      List<Season>? seasonList =
          Provider.of<SeasonViewModel>(context, listen: false).seasonList;
      if (seasonList == null || seasonList.isEmpty) {
        Provider.of<SeasonViewModel>(context, listen: false).fetchData();
      }

      List<Tool>? toolList =
          Provider.of<ToolViewModel>(context, listen: false).toolList;
      if (toolList == null || toolList.isEmpty) {
        Provider.of<ToolViewModel>(context, listen: false).fetchData();
      }

      List<Unit>? unitList =
          Provider.of<UnitViewModel>(context, listen: false).unitList;
      if (unitList == null || unitList.isEmpty) {
        Provider.of<UnitViewModel>(context, listen: false).fetchData();
      }

      AutoRouter.of(context)
          .push(YourCreationDetailViewRoute(drinkType: drinkType, name: name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      image: AppTheme.backgroundImage,
      drawerView: DrawerView.yourCreation,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              key: GlobalKey(),
              slivers: [
                SliverAppBar(
                  title: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 0),
                    child: Text(
                      'your_creation'.i18n().toUpperCase(),
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
                    (context, index) {
                      return Column(
                        children: [
                          const SizedBox(height: 20),
                          SvgPicture.asset(
                            'assets/svg/neon_create.svg',
                            width: MediaQuery.of(context).size.width * 0.50,
                          ),
                          Container(
                            padding: const EdgeInsets.all(25),
                            child: Text(
                              'your_creation_text'.i18n(),
                              style: AppTheme.themeData.textTheme.titleSmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 10),
                          sharedPreferences!.getBool('loginActive') ?? false
                              ? Consumer<DrinkTypeViewModel>(
                                  builder: (context, vm, child) {
                                  switch (vm.response.status) {
                                    case Status.loading || Status.initial:
                                      return const Center(
                                          child: CircularProgressIndicator
                                              .adaptive());
                                    case Status.completed:
                                      _carouselIndex =
                                          (Provider.of<DrinkTypeViewModel>(
                                                          context,
                                                          listen: false)
                                                      .drinkTypeList!
                                                      .length /
                                                  2)
                                              .floor();

                                      return Column(
                                        children: [
                                          AnimatedCarousel(
                                            onCarouselIndexChanged: (value) =>
                                                _carouselIndex = value,
                                          ),
                                          const SizedBox(height: 20),
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Text(
                                              'name'.i18n(),
                                              style: AppTheme.themeData
                                                  .textTheme.bodySmall!
                                                  .copyWith(
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0, right: 20),
                                            child: Form(
                                              key: formKey,
                                              child: StyledTextfield(
                                                controller: nameController,
                                                validator: (String value) {
                                                  if (value.isEmpty ||
                                                      value == '') {
                                                    return 'mandatory_field'
                                                        .i18n();
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      );

                                    case Status.error:
                                      return StyledError(
                                          message: '${vm.response.message}');
                                  }
                                })
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 50),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          CommunityMaterialIcons
                                              .emoticon_confused_outline,
                                          size: 60,
                                        ),
                                        const SizedBox(width: 20),
                                        Text(
                                          'Creation Not\nAllowed'.i18n(),
                                          style: AppTheme.themeData.textTheme
                                              .headlineMedium!
                                              .copyWith(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 50),
                                    Text(
                                      'Please Login To Create\nYour Own Recipe!'
                                          .i18n(),
                                      style: AppTheme
                                          .themeData.textTheme.headlineMedium!
                                          .copyWith(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 50),
                                    StyledButton(
                                      title: 'login'.i18n(),
                                      color: Colors.white,
                                      onButtonPressed: () {
                                        sharedPreferences!
                                            .setBool('isFirstStart', true)
                                            .then((value) =>
                                                AutoRouter.of(context)
                                                    .pushAndPopUntil(
                                                  const WelcomeViewRoute(),
                                                  predicate: (route) => false,
                                                ));
                                      },
                                    ),
                                  ],
                                ),
                          const SizedBox(height: 15),
                        ],
                      );
                    },
                    childCount: 1,
                  ),
                ),
              ],
            ),
          ),
          sharedPreferences!.getBool('loginActive') ?? false
              ? Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(bottom: 12),
                  child: StyledButton(
                    title: 'create'.i18n(),
                    onButtonPressed: () => onCreatePressed(context),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
