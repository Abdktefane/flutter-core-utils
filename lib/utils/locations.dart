// import 'package:location/location.dart';

// class LocationsHelper {
//   Location location = new Location();

//   Future<bool> requestPermission() async {
//     PermissionStatus _permissionGranted;

//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.granted || _permissionGranted == PermissionStatus.grantedLimited)
//       return true;

//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();

//       if (_permissionGranted != PermissionStatus.granted) {
//         return false;
//       }
//     }
//     return false;
//   }

//   Future<bool> enableService() async {
//     bool _serviceEnabled;
//     _serviceEnabled = await location.serviceEnabled();
//     if (_serviceEnabled) return true;
//     _serviceEnabled = await location.requestService();
//     if (_serviceEnabled) {
//       return true;
//     }
//     return false;
//   }

//   Future<LocationData?> getLocation() async =>
//       (await requestPermission() && await enableService()) ? location.getLocation() : null;
// }

// /* Location location = new Location();

// bool _serviceEnabled;
// LocationData _locationData;

// _serviceEnabled = await location.serviceEnabled();
// if (!_serviceEnabled) {
//   _serviceEnabled = await location.requestService();
//   if (!_serviceEnabled) {
//     return;
//   }
// } */

// // _locationData = await location.getLocation();
