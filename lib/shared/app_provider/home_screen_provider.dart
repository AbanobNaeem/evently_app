import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class TabItem {
  final String title;
  final IconData icon;

  TabItem({
    required this.title,
    required this.icon,
  });
}

class HomeScreenProvider extends ChangeNotifier {
  int index = 0;
  List<TabItem> getTabs(AppLocalizations appLocalizations) {
    return [
      TabItem(
        title: appLocalizations.all,
        icon: Icons.explore_outlined,
      ),
      TabItem(
        title: appLocalizations.sports,
        icon: Icons.sports_basketball_outlined,
      ),
      TabItem(
        title: appLocalizations.birthday,
        icon: Icons.cake_outlined,
      ),
      TabItem(
        title: appLocalizations.meeting,
        icon: Icons.groups_outlined,
      ),
      TabItem(
        title: appLocalizations.gaming,
        icon: Icons.sports_esports_outlined,
      ),
      TabItem(
        title: appLocalizations.workShop,
        icon: Icons.handyman_outlined,
      ),
      TabItem(
        title: appLocalizations.bookClub,
        icon: Icons.menu_book_outlined,
      ),
      TabItem(
        title: appLocalizations.exhibitions,
        icon: Icons.museum_outlined,
      ),
      TabItem(
        title: appLocalizations.holiday,
        icon: Icons.beach_access_outlined,
      ),
      TabItem(
        title: appLocalizations.eating,
        icon: Icons.restaurant_outlined,
      ),
    ];
  }


  void changeTapIndex({required int selectedIndex}) {
    index = selectedIndex;
    notifyListeners();
  }


}