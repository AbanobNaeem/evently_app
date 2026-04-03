import 'package:evently_app/shared/app_provider/create_event_provider/create_event_provider.dart';
import 'package:evently_app/shared/app_provider/lang_theme_provider/theme_provider.dart';
import 'package:evently_app/shared/component/buttons_component/app_button_component.dart';
import 'package:evently_app/shared/component/buttons_component/create_event_button.dart';
import 'package:evently_app/shared/component/buttons_component/square_button.dart';
import 'package:evently_app/shared/component/text_form_field/custom_text_form_field.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../shared/component/buttons_component/categories_tabs_component.dart';
import '../../utils/app_styles.dart';
import 'location/location_screen.dart';

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appLocalizations = AppLocalizations.of(context)!;
    return ChangeNotifierProvider(
      create: (context) => CreateEventProvider(),
      child: Consumer2<CreateEventProvider, AppThemeProvider>(
        builder: (context, provider, themeProvider, child) {
          final currentEvent = provider.getTabs(
            appLocalizations,
          )[provider.index];
          return Scaffold(
            appBar: AppBar(
              title: Text(
                appLocalizations.createEvent,
                style: AppStyles.bold20Primary,
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.02,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        themeProvider.isLight
                            ? currentEvent.lightImage!
                            : currentEvent.darkImage!,
                        width: double.infinity,
                        height: size.height * 0.25,
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    CategoriesTabs(
                      selectedColor: AppColors.primaryColor,
                      selectedTextStyle: AppStyles.bold16white,
                      selectedIconColor: AppColors.whiteColor,
                      outlineColor: AppColors.primaryColor,
                      unSelectedTextStyle: AppStyles.bold16Primary,
                      unSelectedIconColor: AppColors.primaryColor,
                      tabs: provider.getTabs(appLocalizations),
                      selectedIndex: provider.index,
                      onTabSelected: (index) {
                        provider.changeTapIndex(selectedIndex: index);
                      },
                    ),
                    SizedBox(height: size.height * 0.01),
                    CustomTextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Your Event Title";
                        } else if (value.length < 5) {
                          return "Event Title Must Be At Least 5 Characters";
                        }
                        return null;
                      },
                      cursorColor: themeProvider.isLight
                          ? AppColors.greyColor
                          : AppColors.whiteColor,
                      searchStyle: themeProvider.isLight
                          ? AppStyles.bold16gray
                          : AppStyles.bold16white,
                      iconColor: themeProvider.isLight
                          ? AppColors.greyColor
                          : AppColors.whiteColor,
                      hintStyle: themeProvider.isLight
                          ? AppStyles.bold16gray
                          : AppStyles.bold16white,
                      outlineColor: themeProvider.isLight
                          ? AppColors.greyColor
                          : AppColors.primaryColor,
                      titleText: appLocalizations.title,
                      controller: provider.eventTitleController,
                      hintText: appLocalizations.eventTitle,
                      prefixIcon: Icons.edit_square,
                    ),
                    SizedBox(height: size.height * 0.01),
                    CustomTextFormField(
                      cursorColor: themeProvider.isLight
                          ? AppColors.greyColor
                          : AppColors.whiteColor,
                      searchStyle: themeProvider.isLight
                          ? AppStyles.bold16gray
                          : AppStyles.bold16white,
                      hintStyle: themeProvider.isLight
                          ? AppStyles.bold16gray
                          : AppStyles.bold16white,
                      outlineColor: themeProvider.isLight
                          ? AppColors.greyColor
                          : AppColors.primaryColor,
                      maxLines: 5,
                      titleText: appLocalizations.description,
                      controller: provider.eventDescriptionController,
                      hintText: appLocalizations.eventDescription,
                    ),
                    SizedBox(height: size.height * 0.02),
                    DateAndTimeButton(
                      icon: Icons.date_range,
                      buttonName: provider.selectedDate != null
                          ? provider.formattedDate
                          : appLocalizations.chooseDate,
                      title: appLocalizations.selectDate,
                      buttonTap: () {
                        provider.selectDate(context: context);
                      },
                    ),
                    SizedBox(height: size.height * 0.01),
                    DateAndTimeButton(
                      icon: Icons.access_time,
                      buttonName: provider.selectedTime != null
                          ? provider.formattedTime
                          : appLocalizations.chooseTime,
                      title: appLocalizations.selectTime,
                      buttonTap: () {
                        provider.selectTime(context);
                      },
                    ),
                    AppButtonComponent(
                      arrowIcon: true,
                      buttonHeightPadding: 0.01,
                      buttonWidthPadding: 0,
                      onButtonTap: () async {
                        // افتح الشاشة واخد الـ result
                        LatLng? location = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SelectLocationScreen(),
                          ),
                        );

                        if (location != null) {
                          // هنا تقدر تخزن الموقع في provider أو تعرضه
                          print("Selected Location: ${location.latitude}, ${location.longitude}");
                          // لو عندك provider:
                          // Provider.of<CreateEventProvider>(context, listen: false)
                          //     .eventLocation = location;
                        }
                      },
                      isOutlined: true,
                      leading: SquareButton(
                        color: AppColors.primaryColor,
                        child: Icon(
                          Icons.my_location_outlined,
                          color: AppColors.whiteColor,
                          size: 25,
                        ),
                      ),
                      buttonColor: AppColors.primaryColor,
                      buttonName: appLocalizations.chooseEventLocation,
                    ),
                    AppButtonComponent(
                      buttonHeightPadding: 0.01,
                      buttonWidthPadding: 0,
                      onButtonTap: () {},
                      centerText: true,
                      buttonColor: AppColors.primaryColor,
                      buttonName: appLocalizations.addEvent,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
