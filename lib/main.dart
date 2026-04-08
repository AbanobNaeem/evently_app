import 'package:evently_app/layout/layout_screen.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/modules/user_authentication/forget_password/forget_password_screen.dart';
import 'package:evently_app/modules/user_authentication/login/login_screen.dart';
import 'package:evently_app/shared/app_provider/add_event_provider/add_event_provider.dart';
import 'package:evently_app/shared/app_provider/auth_provider/forget_password_provider.dart';
import 'package:evently_app/shared/app_provider/auth_provider/login_provider.dart';
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
import 'modules/pick_location/pick_location_screen.dart';
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
    ChangeNotifierProvider(
        create: (context) => AppThemeProvider(),
        child: MyApp(seenOnBoarding: seenOnBoarding, isLoggedIn: isLoggedIn)),
  );
}

class MyApp extends StatelessWidget {
  final bool seenOnBoarding;
  final bool isLoggedIn;
  const MyApp({super.key, required this.seenOnBoarding, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
    String initialRoute;
    if (isLoggedIn) {
      initialRoute = AppRouts.layoutRoutName;
    } else if (!seenOnBoarding) {
      initialRoute = AppRouts.onBoardingBeginRoutName;
    } else {
      initialRoute = AppRouts.loginScreenRoutName;
    }
    return MaterialApp(
      navigatorKey: NavigationService.instance.navigatorKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      locale: Locale(appThemeProvider.appLanguage),
      initialRoute: initialRoute ,
      routes: {
        AppRouts.layoutRoutName: (context) => LayoutScreen(),
        AppRouts.onBoardingBeginRoutName : (context) => OnboardingBeginScreen(),
        AppRouts.onBoardingScreensRoutName : (context) => OnboardingScreens(),
        AppRouts.loginScreenRoutName : (context) => ChangeNotifierProvider(create: (context) => LoginProvider() , child : LoginScreen()),
        AppRouts.registerScreenRoutName : (context) => RegisterScreen(),
        AppRouts.forgetPasswordScreenRoutName : (context) => ChangeNotifierProvider(create: (context) => ForgetPasswordProvider(),child: ForgetPasswordScreen()),
        AppRouts.addEventScreenRoutName : (context) => ChangeNotifierProvider(create: (BuildContext context) => AddEventProvider(), child: AddEventScreen()),
        AppRouts.pickLocationScreenRoutName : (context){
          return PickLocationScreen(provider: ModalRoute.of(context)?.settings.arguments as AddEventProvider );
        },
      },
      theme: AppTheme.appThemeLight,
      darkTheme: AppTheme.appThemeDark,
      themeMode: appThemeProvider.isLight ? ThemeMode.light : ThemeMode.dark,
    );
  }
}


