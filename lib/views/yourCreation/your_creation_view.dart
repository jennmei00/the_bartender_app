import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:the_bartender_app/models/season.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/enum.dart';
import 'package:the_bartender_app/utils/route_util.dart';
import 'package:the_bartender_app/utils/routes/router.gr.dart';
import 'package:the_bartender_app/viewmodels/season_view_model.dart';
import 'package:the_bartender_app/widgets/recipeCreate/animated_carousel.dart';
import 'package:the_bartender_app/widgets/styled_button.dart';
import 'package:the_bartender_app/widgets/styled_drawer.dart';
import 'package:the_bartender_app/widgets/styled_textfield.dart';

class YourCreationView extends StatefulWidget {

  const YourCreationView({super.key});

  @override
  State<YourCreationView> createState() => _YourCreationViewState();
}

class _YourCreationViewState extends State<YourCreationView> {
  final TextEditingController nameController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

   int _carouselIndex = (DrinkTypeEnum.values.length / 2).floor();

  void onCreatePressed(BuildContext context) {
    if (formKey.currentState!.validate()) {
      DrinkTypeEnum drinkTypeEnum =
          DrinkTypeEnum.values[_carouselIndex];
      String name = nameController.text;

      List<Season>? seasonList =
          Provider.of<SeasonViewModel>(context, listen: false).seasonList;
      if (seasonList == null || seasonList.isEmpty) {
        Provider.of<SeasonViewModel>(context, listen: false).fetchSeasonData();
      }
      AutoRouter.of(context).push(YourCreationDetailViewRoute(
          drinkTypeEnum: drinkTypeEnum, name: name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  const BoxDecoration(
          image: DecorationImage(
        image: AppTheme.backgroundImage,
        fit: BoxFit.cover,
      )),
      child: BackdropFilter(
        filter: AppTheme.backgroundImageFilter,
        child: Scaffold(
          drawer: const StyledDrawer(
            drawerView: DrawerView.yourCreation,
          ),
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
                          icon:
                              const Icon(CommunityMaterialIcons.dots_vertical),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        );
                      }),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          var children2 = [
                            const SizedBox(height: 20),
                            SvgPicture.asset(
                              'assets/svg/neon_create.svg',
                              width: MediaQuery.of(context).size.width * 0.85,
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
                            AnimatedCarousel(
                              onCarouselIndexChanged: (value) =>
                                _carouselIndex = value,
                              
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                'name'.i18n(),
                                style: AppTheme.themeData.textTheme.bodySmall!
                                    .copyWith(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 20),
                              child: Form(
                                key: formKey,
                                child: StyledTextfield(
                                  controller: nameController,
                                  validator: (String value) {
                                    if (value.isEmpty || value == '') {
                                      return 'mandatory_field'.i18n();
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                          ];
                          return Column(
                            children: children2,
                          );
                        },
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
                  title: 'create'.i18n(),
                  onButtonPressed: () => onCreatePressed(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
