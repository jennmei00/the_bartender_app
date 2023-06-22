import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:the_bartender_app/data/api/api_response.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/enum.dart';
import 'package:the_bartender_app/utils/route_util.dart';
import 'package:the_bartender_app/utils/string_util.dart';
import 'package:the_bartender_app/viewmodels/creation_view_model.dart';
import 'package:the_bartender_app/widgets/recipeCreate/recipeCreateEdit/information_edit_expansion_tile.dart';
import 'package:the_bartender_app/widgets/recipeCreate/recipeCreateEdit/ingredient_edit_expansion_tile.dart';
import 'package:the_bartender_app/widgets/recipeCreate/recipeCreateEdit/instruction_edit_expansion_tile.dart';
import 'package:the_bartender_app/widgets/styled_button.dart';
import 'package:the_bartender_app/widgets/styled_drawer.dart';
import 'package:the_bartender_app/widgets/styled_error.dart';

class YourCreationDetailView extends StatefulWidget {
  final DrinkTypeEnum drinkTypeEnum;
  final String name;

  const YourCreationDetailView(
      {super.key, required this.drinkTypeEnum, required this.name});

  @override
  State<YourCreationDetailView> createState() => _YourCreationDetailViewState();
}

class _YourCreationDetailViewState extends State<YourCreationDetailView> {
  final TextEditingController searchTextController = TextEditingController();
  double starRatingValue = 0;

  onSavePressed(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AppTheme.woodBackgroundImage,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
        fit: BoxFit.cover,
      )),
      child: BackdropFilter(
        filter: AppTheme.backgroundImageFilter,
        child: Scaffold(
          drawer: const StyledDrawer(
            drawerView: DrawerView.recipe,
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
                          icon: const Icon(CommunityMaterialIcons.close),
                          onPressed: () => AutoRouter.of(context).pop(),
                        );
                      }),
                      actions: [
                        IconButton(
                          onPressed: Provider.of<CreationViewModel>(context)
                                      .response
                                      .status !=
                                  Status.completed
                              ? null
                              : onSavePressed(context),
                          icon: const Icon(
                            CommunityMaterialIcons.content_save,
                          ),
                          color: Colors.white,
                          disabledColor: Colors.grey,
                        )
                      ],
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Column(
                          children: [
                            Text(
                              widget.name,
                              style: AppTheme.themeData.textTheme.titleLarge,
                              textAlign: TextAlign.center,
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
                                      capitalizeFirstLetter(
                                          widget.drinkTypeEnum.name),
                                      style: AppTheme
                                          .themeData.textTheme.titleMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'recipe_detail_text'.i18n(),
                              style: AppTheme.themeData.textTheme.displayMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Consumer<CreationViewModel>(
                                builder: (context, value, child) =>
                                    getCreationEditWidgets(value)),
                            const SizedBox(height: 30),
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
                  title: 'save'.i18n(),
                  onButtonPressed:
                      Provider.of<CreationViewModel>(context).response.status !=
                              Status.completed
                          ? null
                          : () => onSavePressed(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCreationEditWidgets(CreationViewModel value) {
    if (value.response.status == Status.initial ||
        value.response.status == Status.loading) {}
    switch (value.response.status) {
      case Status.initial || Status.loading:
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      case Status.completed:
        return Column(
          children: [
            InformationEditExpansionTile(),
            const Divider(),
            const IngredientEditExpansionTile(),
            const Divider(),
            const InstructionEditExpansionTile(),
            RatingStars(
              starBuilder: (index, color) {
                return color == Colors.transparent
                    ? const Icon(CommunityMaterialIcons.star_outline)
                    : const Icon(CommunityMaterialIcons.star);
              },
              value: starRatingValue,
              starColor: Colors.white,
              starOffColor: Colors.transparent,
              valueLabelVisibility: false,
              starSize: 25,
              onValueChanged: (value) =>
                  setState(() => starRatingValue = value),
            ),
          ],
        );

      case Status.error:
        return StyledError(message: '${value.response.message}');
    }
  }
}
