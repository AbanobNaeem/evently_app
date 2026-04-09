import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/shared/component/buttons_component/app_button_component.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../shared/component/buttons_component/square_button.dart';
import '../../shared/providers/event_details_provider/event_details_provider.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EventModel selectedEventData =
        ModalRoute.of(context)!.settings.arguments as EventModel;
    var size = MediaQuery.of(context).size;
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final provider = Provider.of<EventDetailsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Details", style: AppStyles.bold20Primary),
        actions: [
          IconButton(
            onPressed: () {
              provider.deleteEvent(selectedEventData.eventID);
            },
            icon: Icon(Icons.delete, color: AppColors.redColor),
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  selectedEventData.eventImage,
                  height: size.height * 0.2,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                selectedEventData.title,
                textAlign: TextAlign.center,
                style: AppStyles.bold24Primary,
              ),
              AppButtonComponent(
                buttonHeightPadding: 0.01,
                buttonWidthPadding: 0,
                isOutlined: true,
                leading: SquareButton(
                  color: AppColors.primaryColor,
                  child: Icon(
                    Icons.calendar_month,
                    size: 40,
                    color: AppColors.whiteColor,
                  ),
                ),
                buttonColor: AppColors.primaryColor,
                buttonName:
                    "${DateFormat("dd/MM/yyyy").format(selectedEventData.eventDateTime)}\n ${selectedEventData.eventTime}",
                onButtonTap: () {},
              ),
              AppButtonComponent(
                buttonHeightPadding: 0.01,
                buttonWidthPadding: 0,
                isOutlined: true,
                arrowIcon: true,
                leading: SquareButton(
                  color: AppColors.primaryColor,
                  child: Icon(
                    Icons.my_location,
                    size: 40,
                    color: AppColors.whiteColor,
                  ),
                ),
                buttonColor: AppColors.primaryColor,
                buttonName: selectedEventData.eventLocation,
                onButtonTap: () {},
              ),
              Container(
                height: size.height * 0.4,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor, width: 2.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        selectedEventData.latitude as double,
                        selectedEventData.longitude as double,
                      ),
                      zoom: 17,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId("event_location"),
                        position: LatLng(
                          selectedEventData.latitude as double,
                          selectedEventData.longitude as double,
                        ),
                        infoWindow: InfoWindow(
                          title: selectedEventData.title,
                          snippet: selectedEventData.eventLocation,
                        ),
                      ),
                    },
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                appLocalizations.description,
                style: AppStyles.bold20Primary,
              ),
              Text(
                selectedEventData.eventDescription,
                style: AppStyles.bold16Primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
