import 'package:auto_route/auto_route.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:the_bartender_app/data/api/api_response.dart';
import 'package:the_bartender_app/models/drink_type.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/route_util.dart';
import 'package:the_bartender_app/viewmodels/season_view_model.dart';
import 'package:the_bartender_app/viewmodels/tool_view_model.dart';
import 'package:the_bartender_app/viewmodels/unit_view_model.dart';
import 'package:the_bartender_app/widgets/cocktail_image_widget.dart';
import 'package:the_bartender_app/widgets/custom_scaffold.dart';
import 'package:the_bartender_app/widgets/yourCreation/recipeCreateEdit/information_edit_expansion_tile.dart';
import 'package:the_bartender_app/widgets/yourCreation/recipeCreateEdit/ingredient_edit_expansion_tile.dart';
import 'package:the_bartender_app/widgets/yourCreation/recipeCreateEdit/instruction_edit_expansion_tile.dart';
import 'package:the_bartender_app/widgets/styled_button.dart';
import 'package:the_bartender_app/widgets/styled_error.dart';

class YourCreationDetailView extends StatefulWidget {
  final DrinkType drinkType;
  final String name;

  const YourCreationDetailView(
      {super.key, required this.drinkType, required this.name});

  @override
  State<YourCreationDetailView> createState() => _YourCreationDetailViewState();
}

class _YourCreationDetailViewState extends State<YourCreationDetailView> {
  final TextEditingController searchTextController = TextEditingController();
  double starRatingValue = 0;

  onSavePressed(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      image: AppTheme.woodBackgroundImage,
      drawerView: DrawerView.recipes,
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
                      onPressed: Provider.of<SeasonViewModel>(context)
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
                        CocktailImageWidget(
                            name: widget.name, drinkType: widget.drinkType),
                        Text(
                          'recipe_detail_text'.i18n(),
                          style: AppTheme.themeData.textTheme.displayMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Consumer3<SeasonViewModel, ToolViewModel,
                                UnitViewModel>(
                            builder:
                                (context, seasonVM, toolVM, unitVM, child) =>
                                    getCreationEditWidgets(
                                        seasonVM, toolVM, unitVM)),
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
                  Provider.of<SeasonViewModel>(context).response.status !=
                              Status.completed ||
                          Provider.of<ToolViewModel>(context).response.status !=
                              Status.completed
                      ? null
                      : () => onSavePressed(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget getCreationEditWidgets(
      SeasonViewModel seasonVM, ToolViewModel toolVM, UnitViewModel unitVM) {
    if (seasonVM.response.status == Status.error ||
        toolVM.response.status == Status.error ||
        unitVM.response.status == Status.error) {
      return StyledError(
          message:
              '${seasonVM.response.status == Status.error ? seasonVM.response.message : toolVM.response.status == Status.error ? toolVM.response.message : unitVM.response.message}');
    } else if (seasonVM.response.status == Status.completed &&
        toolVM.response.status == Status.completed &&
        unitVM.response.status == Status.completed) {
      return Column(
        children: [
          const InformationEditExpansionTile(),
          const Divider(),
          const IngredientEditExpansionTile(),
          const Divider(),
          InstructionEditExpansionTile(),
        ],
      );
    } else {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
  }
}
