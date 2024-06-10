import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/route_util.dart';
import 'package:the_bartender_app/widgets/custom_scaffold.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      image: AppTheme.backgroundImage,
      appBar: true,
      title: Text('contact'.i18n().toUpperCase()),
      drawerView: DrawerView.contact,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              Text(
                'contact'.i18n(),
                style: AppTheme.themeData.textTheme.titleLarge!
                    .copyWith(decoration: TextDecoration.none),
              ),
              const Divider(),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: AppTheme.recipeCardBoxDecoration,
                child: Text(
                  'contact_site_text'.i18n(),
                  style: AppTheme.themeData.textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30.0),
          Column(
            children: [
              Text(
                'website_version'.i18n(),
                style: AppTheme.themeData.textTheme.titleLarge!
                    .copyWith(decoration: TextDecoration.none),
              ),
              const Divider(),
              const SizedBox(height: 20.0),
              Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: AppTheme.recipeCardBoxDecoration,
                  child: Column(
                    children: [
                      Text(
                        'website_version_text'.i18n(),
                        softWrap: true,
                        style: AppTheme.themeData.textTheme.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10.0),
                      const Icon(
                        CommunityMaterialIcons.web,
                        size: 40,
                      )
                    ],
                  )),
            ],
          ),
          const SizedBox(height: 30.0),
          Column(
            children: [
              Text(
                'contact_us'.i18n(),
                style: AppTheme.themeData.textTheme.titleLarge!
                    .copyWith(decoration: TextDecoration.none),
              ),
              const Divider(),
              const SizedBox(height: 20.0),
              Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: AppTheme.recipeCardBoxDecoration,
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(CommunityMaterialIcons.google_play,
                              size: 30),
                          const SizedBox(width: 30),
                          Text(
                            'jstudios@gmail.com',
                            style: AppTheme.themeData.textTheme.displayMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(CommunityMaterialIcons.web, size: 30),
                          const SizedBox(width: 30),
                          Text(
                            'nikmigg@gmail.com',
                            style: AppTheme.themeData.textTheme.displayMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
