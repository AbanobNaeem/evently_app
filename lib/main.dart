import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/layout/layout_screen.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/modules/user_authentication/login/login_screen.dart';
import 'package:evently_app/shared/app_provider/lang_theme_provider/language_provider.dart';
import 'package:evently_app/shared/app_provider/lang_theme_provider/theme_provider.dart';
import 'package:evently_app/shared/component/navigator_component/navigators.dart';
import 'package:evently_app/shared/data/local/cash_helper.dart';
import 'package:evently_app/utils/app_routs.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'modules/add_event/add_event_screen.dart';
import 'modules/onboarding/first_screen/onboarding_first_screen.dart';
import 'modules/onboarding/onboardng_screens/onboarding_screens.dart';
import 'modules/user_authentication/register/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  bool seenOnBoarding = CacheHelper.getBool('seenOnBoarding') ?? false;
  bool isLoggedIn = CacheHelper.getBool('isLoggedIn') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
      ],
      child: MyApp(seenOnBoarding: seenOnBoarding, isLoggedIn: isLoggedIn), // ⚡ هنا
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool seenOnBoarding;
  final bool isLoggedIn;
  const MyApp({super.key, required this.seenOnBoarding, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    String initialRoute;
    if (isLoggedIn) {
      initialRoute = AppRouts.layoutRoutName;
    } else if (!seenOnBoarding) {
      initialRoute = AppRouts.onBoardingScreensRoutName;
    } else {
      initialRoute = AppRouts.loginScreenRoutName;
    }
    return MaterialApp(
      navigatorKey: NavigationService.instance.navigatorKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      locale: Locale(appLanguageProvider.appLanguage),
      initialRoute: initialRoute ,
      routes: {
        AppRouts.layoutRoutName: (context) => LayoutScreen(),
        AppRouts.onBoardingBeginRoutName : (context) => OnboardingBeginScreen(),
        AppRouts.onBoardingScreensRoutName : (context) => OnboardingScreens(),
        AppRouts.loginScreenRoutName : (context) => LoginScreen(),
        AppRouts.registerScreenRoutName : (context) => RegisterScreen(),
        AppRouts.addEventScreenRoutName : (context) => AddEventScreen(),
      },
      theme: AppTheme.appThemeLight,
      darkTheme: AppTheme.appThemeDark,
      themeMode: appThemeProvider.isLight ? ThemeMode.light : ThemeMode.dark,
    );
  }
}


