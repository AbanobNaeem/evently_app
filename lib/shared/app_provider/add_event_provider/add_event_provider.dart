import 'package:evently_app/shared/component/navigator_component/navigators.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_routs.dart';
import 'package:flutter/material.dart' ;
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/event_model.dart';
import '../../../utils/firebase_utils.dart';
import '../home_provider/home_screen_provider.dart';
import '../lang_theme_provider/theme_provider.dart';

class EventItem {
  final String title;
  final IconData icon;
  final String? lightImage;
  final String? darkImage;

  const EventItem({
    required this.title,
    required this.icon,
    this.lightImage,
    this.darkImage,
  });
}

class AddEventProvider extends ChangeNotifier {

  AddEventProvider(){
    getUserLocation();
  }
  int index = 0;

  final formKey = GlobalKey<FormState>();

  final eventTitleController = TextEditingController();
  final eventDescriptionController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  LatLng? eventLocation ;
  String? city;
  String? country ;

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

  void changeTabIndex(int selectedIndex) {
    index = selectedIndex;
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );

    if (pickedDate != null) {
      selectedDate = pickedDate;
      notifyListeners();
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      selectedTime = pickedTime;
      notifyListeners();
    }
  }

  String get formattedDate {
    if (selectedDate == null) return "";
    return DateFormat("dd/MM/yyyy").format(selectedDate!);
  }

  String get formattedTime {
    if (selectedTime == null) return "";
    final hour = (selectedTime!.hourOfPeriod == 0
        ? 12
        : selectedTime!.hourOfPeriod)
        .toString()
        .padLeft(2, '0');

    final minute = selectedTime!.minute
        .toString()
        .padLeft(2, '0');

    final period =
    selectedTime!.period == DayPeriod.am ? "AM" : "PM";

    return "$hour:$minute $period";
  }

  bool _validateSelections(BuildContext context) {
    if (selectedDate == null) {
      _showSnackBar(context, "Please select event date");
      return false;
    }

    if (selectedTime == null) {
      _showSnackBar(context, "Please select event time");
      return false;
    }

    return true;
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void clearFields() {
    eventTitleController.clear();
    eventDescriptionController.clear();
    selectedDate = null;
    selectedTime = null;
    index = 0;
    notifyListeners();
  }

  String? validateEventTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please Enter Event Title";
    }

    if (value.trim().length < 5) {
      return "At least 5 characters";
    }

    return null;
  }
  String? validateEventDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please Enter Event Description";
    }

    if (value.trim().length < 10) {
      return "At least 10 characters";
    }

    return null;
  }

  final Location location = Location();
  late GoogleMapController mapController;
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 17,);
  Set<Marker> markers = {};

  Future<bool> _getLocationPermission() async {
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> _checkGpsService() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    return serviceEnabled;
  }

  Future<void> getUserLocation() async {
    bool isPermissionGranted = await _getLocationPermission();
    if (!isPermissionGranted) return;
    bool isGpsServiceEnabled = await _checkGpsService();
    if (!isGpsServiceEnabled) return;
    LocationData locationData = await location.getLocation();
    changeCameraLocationOnTheMap(locationData: locationData);
    notifyListeners();
  }

  void changeCameraLocationOnTheMap ({required LocationData locationData}){
    cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0),
      zoom: 17,
    );
    markers = {
      Marker(
          markerId: MarkerId("1"),
          position: LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0),
          infoWindow: InfoWindow(
              title: "My Location",
              snippet: "This is my pick_location"
          )
      )
    };
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void pickLocation (LatLng selectedLocation){
    eventLocation = selectedLocation ;
    markers.add(
      Marker(
          markerId: MarkerId("2") ,
          position: selectedLocation,
          infoWindow: const InfoWindow(
            title: "event location" ,
            snippet: "this is new location selected "
          )
      )
    );
    notifyListeners();
  }

  Future<void> convertLatLngToAddress(LatLng latLng) async {
    if (eventLocation != null) {
      List<geocoding.Placemark>? placeMarks = await geocoding.placemarkFromCoordinates(
        eventLocation!.latitude ,
        eventLocation!.longitude
      );
       if(placeMarks.isNotEmpty){
         city = placeMarks.first.locality ?? "unKnown city" ;
         country = placeMarks.first.country ?? "unKnown country" ;
         notifyListeners();
       }
    }
  }

  Future<void> addEvent({
    required BuildContext context,
    required AppLocalizations appLocalizations,
    required AppThemeProvider themeProvider,
  }) async {
    if (!formKey.currentState!.validate()) return;
    if (!_validateSelections(context)) return;
    final currentEvent = getTabs(appLocalizations)[index];
    final eventModel = EventModel(
      title: eventTitleController.text.trim(),
      eventName: currentEvent.title,
      eventImage: themeProvider.isLight ? currentEvent.lightImage! : currentEvent.darkImage!,
      eventDateTime: selectedDate!,
      eventTime: formattedTime,
      eventDescription:
      eventDescriptionController.text.trim(),
      eventLocation: "${city ?? "Unknown city"}, ${country ?? "Unknown country"}",
      latitude: eventLocation?.latitude ?? 0,
      longitude: eventLocation?.longitude ?? 0 ,
    );
    try {
      await FirebaseUtils.addToFireStore(eventModel);
      _showSnackBar(context, "Event added successfully");
      clearFields();
      NavigationService.instance.pushNamed(AppRouts.layoutRoutName);
    } catch (e) {
      _showSnackBar(context, "Error: $e");
    }
  }

  @override
  void dispose() {
    eventTitleController.dispose();
    eventDescriptionController.dispose();
    super.dispose();
  }
}