import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/event_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../lang_theme_provider/theme_provider.dart';

class EventMapCard extends StatelessWidget {

  final EventModel eventModel ;
  final VoidCallback onEventTap ;
  const EventMapCard({
    super.key,
    required this.eventModel,
    required this.onEventTap});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    AppThemeProvider appThemeProvider = Provider.of<AppThemeProvider>(context);
    return  InkWell(
      onTap: onEventTap,
      child: Container(
        width: size.width *0.99,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
          color: appThemeProvider.isLight ?
              AppColors.backGroundColorLight :
          AppColors.backGroundColorDark,
        ),
        child: Row(
          spacing: 10,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                eventModel.eventImage,
                fit: BoxFit.fitWidth,
                width: size.width * 0.5,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${eventModel.title}\n${eventModel.eventDescription}",
                    style: AppStyles.bold16Primary,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                   SizedBox(height: size.height * 0.01),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 20,
                        color: AppColors.greyColor,
                      ),
                      SizedBox(width: size.width * 0.01),
                      Expanded(
                        child: Text(
                          eventModel.eventLocation,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.bold16gray,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
