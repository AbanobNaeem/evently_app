import 'package:evently_app/shared/component/card/event_card.dart';
import 'package:evently_app/shared/widgets/home_screen_widget/user_location_widget.dart';
import 'package:evently_app/shared/widgets/home_screen_widget/welcome_widget.dart';
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
    return ChangeNotifierProvider(
      create: (_) => HomeScreenProvider(),
      child: Builder(
        builder: (context) {
          final provider = Provider.of<HomeScreenProvider>(context);
          return Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: size.height * 0.25,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
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
                        WelcomeWidget(userNameAccount: "Abanob Naeem",),
                        UserLocationWidget(userLocation: "Cairo, Egypt",),
                        SizedBox(height: size.height * 0.01,),
                        CategoriesTabs(
                          tabs: provider.getTabs(appLocalizations),
                          selectedIndex: provider.index,
                          onTabSelected: (index) {
                            provider.changeTapIndex(selectedIndex: index);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Expanded(child: ListView.separated(
                padding: EdgeInsets.zero,
                  itemBuilder:(context, index) =>  EventCard(),
                  separatorBuilder:(context, index) => SizedBox(height: size.height * 0.01,),
                  itemCount: 20))
            ],
          );
        },
      ),
    );
  }
}
