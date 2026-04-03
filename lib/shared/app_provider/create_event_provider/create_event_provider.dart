
import 'package:evently_app/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../l10n/app_localizations.dart';

class EventItem {
  final String title;
  final IconData icon;
  final String? lightImage;
  final String? darkImage;



  EventItem({
    required this.title,
    required this.icon,
    this.lightImage,
    this.darkImage,

  });
}


class CreateEventProvider extends ChangeNotifier {
  int index = 0;
  List<EventItem> getTabs(AppLocalizations appLocalizations) {
    return [
      EventItem(
        title: appLocalizations.sports,
        icon: Icons.sports_basketball_outlined,
        lightImage: AppAssets.sportsLight,
        darkImage: AppAssets.sportsDark,

      ),
      EventItem(
        title: appLocalizations.birthday,
        icon: Icons.cake_outlined,
        lightImage: AppAssets.birthdayLight,
        darkImage: AppAssets.birthdayDark,

      ),
      EventItem(
        title: appLocalizations.meeting,
        icon: Icons.groups_outlined,
        lightImage: AppAssets.meetingLight,
        darkImage: AppAssets.meetingDark,
      ),
      EventItem(
        title: appLocalizations.gaming,
        icon: Icons.sports_esports_outlined,
        lightImage: AppAssets.gamingLight,
        darkImage: AppAssets.gamingDark,
      ),
      EventItem(
        title: appLocalizations.workShop,
        icon: Icons.handyman_outlined,
        lightImage: AppAssets.workShopLight,
        darkImage: AppAssets.workShopDark,
      ),
      EventItem(
        title: appLocalizations.bookClub,
        icon: Icons.menu_book_outlined,
        lightImage: AppAssets.bookClubLight,
        darkImage: AppAssets.bookClubDark,
      ),
      EventItem(
        title: appLocalizations.exhibitions,
        icon: Icons.museum_outlined,
        lightImage: AppAssets.exhibitionsLight,
        darkImage: AppAssets.exhibitionsDark,
      ),
      EventItem(
        title: appLocalizations.holiday,
        icon: Icons.beach_access_outlined,
        lightImage: AppAssets.holidayLight,
        darkImage: AppAssets.holidayDark,
      ),
      EventItem(
        title: appLocalizations.eating,
        icon: Icons.restaurant_outlined,
        lightImage: AppAssets.eatingLight,
        darkImage: AppAssets.eatingDark,
      ),
    ];
  }
  String get formattedTime {
    if (selectedTime == null) return "";

    final hour = (selectedTime!.hourOfPeriod == 0
        ? 12
        : selectedTime!.hourOfPeriod)
        .toString()
        .padLeft(2, '0');

    final minute =
    selectedTime!.minute.toString().padLeft(2, '0');

    final period =
    selectedTime!.period == DayPeriod.am ? "AM" : "PM";

    return "$hour:$minute $period";
  }
  final TextEditingController eventTitleController = TextEditingController();
  final TextEditingController eventDescriptionController = TextEditingController();
  DateTime? selectedDate ;
  TimeOfDay? selectedTime;
  String formattedDate = ' ' ;

  void changeTapIndex({required int selectedIndex}) {
    index = selectedIndex;
    notifyListeners();
  }

  Future<void> selectDate({
    required BuildContext context,
  }) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      selectedDate = pickedDate;
      formattedDate = DateFormat("dd/MM/yyyy").format(selectedDate!);
      notifyListeners();
    }
  }




  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null){
      selectedTime = pickedTime;

    }
    notifyListeners();

  }

}
