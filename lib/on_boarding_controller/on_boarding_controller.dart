import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_assignment/ui/screens/location_page.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  final pageController = PageController();
  RxInt currentIndex = 0.obs;

  void updatePageIndicator(index) {
    currentIndex.value = index;
  }

  void dotNavigationClick(index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  void nextPage() {
    if (currentIndex.value == 2) {
      Get.to(() => LocationPage());
      return;
    }

    //currentIndex.value = currentIndex.value+1;
    currentIndex.value++;
    pageController.jumpToPage(currentIndex.value);
  }

  void skipPage() {
    Get.to(() => LocationPage());
    //currentIndex.value = LocationPage() ;
    pageController.jumpToPage(currentIndex.value);
  }
}
