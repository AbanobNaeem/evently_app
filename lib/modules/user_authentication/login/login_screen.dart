import 'package:evently_app/shared/component/buttons_component/app_button_component.dart';
import 'package:evently_app/shared/component/buttons_component/row_button_component.dart';
import 'package:evently_app/shared/component/buttons_component/text_button_component.dart';
import 'package:evently_app/shared/component/navigator_component/navigators.dart';
import 'package:evently_app/utils/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/component/buttons_component/switch_component.dart';
import '../../../shared/component/dvider/dvider.dart';
import '../../../shared/component/text_form_field/custom_text_form_field.dart';
import '../../../shared/lang_theme_provider/theme_provider.dart';
import '../../../shared/providers/login_provider/login_provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var appLocalizations = AppLocalizations.of(context)!;
    AppThemeProvider appThemeProvider = Provider.of<AppThemeProvider>(context);
    return Consumer<LoginProvider>(
      builder: (context, provider, child) =>  Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
            vertical: size.height * 0.02,
          ),
          child: SafeArea(
            child: Form(
              key: provider.formKey,
              child: Column(
                children: [
                  Image.asset(AppAssets.eventlyLogo2),
                  SizedBox(height: size.height * 0.02),
                  CustomTextFormField(
                    controller: provider.emailController,
                    hintText: appLocalizations.email,
                    prefixIcon: Icons.email_rounded,
                    keyboardType: TextInputType.emailAddress,
                    validator:(value)=> provider.validateEmail(value,appLocalizations),
                  ),
                  SizedBox(height: size.height * 0.02),
                  CustomTextFormField(
                    controller: provider.passwordController,
                    hintText: appLocalizations.password,
                    prefixIcon: Icons.lock_rounded,
                    onIconTap: () {provider.togglePasswordVisibility();},
                    suffixIcon: provider.isPasswordHidden
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    obscureText: provider.isPasswordHidden,
                    validator:(value) =>  provider.validatePassword(value, appLocalizations),
                  ),
                  TextButtonComponent(
                    text: appLocalizations.forgotPassword,
                    onPressed: () {
                      NavigationService.instance.pushNamed(AppRouts.forgetPasswordScreenRoutName);
                    },
                  ),
                  AppButtonComponent(
                    buttonHeightPadding: 0.02,
                    buttonWidthPadding: 0.02,
                    centerText: true,
                    onButtonTap: () {
                      provider.loginWithEmailAndNavigate();
                    },
                    buttonColor: AppColors.primaryColor,
                    buttonName: appLocalizations.login,
                  ),
                  AuthRedirectRow(
                      titleText: appLocalizations.dontHaveAnAccount,
                      actionText: appLocalizations.createAccount,
                      onPressed: (){ NavigationService.instance.pushNamed(AppRouts.registerScreenRoutName);}),
                  OrDivider(
                    text: appLocalizations.or,
                  ),
                  AppButtonComponent(
                    buttonHeightPadding: 0.02,
                    onButtonTap: () {},
                    buttonColor: AppColors.primaryColor,
                    buttonName: appLocalizations.loginWithGoogle,
                    isOutlined: true,
                    centerText: true,
                    leading: Image.asset(AppAssets.googleLogo),
                  ),
                  SwitchComponent(
                    initialIndex: appThemeProvider.appLanguage == "en" ? 0 : 1,
                    listOfIcons: [
                      Image.asset(AppAssets.enIcon),
                      Image.asset(AppAssets.arIcon),
                    ],
                    onTapIndex: (index) {
                      appThemeProvider.changeAppLanguage(
                          index == 0 ? "en" : "ar");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}