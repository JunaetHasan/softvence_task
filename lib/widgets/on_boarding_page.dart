import 'package:flutter/material.dart';
import 'package:task_assignment/utils/app_color.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });
  final String image;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [AppColor.backgroundColor, AppColor.liner],
        ),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            child: Image.asset(
              image,
              width: double.infinity,
              height: 459,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 15),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              subTitle,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
