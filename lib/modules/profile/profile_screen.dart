import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/shared/app_provider/language_provider.dart';
import 'package:evently_app/shared/component/buttons_component/app_button_component.dart';
import 'package:evently_app/shared/component/buttons_component/drop_buttons_component.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/app_provider/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    return Column(
      children: [
        Stack(
          alignment: AlignmentGeometry.bottomLeft,
          children: [
            Container(
              height: height * 0.3,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: width * 0.1, vertical: height*0.04),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: width * 0.32,
                        height: height * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(100),bottomRight: Radius.circular(100) ,topRight: Radius.circular(100)),
                          color: AppColors.whiteColor
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: width* 0.02,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Abanob", style: AppStyles.bold24white,),
                        Text("abanobnaeem80@gmai.com", style: AppStyles.bold16white,)
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        DropButtonsComponent(
          title: AppLocalizations.of(context)!.language,
          dropButtonTitle: appLanguageProvider.appLanguage == "en"
              ? AppLocalizations.of(context)!.english
              : AppLocalizations.of(context)!.arabic,
          choseTitleOne: AppLocalizations.of(context)!.english,
          choseValueOne: 'en',
          choseTitleTwo: AppLocalizations.of(context)!.arabic,
          choseValueTwo: "ar",
          onSelect: (value) {
            appLanguageProvider.changeAppLanguage(value);
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
            onButtonTap: (){},
            buttonColor: AppColors.redColor,
            buttonName: AppLocalizations.of(context)!.logout,
            leading: Icon(Icons.logout, color: AppColors.whiteColor,size: 30,),
        )
      ],
    );
  }
}
