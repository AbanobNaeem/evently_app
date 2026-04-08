import 'package:evently_app/shared/app_provider/auth_provider/forget_password_provider.dart';
import 'package:evently_app/shared/component/navigator_component/navigators.dart';
import 'package:evently_app/shared/component/text_form_field/custom_text_form_field.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../shared/component/buttons_component/app_button_component.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size ;
    var appLocalizations = AppLocalizations.of(context)!;
    return Consumer<ForgetPasswordProvider>(
      builder: (BuildContext context, ForgetPasswordProvider provider, Widget? child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(appLocalizations.forgotPassword,
              style: AppStyles.bold20Primary,
            ),
            centerTitle: true,
          ),
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
                    Image.asset(AppAssets.forgetPasswordImage),
                    SizedBox(height: size.height * 0.02),
                    CustomTextFormField(
                      controller: provider.emailController,
                      hintText: appLocalizations.email,
                      prefixIcon: Icons.email_rounded,
                      keyboardType: TextInputType.emailAddress,
                      validator:(value)=> provider.validateEmail(value,appLocalizations),
                    ),
                    SizedBox(height: size.height* 0.02,),
                    provider.isLoading ? CircularProgressIndicator():
                    AppButtonComponent(
                      buttonHeightPadding: 0.0,
                      buttonWidthPadding: 0.0,
                      centerText: true,
                      onButtonTap: () {
                        provider.resetPassword();
                        NavigationService.instance.pop();
                      },
                      buttonColor: AppColors.primaryColor,
                      buttonName: appLocalizations.resetPassword,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
