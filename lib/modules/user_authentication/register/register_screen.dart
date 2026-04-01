import 'package:evently_app/shared/component/buttons_component/row_button_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/app_provider/language_provider.dart';
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
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
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
          child: Column(
            children: [
              Image.asset(AppAssets.eventlyLogo2),
              SizedBox(height: size.height * 0.02),
              CustomTextFormField(
                controller: TextEditingController(),
                hintText: appLocalizations.name,
                prefixIcon: Icons.person,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return appLocalizations.pleaseEnterYourName;
                  }
                  return null;
                },
              ),
              SizedBox(height: size.height * 0.015),
              CustomTextFormField(
                controller: TextEditingController(),
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
              SizedBox(height: size.height * 0.015),
              CustomTextFormField(
                controller:TextEditingController(),
                hintText: appLocalizations.password,
                prefixIcon: Icons.lock_rounded,
                onIconTap: () {
                },
                suffixIcon: true
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                obscureText:true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return appLocalizations.pleaseEnterYourPassword;
                  }
                  return null;
                },
              ),
              SizedBox(height: size.height * 0.015),
              CustomTextFormField(
                controller:TextEditingController(),
                hintText: appLocalizations.rePassword,
                prefixIcon: Icons.lock_rounded,
                onIconTap: () {
                },
                suffixIcon: true
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                obscureText:true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return appLocalizations.pleaseEnterYourRePassword;
                  }
                  return null;
                },
              ),
              AppButtonComponent(
                buttonHeightPadding: 0.02,
                buttonWidthPadding: 0.02,
                centerText: true,
                onButtonTap: () {
                },
                buttonColor: AppColors.primaryColor,
                buttonName: appLocalizations.login,
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
    );
  }
}
