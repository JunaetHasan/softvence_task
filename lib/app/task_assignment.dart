import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_assignment/ui/screens/onboarding_screen.dart';

class TaskAssignment extends StatelessWidget {
  const TaskAssignment({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: ' PlayfairDisplay'),
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}
