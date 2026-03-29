import 'package:evently_app/layout/layout_screen.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/modules/on_boarding/on_boarding_first_screen.dart';
import 'package:evently_app/shared/app_provider/language_provider.dart';
import 'package:evently_app/shared/app_provider/theme_provider.dart';
import 'package:evently_app/shared/data/local/cash_helper.dart';
import 'package:evently_app/utils/app_routs.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      locale: Locale(appLanguageProvider.appLanguage),
      initialRoute: AppRouts.onBoardingBeginRoutName,
      routes: {
        AppRouts.layoutRoutName: (context) => LayoutScreen(),
        AppRouts.onBoardingBeginRoutName : (context)=>OnBoardingBeginScreen(),
      },
      theme: AppTheme.appThemeLight,
      darkTheme: AppTheme.appThemeDark,
      themeMode:appThemeProvider.isLight?ThemeMode.light:ThemeMode.dark ,
    );
  }
}


