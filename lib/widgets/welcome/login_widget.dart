import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/widgets/styled_button.dart';
import 'package:the_bartender_app/widgets/styled_textfield.dart';

class LoginWidget extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final Function loginPressed;
  final Function cancelPressed;
  final Function validator;
  final GlobalKey<FormState> formKey;

  const LoginWidget(
      {super.key,
      required this.usernameController,
      required this.passwordController,
      required this.loginPressed,
      required this.validator,
      required this.formKey,
      required this.cancelPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Form(
        key: formKey,
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'username'.i18n(),
              style: AppTheme.themeData.textTheme.bodySmall!.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          StyledTextfield(
            controller: usernameController,
            validator: validator,
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'password'.i18n(),
              style: AppTheme.themeData.textTheme.bodySmall!.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          StyledTextfield(
            controller: passwordController,
            validator: validator,
            obscureText: true,
          ),
          const SizedBox(height: 30),
          SizedBox(
            child: StyledButton(
              title: 'login'.i18n(),
              onButtonPressed: () => loginPressed(),
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          TextButton(
              onPressed: () => cancelPressed(),
              child: Text(
                'cancel'.i18n(),
                style: AppTheme.themeData.textTheme.headlineMedium!
                    .copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              )),
        ]),
      ),
    );
  }
}
