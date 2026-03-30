import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/shared/app_provider/theme_provider.dart';
import 'package:evently_app/shared/component/buttons_component/switch_component.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../shared/app_provider/language_provider.dart';
import '../../../shared/component/buttons_component/app_button_component.dart';
import '../../../shared/component/navigator_component/navigators.dart';
import '../onboardng_screens/onboarding_screens.dart';
class OnboardingBeginScreen extends StatelessWidget {
   OnboardingBeginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height ;
    var width = MediaQuery.of(context).size.width ;
    AppLocalizations? appLocalizations = AppLocalizations.of(context) ;
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(top: height* 0.1),
        child: Column(
          children: [
            Image.asset(AppAssets.eventlyLogo,),
            Image.asset(AppAssets.beingCreative, fit: BoxFit.fill,height: height * 0.4,),
            Expanded(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: width* 0.04, vertical: height *0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appLocalizations!.personalizeYourExperience,
                      style: AppStyles.bold20Primary,),
                    SizedBox(height: height *0.01,),
                    Text(appLocalizations.chooseYourTheme,
                      style: appThemeProvider.isLight? AppStyles.bold16Black : AppStyles.bold16white),
                    SwitchComponent(
                        title: appLocalizations.language,
                        initialIndex: appLanguageProvider.appLanguage == "en" ? 0 : 1,
                        listOfIcons: [
                          Image.asset("assets/images/en.png"),
                          Image.asset("assets/images/ar.png"),
                        ],
                        onTapIndex: (index){
                          appLanguageProvider.changeAppLanguage(
                            index == 0 ? "en" : "ar"
                          );
                        }),
                    SwitchComponent(
                        title: appLocalizations.theme,
                        initialIndex: appThemeProvider.isLight ? 0 : 1 ,
                        listOfIcons: [
                          Icon(Icons.light_mode),
                          Icon(Icons.dark_mode)
                        ],
                        onTapIndex: (index){
                          appThemeProvider.changeAppTheme(
                            index == 0 ? "light" : "dark"
                          );
                        }),
                    Spacer(),
                    AppButtonComponent(
                      buttonHeightPadding: 0.01,
                      buttonWidthPadding: 0.01,
                      onButtonTap: (){
                        NavigationService.instance.push(OnboardingScreens());
                      },
                      buttonColor: AppColors.primaryColor,
                      buttonName: appLocalizations.letsStart,
                      centerText: true,
                    )


                  ],
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}
