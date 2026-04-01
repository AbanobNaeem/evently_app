import 'package:evently_app/layout/layout_screen.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/modules/user_authentication/login/login_screen.dart';
import 'package:evently_app/shared/app_provider/language_provider.dart';
import 'package:evently_app/shared/app_provider/theme_provider.dart';
import 'package:evently_app/shared/component/navigator_component/navigators.dart';
import 'package:evently_app/shared/data/local/cash_helper.dart';
import 'package:evently_app/utils/app_routs.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'modules/onboarding/first_screen/onboarding_first_screen.dart';
import 'modules/onboarding/onboardng_screens/onboarding_screens.dart';
import 'modules/user_authentication/register/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppLanguageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppThemeProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    return MaterialApp(
      navigatorKey: NavigationService.instance.navigatorKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      locale: Locale(appLanguageProvider.appLanguage),
      initialRoute: AppRouts.layoutRoutName,
      routes: {
        AppRouts.layoutRoutName: (context) => LayoutScreen(),
        AppRouts.onBoardingBeginRoutName : (context)=>OnboardingBeginScreen(),
        AppRouts.onBoardingScreensRoutName : (context)=> OnboardingScreens(),
        AppRouts.loginScreenRoutName : (context)=> LoginScreen(),
        AppRouts.registerScreenRoutName : (context)=> RegisterScreen(),

      },
      theme: AppTheme.appThemeLight,
      darkTheme: AppTheme.appThemeDark,
      themeMode:appThemeProvider.isLight?ThemeMode.light:ThemeMode.dark ,
    );
  }
}


