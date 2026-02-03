import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LocationPermissionService {
  static Future<bool> requestLocationPermission() async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      Fluttertoast.showToast(
        msg: "Location permission granted ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return true;
    } else if (status.isDenied) {
      Fluttertoast.showToast(
        msg: "Location permission denied ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return false;
    } else if (status.isPermanentlyDenied) {
      Fluttertoast.showToast(
        msg:
            "Location permission permanently denied. Please enable it from settings ⚠️",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      openAppSettings();
      return false;
    }
    return false;
  }
}
