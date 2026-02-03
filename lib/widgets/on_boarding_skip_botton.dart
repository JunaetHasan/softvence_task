import 'package:flutter/material.dart';


import '../on_boarding_controller/on_boarding_controller.dart';

class OnBoardingSkipBotton extends StatelessWidget {
  OnBoardingSkipBotton({
    super.key,
  });
  final OnBoardingController controller = OnBoardingController.instance;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 340,
      child: TextButton(
        onPressed: controller.skipPage,
        child:Text('Skip', style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
        fontSize: 16)),

      ),
    );
  }
}