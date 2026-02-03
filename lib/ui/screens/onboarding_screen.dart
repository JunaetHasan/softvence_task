import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:task_assignment/onborading_text/texts.dart';
import 'package:task_assignment/utils/app_image.dart';

import '../../on_boarding_controller/on_boarding_controller.dart';
import '../../widgets/on_boarding_dot_navigator.dart';
import '../../widgets/on_boarding_next_botton.dart';
import '../../widgets/on_boarding_page.dart';
import '../../widgets/on_boarding_skip_botton.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final OnBoardingController controller = Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                image: AppImage.image1,
                title: Texts.title,
                subTitle: Texts.subtitle,
              ),
              OnBoardingPage(
                image: AppImage.image2,
                title: Texts.title1,
                subTitle: Texts.subtitle1,
              ),
              OnBoardingPage(
                image: AppImage.image3,
                title: Texts.title2,
                subTitle: Texts.subtitle2,
              ),
            ],
          ),

          OnBoardingDotNavigator(),

          OnBoardingNextBotton(),

          OnBoardingSkipBotton(),
        ],
      ),
    );
  }
}
