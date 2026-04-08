import 'package:evently_app/shared/component/text_form_field/custom_text_form_field.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../shared/component/card/event_card.dart';
import '../../utils/app_colors.dart';

class LoveScreen extends StatelessWidget {
  const LoveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var appLocalizations = AppLocalizations.of(context)!;
    return SafeArea(
      child: Column(
        children: [
          CustomTextFormField(
            validator: (value){

            },
            outlineColor: AppColors.primaryColor,
            cursorColor: AppColors.primaryColor,
             searchStyle: AppStyles.bold20Primary,
             iconColor: AppColors.primaryColor,
              hintStyle: AppStyles.bold20Primary,
              height: size.height * 0.02,
              width: size.width * 0.04,
              controller: TextEditingController(),
              hintText: appLocalizations.search,
              prefixIcon: Icons.search,
              keyboardType: TextInputType.text,
              obscureText: false),
          Expanded(child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder:(context, index) =>  Container(),
              separatorBuilder:(context, index) => SizedBox(height: size.height * 0.01,),
              itemCount: 20)),
        ],
      ),
    );
  }
}
