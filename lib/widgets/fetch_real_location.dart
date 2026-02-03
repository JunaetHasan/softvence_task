import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:task_assignment/utils/app_icons.dart';

class FetchRealLocation extends StatefulWidget {
  const FetchRealLocation({super.key});

  @override
  State<FetchRealLocation> createState() => _FetchRealLocationState();
}

class _FetchRealLocationState extends State<FetchRealLocation> {
  String selectedLocation = "Fetching location...";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchRealLocation();
  }

  Future<void> fetchRealLocation() async {
    if (isLoading) return;

    setState(() => isLoading = true);

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

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true,
      timeLimit: const Duration(seconds: 10),
    );

    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    final p = placemarks.first;

    setState(() {
      selectedLocation = "${p.locality}, ${p.country}";
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          selectedLocation,
          style: const TextStyle(color: Colors.white, fontSize: 26),
        ),
        SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0XFF201A43),
            borderRadius: BorderRadius.circular(60),
          ),
          child: Row(
            children: [
              Image(image: AssetImage(AppIcons.location),width: 24,),
              SizedBox(width: 10,),
              Text('Add your location',style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
              ),)
            ],
          ),
        ),
      ],
    );
  }
}
