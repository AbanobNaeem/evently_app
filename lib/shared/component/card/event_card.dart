
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Container(
        height: size.height * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: BoxBorder.all(
            color: AppColors.primaryColor,
            width: 2
          ),
          image: DecorationImage(image: AssetImage(AppAssets.eventlyLogo2), fit: BoxFit.cover)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsetsGeometry.all(10),
              margin: EdgeInsetsGeometry.all(5),
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
                  Text("20", style: AppStyles.bold20Primary,),
                  Text("May", style: AppStyles.bold16Primary,)
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
                      child: Text("Ay kalam fe elbetngan",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineLarge,),
                    ),
                    IconButton(onPressed: (){}, icon:Icon(Icons.favorite),color: AppColors.primaryColor, iconSize: 30, )
                  ],
                )
            )
          ],
        ),
        ),
    );
  }
}
