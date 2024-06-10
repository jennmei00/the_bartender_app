import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:the_bartender_app/data/api/api_response.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/globals.dart';
import 'package:the_bartender_app/utils/route_util.dart';
import 'package:the_bartender_app/utils/routes/router.gr.dart';
import 'package:the_bartender_app/viewmodels/user_view_model.dart';
import 'package:the_bartender_app/widgets/custom_scaffold.dart';
import 'package:the_bartender_app/widgets/welcome/login_widget.dart';
import 'package:the_bartender_app/widgets/welcome/welcome_widget.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  bool _loginPressed = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validator(String value) {
    if (value == '') {
      return '';
    } else {
      return null;
    }
  }

  void loginPressed() {
    if (formKey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (context) =>
              const Center(child: CircularProgressIndicator.adaptive()),
          barrierDismissible: false);
      Provider.of<UserViewModel>(context, listen: false)
          .fetchData(usernameController.text, passwordController.text)
          .then((value) async {
        ApiResponse<dynamic> response =
            Provider.of<UserViewModel>(context, listen: false).response;
        if (response.status == Status.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${response.message}')),
          );
        } else if (response.status == Status.completed) {
          if (value == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('wrong_login'.i18n())),
            );
          } else {
            await sharedPreferences!.setBool('loginActive', true);
            await sharedPreferences!.setString('UserID', value.id);
            await sharedPreferences!.setBool('isFirstStart', false);

            if (context.mounted) {
              AutoRouter.of(context).pushAndPopUntil(const HomeViewRoute(),
                  predicate: (route) => false);
            }
          }
        }

        if (context.mounted) AutoRouter.of(context).pop();
      });
    }
  }

  void cancelPressed() {
    setState(() {
      _loginPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      image: AppTheme.backgroundImage,
      appBar: false,
      drawerView: DrawerView.contact,
      body: OrientationBuilder(builder: (context, orientation) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/logo.svg',
                        height: 130,
                      ),
                      Text(
                        'the_bartender'.i18n(),
                        style: AppTheme.themeData.textTheme.headlineSmall,
                      )
                    ],
                  ),
                ),
                Text(
                  'welcome'.i18n(),
                  style: AppTheme.themeData.textTheme.headlineSmall!
                      .copyWith(fontSize: 80),
                ),
                const SizedBox(height: 40),
                !_loginPressed
                    ? WelcomeWidget(
                        registerPressed: () {
                          //TODOLink to Website for registration
                        },
                        loginPressed: () {
                          setState(() {
                            _loginPressed = true;
                          });
                        },
                        withoutPressed: () async {
                          sharedPreferences!.setBool('isFirstStart', false);
                          sharedPreferences!
                              .setBool('loginAcitve', false)
                              .then((value) {
                            AutoRouter.of(context).pushAndPopUntil(
                                const HomeViewRoute(),
                                predicate: (route) => false);
                          });
                        },
                      )
                    : LoginWidget(
                        usernameController: usernameController,
                        passwordController: passwordController,
                        loginPressed: loginPressed,
                        validator: validator,
                        formKey: formKey,
                        cancelPressed: cancelPressed,
                      ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
