import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:evently_app/shared/app_provider/lang_theme_provider/theme_provider.dart';
import 'package:evently_app/shared/component/card/event_card.dart';
import 'package:evently_app/shared/data/local/cash_helper.dart';
import 'package:evently_app/shared/widgets/home_screen_widget/user_location_widget.dart';
import 'package:evently_app/shared/widgets/home_screen_widget/welcome_widget.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/app_provider/home_provider/home_screen_provider.dart';
import '../../shared/component/buttons_component/categories_tabs_component.dart';
import '../../utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var appLocalizations = AppLocalizations.of(context)!;
    var provider = Provider.of<HomeScreenProvider>(context);
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: size.height * 0.25,
              decoration: BoxDecoration(
                color: appThemeProvider.isLight
                    ? AppColors.primaryColor
                    : AppColors.backGroundColorDark,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Column(
                children: [
                  WelcomeWidget(
                    userNameAccount: CacheHelper.getString("userName") ?? provider.userData?.userName ?? "null",
                  ),
                  UserLocationWidget(
                      userLocation: (CacheHelper.getString('userCity')?? "").isEmpty? ""
                          : "${CacheHelper.getString('userCity')} , "
                          "${CacheHelper.getString('userCountry')}"),
                  SizedBox(height: size.height * 0.01),
                  CategoriesTabs(
                    isPrimaryBackground: appThemeProvider.isLight ? false : true,
                    tabs: provider.getTabs(appLocalizations),
                    selectedIndex: provider.index,
                    onTabSelected: (index) {
                      provider.changeTapIndex(selectedIndex: index, appLocalizations: appLocalizations);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        ConditionalBuilder(
          condition: provider.filteredEvents.isNotEmpty,
          builder: (context) => Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: provider.filteredEvents.length,
              itemBuilder: (context, index) {
                final event = provider.filteredEvents[index];
                return EventCard(
                  eventModel: event,
                  onFavTap: () {
                    provider.addFavourite(event);
                  },
                );
              },
            ),
          ),
          fallback: (context) => Expanded(
            child: Center(
              child: Text(
                "You don't have any events here yet",
                style: AppStyles.bold20Primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
