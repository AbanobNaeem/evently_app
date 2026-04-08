import 'package:evently_app/shared/app_provider/lang_theme_provider/theme_provider.dart';
import 'package:evently_app/shared/component/buttons_component/square_button.dart';
import 'package:evently_app/shared/component/navigator_component/navigators.dart';
import 'package:evently_app/utils/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/app_provider/add_event_provider/add_event_provider.dart';
import '../../shared/component/buttons_component/app_button_component.dart';
import '../../shared/component/buttons_component/categories_tabs_component.dart';
import '../../shared/component/buttons_component/create_event_button.dart';
import '../../shared/component/text_form_field/custom_text_form_field.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddEventProvider>(
      builder: (BuildContext context, AddEventProvider provider, Widget? child) {
            final appLocalizations = AppLocalizations.of(context)!;
            final size = MediaQuery.of(context).size;
            final eventData = provider.getTabs(
              appLocalizations,
            )[provider.index];
            final themeProvider = context.watch<AppThemeProvider>();
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
                  child: Form(
                    key: provider.formKey,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            themeProvider.isLight
                                ? eventData.lightImage!
                                : eventData.darkImage!,
                            width: double.infinity,
                            height: size.height * 0.25,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        CategoriesTabs(
                          isPrimaryBackground: true,
                          tabs: provider.getTabs(appLocalizations),
                          selectedIndex: provider.index,
                          onTabSelected: (selectedIndex) {
                            provider.changeTabIndex(selectedIndex);
                          },
                        ),
                        SizedBox(height: size.height * 0.01),
                        CustomTextFormField(
                          controller: provider.eventTitleController,
                          titleText: appLocalizations.title,
                          hintText: appLocalizations.eventTitle,
                          prefixIcon: Icons.edit_square,
                          validator: provider.validateEventTitle,
                        ),
                        SizedBox(height: size.height * 0.01),
                        CustomTextFormField(
                          controller: provider.eventDescriptionController,
                          titleText: appLocalizations.description,
                          hintText: appLocalizations.eventDescription,
                          maxLines: 5,
                          validator: provider.validateEventDescription,
                        ),
                        SizedBox(height: size.height * 0.02),
                        DateAndTimeButton(
                          icon: Icons.date_range,
                          buttonName: provider.selectedDate != null
                              ? provider.formattedDate
                              : appLocalizations.chooseDate,
                          title: appLocalizations.selectDate,
                          buttonTap: () {
                            provider.selectDate(context);
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
                          buttonHeightPadding: 0.01,
                          buttonWidthPadding: 0,
                          centerText: true,
                          isOutlined: true,
                          arrowIcon: true,
                          leading: SquareButton(
                            color: AppColors.primaryColor,
                            child: Icon(
                              Icons.my_location_outlined,
                              size: 30,
                              color: AppColors.whiteColor,
                            ),
                          ),
                          buttonColor: AppColors.primaryColor,
                          buttonName: provider.eventLocation == null ?
                          appLocalizations.chooseEventLocation :
                          "${provider.city}/${provider.country}",
                          onButtonTap: () {
                            NavigationService.instance.pushNamed(
                              AppRouts.pickLocationScreenRoutName,
                              arguments: provider ,
                            );
                          },
                        ),
                        AppButtonComponent(
                          buttonHeightPadding: 0.01,
                          buttonWidthPadding: 0,
                          centerText: true,
                          buttonColor: AppColors.primaryColor,
                          buttonName: appLocalizations.addEvent,
                          onButtonTap: () {
                            provider.addEvent(
                              context: context,
                              appLocalizations: appLocalizations,
                              themeProvider: themeProvider,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
    );
  }
}
