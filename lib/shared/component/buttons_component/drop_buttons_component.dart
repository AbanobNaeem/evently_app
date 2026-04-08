import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class DropButtonsComponent extends StatefulWidget {
  final String title;
  final String dropButtonTitle;
  final double buttonHeight;
  final Function(String)? onSelect;
  final String choseValueOne ;
  final String choseTitleOne;
  final String choseValueTwo ;
  final String choseTitleTwo;

  const DropButtonsComponent({
    super.key,
    required this.title,
    required this.dropButtonTitle,
    this.buttonHeight = 0.04,
    this.onSelect,
    required this.choseTitleOne ,
    required this.choseValueOne ,
    required this.choseTitleTwo ,
    required this.choseValueTwo ,

  });

  @override
  State<DropButtonsComponent> createState() => _DropButtonsComponentState();
}

class _DropButtonsComponentState extends State<DropButtonsComponent> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * widget.buttonHeight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.02,
            ),
            margin: EdgeInsets.only(top: height * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.primaryColor,
                width: 2,
              ),
            ),
            child: PopupMenuButton<String>(
              onSelected: widget.onSelect,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: height * 0.2
              ),
              color: AppColors.primaryColor,
              position: PopupMenuPosition.under,
              menuPadding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.02 ,),

              itemBuilder: (context) => [
                popupMenuItem(
                    value: widget.choseValueOne ,
                    itemChose: widget.choseTitleOne,) ,
                popupMenuItem(value: widget.choseValueTwo,
                    itemChose: widget.choseTitleTwo,) ,

              ],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.dropButtonTitle,
                    style: AppStyles.bold20Primary,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.primaryColor,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> popupMenuItem ({
    required String value,
    required String itemChose,

  }){
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return PopupMenuItem(
      value: value,
      child: Container(
        width: double.infinity,
        margin: EdgeInsetsGeometry.symmetric(vertical: height * 0.01),
        padding:EdgeInsets.symmetric(vertical: height *0.02 , horizontal: width *0.04),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.whiteColor,
            width: 2,
          ),
        ),
        child: Text(
          itemChose,
          style: AppStyles.bold20white,
        ),
      ),
    );
  }
}