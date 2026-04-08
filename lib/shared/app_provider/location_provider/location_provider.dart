import 'dart:async';

import 'package:evently_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../utils/firebase_utils.dart';
import '../../data/local/cash_helper.dart';

class LocationProvider extends ChangeNotifier {
  LocationProvider() {
    getUserLocation();
    getEvents() ;

  }



  final Location location = Location();
  late GoogleMapController mapController;
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 17,);
  Set<Marker> markers = {};
  late final StreamSubscription<LocationData> _locationStream;
  List<EventModel> events = [] ;


  Future<void> getEvents ()async {
    final snapshot = await FirebaseUtils.getUserEventsCollection().get();
    events = snapshot.docs
        .map((doc) => doc.data())
        .toList();
    notifyListeners();
  }

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
    try {
      List<geocoding.Placemark> placeMarks = await geocoding.placemarkFromCoordinates(
        locationData.latitude ?? 0.0,
        locationData.longitude ?? 0.0,
      );
      if (placeMarks.isNotEmpty) {
        String city = placeMarks.first.locality ?? "Unknown city";
        String country = placeMarks.first.country ?? "Unknown country";
        await CacheHelper.setString("userCity", city);
        await CacheHelper.setString("userCountry", country);
      }
    } catch (e) {
      print("Error converting location to address: $e");
    }
    notifyListeners();
  }

  void getEventWithLocation(LatLng eventLocation , index){
    cameraPosition = CameraPosition(
        target: LatLng(eventLocation.latitude , eventLocation.longitude) ,
        zoom: 17
     );
    markers.add(
        Marker(
            markerId: MarkerId(UniqueKey().toString()),
            position: LatLng(eventLocation.latitude , eventLocation.longitude),
            infoWindow: InfoWindow(
                title: events[index].title,
                snippet: events[index].eventDescription
            )
        )
    );
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();
  }

  void changeCameraLocationOnTheMap ({required LocationData locationData}){
    cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0),
      zoom: 17,
    );
    markers= {
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

  void setLocationListener(){
    location.changeSettings(
        accuracy:LocationAccuracy.high,
        interval: 500
    );
    _locationStream = location.onLocationChanged.listen((LocationData currentLocation){
      changeCameraLocationOnTheMap(locationData: currentLocation);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    mapController.dispose();
    _locationStream.cancel();
    super.dispose();
  }
}
