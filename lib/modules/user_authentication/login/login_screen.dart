import 'package:evently_app/modules/user_authentication/register/register_screen.dart';
import 'package:evently_app/shared/component/buttons_component/app_button_component.dart';
import 'package:evently_app/shared/component/buttons_component/row_button_component.dart';
import 'package:evently_app/shared/component/buttons_component/text_button_component.dart';
import 'package:evently_app/shared/component/navigator_component/navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/app_provider/language_provider.dart';
import '../../../shared/app_provider/login_provider.dart';
import '../../../shared/component/buttons_component/switch_component.dart';
import '../../../shared/component/dvider/dvider.dart';
import '../../../shared/component/text_form_field/custom_text_form_field.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var appLocalizations = AppLocalizations.of(context)!;
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: Builder(
        builder: (context) {
          var loginProvider = context.watch<LoginProvider>();
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.02,
              ),
              child: SafeArea(
                child: Form(
                  key: loginProvider.formKey,
                  child: Column(
                    children: [
                      Image.asset(AppAssets.eventlyLogo2),
                      SizedBox(height: size.height * 0.02),
                      CustomTextFormField(
                        controller: loginProvider.emailController,
                        hintText: appLocalizations.email,
                        prefixIcon: Icons.email_rounded,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return appLocalizations.pleaseEnterYourEmail;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      CustomTextFormField(
                        controller: loginProvider.passwordController,
                        hintText: appLocalizations.password,
                        prefixIcon: Icons.lock_rounded,
                        onIconTap: () {
                          loginProvider.togglePasswordVisibility();
                        },
                        suffixIcon: loginProvider.isPasswordHidden
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        obscureText: loginProvider.isPasswordHidden,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return appLocalizations.pleaseEnterYourPassword;
                          }
                          return null;
                        },
                      ),
                      TextButtonComponent(
                        text: appLocalizations.forgotPassword,
                        onPressed: () {},
                      ),
                      AppButtonComponent(
                        buttonHeightPadding: 0.02,
                        buttonWidthPadding: 0.02,
                        centerText: true,
                        onButtonTap: () {
                          loginProvider.loginWithEmail();
                        },
                        buttonColor: AppColors.primaryColor,
                        buttonName: appLocalizations.login,
                      ),
                      AuthRedirectRow(
                          titleText: appLocalizations.dontHaveAnAccount,
                          actionText: appLocalizations.createAccount,
                          onPressed: (){ NavigationService.instance.push(RegisterScreen());}),
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
                        initialIndex:
                        appLanguageProvider.appLanguage == "en" ? 0 : 1,
                        listOfIcons: [
                          Image.asset("assets/images/en.png"),
                          Image.asset("assets/images/ar.png"),
                        ],
                        onTapIndex: (index) {
                          appLanguageProvider.changeAppLanguage(
                              index == 0 ? "en" : "ar");
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}