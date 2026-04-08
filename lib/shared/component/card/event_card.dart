
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final EventModel eventModel ;
  final VoidCallback onFavTap ;
  const EventCard({
    super.key,
    required this.eventModel,
    required this.onFavTap,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04 , vertical: size.height*0.01),
      child: Container(
        height: size.height * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: BoxBorder.all(
            color: AppColors.primaryColor,
            width: 2
          ),
          image: DecorationImage(
              image: AssetImage(eventModel.eventImage), fit: BoxFit.cover)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsetsGeometry.all(10),
              margin: EdgeInsetsGeometry.all(7),
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(8),
                border: BoxBorder.all(
                  color: AppColors.primaryColor,
                  width: 1.5
                )
              ),
              child: Column(
                children: [
                  Text(eventModel.eventDateTime.day.toString(), style: AppStyles.bold20Primary,),
                  Text(DateFormat.MMM().format(eventModel.eventDateTime), style: AppStyles.bold16Primary,)
                ],
              )
            ),
            Container(
                padding: EdgeInsetsGeometry.all(5),
                margin: EdgeInsetsGeometry.all(5),
                decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: BorderRadius.circular(8),
                    border: BoxBorder.all(
                        color: AppColors.primaryColor,
                        width: 1.5
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(eventModel.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineLarge,),
                    ),
                    IconButton(onPressed: onFavTap ,
                      icon: eventModel.isFavorite ?
                      Icon(Icons.favorite):
                          Icon(Icons.favorite_border)
                      ,color: AppColors.primaryColor, iconSize: 30, )
                  ],
                )
            )
          ],
        ),
        ),
    );
  }
}
