import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/enums.dart';
import 'package:the_bartender_app/utils/routes/router.gr.dart';
import 'package:the_bartender_app/widgets/styled_button.dart';
import 'package:the_bartender_app/widgets/styled_drawer.dart';
import 'package:the_bartender_app/widgets/styled_textfield.dart';

class YourCreationView extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  YourCreationView({super.key});

  void onCreatePressed(BuildContext context) {
    AutoRouter.of(context).push(YourCreationDetailViewRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
                        (context, index) =>
                            OrientationBuilder(builder: (context, orientation) {
                          return Column(
                            children: [
                              const SizedBox(height: 20),
                              SvgPicture.asset(
                                'assets/svg/neon_create.svg',
                                width: MediaQuery.of(context).size.width * 0.85,
                              ),
                              Container(
                                padding: const EdgeInsets.all(25),
                                child: Text(
                                  'your_creation_text'.i18n(),
                                  style:
                                      AppTheme.themeData.textTheme.titleSmall,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 400),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Opacity(
                                          opacity: 0.6,
                                          child: Stack(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                height: 150,
                                                width: 100,
                                                child: SvgPicture.asset(
                                                  'assets/svg/cocktail.svg',
                                                  height: 200,
                                                ),
                                              ),
                                              Container(
                                                height: 160,
                                                width: 100,
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Transform.rotate(
                                                  angle: -0.60,
                                                  child: Text(
                                                    'Shot',
                                                    style: AppTheme.themeData
                                                        .textTheme.titleMedium!
                                                        .copyWith(fontSize: 25),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            CommunityMaterialIcons.chevron_left,
                                            color: AppTheme
                                                .themeData.colorScheme.primary,
                                          ),
                                          iconSize: 80,
                                        ),
                                      ],
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: 200,
                                          width: 150,
                                          child: SvgPicture.asset(
                                            'assets/svg/cocktail.svg',
                                            height: 200,
                                          ),
                                        ),
                                        Container(
                                          height: 210,
                                          width: 150,
                                          alignment: Alignment.bottomRight,
                                          child: Transform.rotate(
                                            angle: -0.60,
                                            child: Text(
                                              'Longdrink',
                                              style: AppTheme.themeData
                                                  .textTheme.titleMedium,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Opacity(
                                          opacity: 0.6,
                                          child: Stack(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                height: 150,
                                                width: 100,
                                                child: SvgPicture.asset(
                                                  'assets/svg/cocktail.svg',
                                                  height: 200,
                                                ),
                                              ),
                                              Container(
                                                height: 160,
                                                width: 100,
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Transform.rotate(
                                                  angle: -0.60,
                                                  child: Text(
                                                    'Martini',
                                                    style: AppTheme.themeData
                                                        .textTheme.titleMedium!
                                                        .copyWith(fontSize: 25),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            CommunityMaterialIcons
                                                .chevron_right,
                                            color: AppTheme
                                                .themeData.colorScheme.primary,
                                          ),
                                          iconSize: 80,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
                                padding: const EdgeInsets.only(left: 20.0, right: 20),
                                child: StyledTextfield(
                                  controller: nameController,
                                ),
                              ),
                              const SizedBox(height: 15),
                            ],
                          );
                        }),
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
