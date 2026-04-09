import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:evently_app/shared/component/text_form_field/custom_text_form_field.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/component/card/event_card.dart';
import '../../../shared/component/navigator_component/navigators.dart';
import '../../../shared/providers/love_provider/love_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_routs.dart';

class LoveScreen extends StatelessWidget {
  const LoveScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var appLocalizations = AppLocalizations.of(context)!;
    var loveProvider = Provider.of<LoveProvider>(context);
    return SafeArea(
      child: Column(
        children: [
          CustomTextFormField(
            onChange: (value){
              loveProvider.searchEvents(searchEvent: value) ;
            },
            outlineColor: AppColors.primaryColor,
            cursorColor: AppColors.primaryColor,
            searchStyle: AppStyles.bold20Primary,
            iconColor: AppColors.primaryColor,
            hintStyle: AppStyles.bold20Primary,
            height: size.height * 0.02,
            width: size.width * 0.04,
            hintText: appLocalizations.search,
            prefixIcon: Icons.search,
            keyboardType: TextInputType.text,
            obscureText: false,
          ),
          ConditionalBuilder(
            condition: loveProvider.searchedEvents.isNotEmpty,
            builder: (context) => Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: loveProvider.searchedEvents.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: size.height * 0.01),
                itemBuilder: (context, index) {
                  final event = loveProvider.searchedEvents[index];
                  return EventCard(
                    onCardTap: () async {
                      final result = await NavigationService.instance.pushNamed(
                        AppRouts.eventDetailsScreenRoutName,
                        arguments: event,
                      );
                      if (result == true) {
                        loveProvider.getFavoriteEvents();
                      }
                    },
                    eventModel: event,
                    onFavTap: () {
                      loveProvider.toggleFavorite(event);
                    },
                  );
                },
              ),
            ),
            fallback: (context) => Expanded(
              child: Center(
                child: Text(
                  "You don't have any Favourite events yet",
                  style: AppStyles.bold20Primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
