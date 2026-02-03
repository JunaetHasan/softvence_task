import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../on_boarding_controller/on_boarding_controller.dart';

class OnBoardingDotNavigator extends StatelessWidget {
  OnBoardingDotNavigator({super.key});

  final OnBoardingController controller = OnBoardingController.instance;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 150,
      left: 190,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
        effect: WormEffect(
          spacing: 10,
          dotHeight: 10,
          dotWidth: 10,
          dotColor: Colors.grey.shade800,
          activeDotColor: Colors.blue,
          radius: 50,
          type: WormType.normal, // active dot animation
        ),
      ),
    );
  }
}
