import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../utils/app_color.dart';

class FetchRealLocation extends StatefulWidget {
  const FetchRealLocation({super.key});

  @override
  State<FetchRealLocation> createState() => _FetchRealLocationState();
}

class _FetchRealLocationState extends State<FetchRealLocation> {
  String selectedLocation = "Fetching location...";
  bool isLoading = false;
  Future<void> fetchRealLocation() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        selectedLocation = "Permission denied";
        isLoading = false;
      });
      return;
    }

    // Force fetch new location
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true,
      timeLimit: Duration(seconds: 10),
    );

    print("LAT: ${position.latitude}, LNG: ${position.longitude}");

    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    final p = placemarks.first;

    setState(() {
      selectedLocation =
          " ${p.locality}, "
          "${p.country} ";

      isLoading = false;
    });

    print("Location updated: $selectedLocation");
    @override
    void initState() {
      super.initState();
      fetchRealLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          selectedLocation,
          //'Selected Location',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 16),
        GestureDetector(
          onTap: () async {
            print("LOCATION BUTTON TAPPED");

            setState(() {
              isLoading = true;
            });

            try {
              final position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.best,
                forceAndroidLocationManager: true,
                timeLimit: Duration(seconds: 10),
              );

              print("LAT: ${position.latitude}, LNG: ${position.longitude}");

              final placemarks = await placemarkFromCoordinates(
                position.latitude,
                position.longitude,
              );
              final p = placemarks.first;

              setState(() {
                selectedLocation =
                    "${p.street}, ${p.subLocality}, ${p.locality}, ${p.country} ";

                isLoading = false;
              });

              print("Location updated: $selectedLocation");
            } catch (e) {
              print("Error fetching location: $e");
              setState(() {
                isLoading = false;
              });
            }
          },

          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 70,
            decoration: BoxDecoration(
              color: Color(0XFF201A43),
              borderRadius: BorderRadius.circular(60),
            ),
            child: Row(
              children: [
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: AppColor.buttonColor,

                          color: AppColor.backgroundColor,
                        ),
                      )
                    : SizedBox(width: 5),
                Image(
                  image: AssetImage('assets/icon/location-05.png'),
                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 2),
                Text(
                  "Add your location",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
