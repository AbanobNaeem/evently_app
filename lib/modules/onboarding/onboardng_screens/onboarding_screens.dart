import 'package:dots_indicator/dots_indicator.dart';
import 'package:evently_app/shared/component/buttons_component/circle_button_component.dart';
import 'package:evently_app/shared/component/navigator_component/navigators.dart';
import 'package:evently_app/shared/data/local/cash_helper.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routs.dart';
import 'package:evently_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/app_assets.dart';

class OnboardingModel {
  final String onboardingImage;
  final String title;
  final String description;

  OnboardingModel({
    required this.onboardingImage,
    required this.title,
    required this.description,
  });
}

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  final PageController _pageController = PageController();
  double currentPage = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var appLocalizations = AppLocalizations.of(context)!;

    List<OnboardingModel> onboardingScreens = [
      OnboardingModel(
        onboardingImage: AppAssets.onboarding1,
        title: appLocalizations.onboardingFirstTitle,
        description: appLocalizations.onboardingFirstBody,
      ),
      OnboardingModel(
        onboardingImage: AppAssets.onboarding2,
        title: appLocalizations.onboardingSecondTitle,
        description: appLocalizations.onboardingSecondBody,
      ),
      OnboardingModel(
        onboardingImage: AppAssets.onboarding3,
        title: appLocalizations.onboardingThirdTitle,
        description: appLocalizations.onboardingThirdBody,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.02,
            horizontal: width * 0.04,
          ),
          child: Column(
            children: [
              Image.asset(AppAssets.eventlyLogo),

              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingScreens.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index.toDouble();
                    });
                  },
                  itemBuilder: (context, index) => onboardingPage(
                    onboardingData: onboardingScreens[index],
                    height: height,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: currentPage > 0,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: CircleButtonComponent(
                      isBack: true,
                        onButtonTap: (){
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }),
                  ),
                  DotsIndicator(
                    dotsCount: onboardingScreens.length,
                    position: currentPage,
                    decorator: DotsDecorator(
                      color: AppColors.blackColor,
                      size: const Size.square(9.0),
                      activeSize: const Size(18.0, 9.0),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  CircleButtonComponent(
                      onButtonTap: (){
                        if (currentPage < onboardingScreens.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          finishOnboarding();
                          print(CacheHelper.getBool("seenOnBoarding"));
                        }
                      }),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }

  void finishOnboarding() async {
    CacheHelper.setBool("seenOnBoarding", true);
    NavigationService.instance.pushNamed(AppRouts.loginScreenRoutName);
  }

  Widget onboardingPage({
    required OnboardingModel onboardingData,
    required double height,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: height * 0.02),
        Image.asset(
          onboardingData.onboardingImage,
          fit: BoxFit.fill,
        ),
        Text(
          onboardingData.title,
          style: AppStyles.bold20Primary,
        ),
        SizedBox(height: height * 0.02),
        Text(
          onboardingData.description,
          style: AppStyles.bold16Black,
        ),
      ],
    );
  }
}