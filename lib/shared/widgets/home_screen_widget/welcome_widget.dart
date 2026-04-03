import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/shared/component/buttons_component/square_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../app_provider/lang_theme_provider/language_provider.dart';
import '../../app_provider/lang_theme_provider/theme_provider.dart';

class WelcomeWidget extends StatelessWidget {
  final String userNameAccount;

  const WelcomeWidget({
    super.key,
    required this.userNameAccount,
    });

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    AppThemeProvider appThemeProvider = Provider.of<AppThemeProvider>(context);
    AppLanguageProvider appLanguageProvider = Provider.of<AppLanguageProvider>(
      context,
    );
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.06),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(appLocalizations.welcomeBack, style: AppStyles.bold16white),
              Text(userNameAccount, style: AppStyles.bold24white),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: (){
                  appThemeProvider.changeAppTheme(
                      appThemeProvider.isLight ? "dark" : "light");
                },
                icon: Icon(
                  appThemeProvider.isLight ? Icons.dark_mode : Icons.light_mode,
                  color: AppColors.whiteColor,
                  size: 35,
                ),
              ),
              SizedBox(width: size.width * 0.02),
              InkWell(
                onTap: () {
                  appLanguageProvider.changeAppLanguage(
                    appLanguageProvider.appLanguage == "en" ? "ar" : "en",
                  );
                },
                child: SquareButton(color: AppColors.whiteColor,
                    child:Text(
                      appLanguageProvider.appLanguage == "en" ? "EN" : "AR",
                      style: AppStyles.bold20Primary,
                    )) ,
              ),
            ],
          ),
        ],
      ),
    );
  }

}