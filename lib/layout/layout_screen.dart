import 'package:evently_app/modules/home/home_screen.dart';
import 'package:evently_app/modules/location/location_screen.dart';
import 'package:evently_app/modules/love/love_screen.dart';
import 'package:evently_app/shared/app_provider/home_provider/home_screen_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../modules/profile/profile_screen.dart';
import '../shared/app_provider/location_provider/location_provider.dart';
import '../shared/app_provider/profile_provider/profile_provider.dart';
import '../shared/component/navigator_component/navigators.dart';


class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}
int  selectedIndex = 0 ;
List<Widget> appScreens = [
  ChangeNotifierProvider(
    create: (context) => HomeScreenProvider(),
      child: HomeScreen()),
  ChangeNotifierProvider(
    create: (context) => LocationProvider(),
    child: LocationScreen(),
  ),
  LoveScreen(),
  ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      child: ProfileScreen()),
];

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            NavigationService.instance.pushNamed(AppRouts.addEventScreenRoutName,);
          },
          child: Icon(Icons.add , color: AppColors.whiteColor,size: 35,),
      ),
     bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
     currentIndex: selectedIndex,
     onTap: (index){
        setState(() {
          selectedIndex = index ;
        });
     },
     items: [
       bottomNavigationBarItem(
           index: 0,
           label:appLocalizations.home,
           selectedIcon: Icons.home,
           unSelectedIcon: Icons.home_outlined
       ),
       bottomNavigationBarItem(
           index: 1,
           label: appLocalizations.map,
           selectedIcon: Icons.location_on,
           unSelectedIcon: Icons.location_on_outlined),
       bottomNavigationBarItem(
           index: 2,
           label: appLocalizations.love,
           selectedIcon: Icons.favorite,
           unSelectedIcon: Icons.favorite_outline),
       bottomNavigationBarItem(
           index: 3,
           label: appLocalizations.profile,
           selectedIcon: Icons.person,
           unSelectedIcon: Icons.person_outline)
     ],
    ),
      body: appScreens[selectedIndex],
    );
  }
  BottomNavigationBarItem bottomNavigationBarItem ({
    required String label,
    required IconData selectedIcon,
    required IconData unSelectedIcon,
    required int index
}){
    return BottomNavigationBarItem(
        icon: Icon(index == selectedIndex ? selectedIcon : unSelectedIcon),
        label: label,
    );
  }
}
