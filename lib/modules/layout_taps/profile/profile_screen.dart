import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/shared/component/buttons_component/app_button_component.dart';
import 'package:evently_app/shared/component/buttons_component/drop_buttons_component.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/data/local/cash_helper.dart';
import '../../../shared/lang_theme_provider/theme_provider.dart';
import '../../../shared/providers/profile_provider/profile_provider.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
    var provider = Provider.of<ProfileProvider>(context);
    return Column(
      children: [
        Stack(
          alignment: AlignmentGeometry.bottomLeft,
          children: [
            Container(
              height: height * 0.3,
              decoration: BoxDecoration(
                color: appThemeProvider.isLight ? AppColors.primaryColor :AppColors.backGroundColorDark,
                borderRadius: appThemeProvider.appLanguage == "en"
                    ? BorderRadius.only(bottomLeft: Radius.circular(100))
                    : BorderRadius.only(bottomRight: Radius.circular(100)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.1,
                vertical: height * 0.04,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage(
                      "assets/images/logos/Logo_12.png",
                    ),
                  ),
                  SizedBox(width: width * 0.01),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          CacheHelper.getString("userName") ?? "Loading...",
                          style: AppStyles.bold24white,
                        ),
                        Text(
                          CacheHelper.getString("userEmail") ?? "Loading",
                          style: AppStyles.bold16white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        DropButtonsComponent(
          title: AppLocalizations.of(context)!.language,
          dropButtonTitle: appThemeProvider.appLanguage == "en"
              ? AppLocalizations.of(context)!.english
              : AppLocalizations.of(context)!.arabic,
          choseTitleOne: AppLocalizations.of(context)!.english,
          choseValueOne: 'en',
          choseTitleTwo: AppLocalizations.of(context)!.arabic,
          choseValueTwo: "ar",
          onSelect: (value) {
            appThemeProvider.changeAppLanguage(value);
          },
        ),
        DropButtonsComponent(
          buttonHeight: 0.0,
          title: AppLocalizations.of(context)!.theme,
          dropButtonTitle: appThemeProvider.isLight
              ? AppLocalizations.of(context)!.light
              : AppLocalizations.of(context)!.dark,
          choseTitleOne: AppLocalizations.of(context)!.light,
          choseValueOne: 'light',
          choseTitleTwo: AppLocalizations.of(context)!.dark,
          choseValueTwo: "dark",
          onSelect: (value) {
            appThemeProvider.changeAppTheme(value);
          },
        ),
        Spacer(),
        AppButtonComponent(
          onButtonTap: () {
            provider.logout();
          },
          buttonColor: AppColors.redColor,
          buttonName: AppLocalizations.of(context)!.logout,
          leading: Icon(
            Icons.logout,
            color: AppColors.whiteColor,
            size: 30,
          ),
        ),
      ],
    );
  }
}
