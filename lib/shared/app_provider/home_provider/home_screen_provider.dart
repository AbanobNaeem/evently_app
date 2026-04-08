import 'package:evently_app/models/user_data_model.dart';
import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/event_model.dart';
import '../../../utils/firebase_utils.dart';
import '../../data/local/cash_helper.dart';

class TabItem {
  final String title;
  final IconData icon;

  TabItem({
    required this.title,
    required this.icon,
  });
}

class HomeScreenProvider extends ChangeNotifier {

  HomeScreenProvider(){
    getEventsData();
    getUserData();
  }

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
  List<EventModel> events = [] ;
  UserDataModel? userData ;
  bool isLoadingUser = false;




  void changeTapIndex({required int selectedIndex}) {
    index = selectedIndex;
    notifyListeners();
  }


  Future<void> getEventsData() async {
    try {
      final snapshot = await FirebaseUtils.getUserEventsCollection().get();
      events = snapshot.docs
          .map((doc) => doc.data())
          .toList();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getUserData() async {
    isLoadingUser = true;
    notifyListeners();

    try {
      final docSnapshot =
      await FirebaseUtils.getUserDataCollection().get();

      userData = docSnapshot.data();

      if (userData != null) {
        await CacheHelper.setString("userName", userData!.userName);
        await CacheHelper.setString("userEmail", userData!.userEmail);
      }
    } catch (e) {
      print("Get User Data Error: $e");
    }

    isLoadingUser = false;
    notifyListeners();
  }


}