import 'package:evently_app/modules/layout_taps/map/map_provider/map_provider.dart';
import 'package:evently_app/shared/component/card/event_map_card.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';


class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LocationProvider locationProvider = Provider.of<LocationProvider>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          locationProvider.getUserLocation();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(Icons.my_location, color: AppColors.whiteColor, size: 25,),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: locationProvider.cameraPosition,
                  markers: locationProvider.markers,
                  onMapCreated: (GoogleMapController controller) {
                    locationProvider.mapController = controller;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.2,

            child: ListView.separated(
              padding:  EdgeInsets.all(16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => EventMapCard(
                  eventModel: locationProvider.events[index],
                  onEventTap: (){
                    locationProvider.getEventWithLocation(
                        LatLng(locationProvider.events[index].latitude?? 0,
                            locationProvider.events[index].longitude?? 0),
                      index
                    );
                  }),
              separatorBuilder: (context, index) => const SizedBox(width: 20),
              itemCount:locationProvider.events.length,
            ),
          )

        ],
      ),
    );
  }
}