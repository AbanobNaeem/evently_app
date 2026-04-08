import 'package:evently_app/shared/app_provider/auth_provider/register_provider.dart';
import 'package:evently_app/shared/app_provider/lang_theme_provider/theme_provider.dart';
import 'package:evently_app/shared/component/buttons_component/row_button_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/component/buttons_component/app_button_component.dart';
import '../../../shared/component/buttons_component/switch_component.dart';
import '../../../shared/component/navigator_component/navigators.dart';
import '../../../shared/component/text_form_field/custom_text_form_field.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size  = MediaQuery.sizeOf(context);
    var appLocalizations = AppLocalizations.of(context)!;
    AppThemeProvider appThemeProvider = Provider.of<AppThemeProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => RegisterProvider(),
      child: Builder(
        builder: (context) {
          var registerProvider = Provider.of<RegisterProvider>(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(appLocalizations.register,
                style: AppStyles.bold20Primary,),
              centerTitle: true
            ),
            body: Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.02,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: registerProvider.formKey,
                  child: Column(
                    children: [
                      Image.asset(AppAssets.eventlyLogo2),
                      SizedBox(height: size.height * 0.02),
                      CustomTextFormField(
                        controller: registerProvider.nameController,
                        hintText: appLocalizations.name,
                        prefixIcon: Icons.person,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return appLocalizations.pleaseEnterYourName;
                          }

                          if (value.trim().length < 3) {
                            return appLocalizations.nameLength;
                          }

                          if (!RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$')
                              .hasMatch(value.trim())) {
                            return appLocalizations.nameLetter;
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.015),
                      CustomTextFormField(
                        controller: registerProvider.emailController,
                        hintText: appLocalizations.email,
                        prefixIcon: Icons.email_rounded,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return appLocalizations.pleaseEnterYourEmail;
                          }

                          if (!RegExp(
                            r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value.trim())) {
                            return appLocalizations.pleaseEnterValidEmail;
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.015),
                      CustomTextFormField(
                        controller:registerProvider.passwordController,
                        hintText: appLocalizations.password,
                        prefixIcon: Icons.lock_rounded,
                        onIconTap: () {
                          registerProvider.togglePasswordVisibility();
                        },
                        suffixIcon: registerProvider.isPasswordHidden
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        obscureText: registerProvider.isPasswordHidden,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return appLocalizations.pleaseEnterYourPassword;
                          }

                          if (value.length < 8) {
                            return appLocalizations.passwordLength;
                          }

                          if (!RegExp(r'[A-Z]').hasMatch(value)) {
                            return appLocalizations.upperCaseLetter;
                          }

                          if (!RegExp(r'[a-z]').hasMatch(value)) {
                            return appLocalizations.lowerCaseLetter;
                          }

                          if (!RegExp(r'[0-9]').hasMatch(value)) {
                            return appLocalizations.number;
                          }

                          if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                              .hasMatch(value)) {
                            return appLocalizations.specialCharacter;
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.015),
                      CustomTextFormField(
                        controller: registerProvider.confirmPasswordController,
                        hintText: appLocalizations.rePassword,
                        prefixIcon: Icons.lock_rounded,
                        onIconTap: () {
                          registerProvider.toggleConfirmPasswordVisibility();
                        },
                        suffixIcon: registerProvider.isConfirmPasswordHidden
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        obscureText:registerProvider.isConfirmPasswordHidden,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return appLocalizations.pleaseEnterYourRePassword;
                          }

                          if (value != registerProvider.passwordController.text) {
                            return appLocalizations.passwordMatch;
                          }

                          return null;
                        },
                      ),
                      AppButtonComponent(
                        buttonHeightPadding: 0.02,
                        buttonWidthPadding: 0.02,
                        centerText: true,
                        onButtonTap: () {
                            registerProvider.createNewAccount();

                        },
                        buttonColor: AppColors.primaryColor,
                        buttonName: appLocalizations.createAccount,
                      ),
                      AuthRedirectRow(
                        titleText: appLocalizations.alreadyHaveAnAccount,
                        actionText: appLocalizations.login,
                        onPressed: () {
                          NavigationService.instance.pop();
                        },
                      ),
                      SwitchComponent(
                        initialIndex:
                       appThemeProvider.appLanguage == "en" ? 0 : 1,
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
          );
        }
      ),
    );
  }
}
