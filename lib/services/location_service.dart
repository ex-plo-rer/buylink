import 'dart:convert';

import 'package:buy_link/core/utilities/base_change_notifier.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../core/constants/strings.dart';
import '../features/core/models/user_model.dart';

class LocationService extends BaseChangeNotifier {
  final Reader _reader;
  LocationService(this._reader) {
    // getCurrentLocation();
  }
  late double lat;
  late double lon;

  String getDistance({
    required double storeLat,
    required double storeLon,
  }) {
    double distance = Geolocator.distanceBetween(lat, lon, storeLat, storeLon);

    return (distance / 1000).toStringAsFixed(1);
  }

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    lat = position.latitude;
    lon = position.longitude;

    print('lat : $lat, lon : $lon.');
    notifyListeners();
    return position;
  }
}

final locationService = Provider((ref) => LocationService(ref.read));
