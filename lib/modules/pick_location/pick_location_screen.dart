import 'package:evently_app/shared/app_provider/add_event_provider/add_event_provider.dart';
import 'package:evently_app/shared/component/navigator_component/navigators.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_styles.dart';


class PickLocationScreen extends StatelessWidget {
  final AddEventProvider provider ;
  const PickLocationScreen({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Consumer<AddEventProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: GoogleMap(
                      initialCameraPosition: provider.cameraPosition,
                      onMapCreated: (controller) {
                        provider.mapController = controller;
                      },
                    onTap: (selectedLocation) async {
                      provider.pickLocation(selectedLocation);
                      await provider.convertLatLngToAddress(selectedLocation);
                      NavigationService.instance.pop();
                    },
                      markers: provider.markers,
                      mapType: MapType.normal,
                   ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  width: double.infinity,

                  color: AppColors.primaryColor ,
                  child: Text(
                    textAlign: TextAlign.center ,
                    "Tap on location to select",
                    style: AppStyles.bold20white,
                  ),
                )
              ],
            ),

          );
        },
      ),
    );
  }
}
