import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_assignment/onborading_text/texts.dart';
import 'package:task_assignment/ui/screens/home_page.dart';
import 'package:task_assignment/utils/app_icons.dart';
import 'package:task_assignment/utils/app_image.dart';
import 'package:task_assignment/helper_functions/location_permission_service.dart';
import '../../utils/app_color.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        // height: 462,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [AppColor.backgroundColor, AppColor.liner],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  Texts.title3,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 34,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Text(
                  Texts.subtitle3,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 94),
                Image(
                  image: AssetImage(AppImage.image4),
                  width: 300,
                  height: 215,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 100),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(57),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 13),
                    side: BorderSide(color: Colors.grey.withAlpha(150)),
                  ),
                  onPressed: () async {
                    bool granted =
                        await LocationPermissionService.requestLocationPermission();
                    if (granted) {
                      print("Location granted");
                    } else {
                      print("Location denied");
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //SizedBox(height: 80,),
                      Text(
                        'Use Current Location',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 10),
                      Image(image: AssetImage(AppIcons.location), width: 20),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.buttonColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 13),
                    ),
                    onPressed: () {
                      Get.to(() => HomePage());
                    },
                    child: Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
