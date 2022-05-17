import 'dart:convert';

import 'package:buy_link/core/utilities/base_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../core/constants/strings.dart';
import '../features/core/models/user_model.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/app_dialog.dart';
import 'package:location/location.dart' as lll;

class LocationService extends BaseChangeNotifier {
  final Reader _reader;
  LocationService(this._reader) {
    // getCurrentLocation();
  }
  late double lat;
  late double lon;
  late bool serviceEnabled;
  late bool _serviceEnabled;

  lll.Location location = lll.Location();

  String getDistance({
    required double storeLat,
    required double storeLon,
  }) {
    double distance = Geolocator.distanceBetween(lat, lon, storeLat, storeLon);

    return (distance / 1000).toStringAsFixed(1);
  }

  Future<Position?> getCurrentLocation() async {
    LocationPermission permission;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      print('CAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        // return;
        print('Still not enabled....................................');
      }
    }
    // // Test if location services are enabled.
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   print('Please turn on your location...');
    //   // Geolocator.openLocationSettings();
    //   // showDialog(
    //   //   context: context,
    //   //   builder: (context) {
    //   //     return AppDialog(
    //   //       title: 'Allow location Access',
    //   //       text1: 'No',
    //   //       text2: 'Yes',
    //   //       onText2Pressed: () => Geolocator.openLocationSettings(),
    //   //     );
    //   //   },
    //   // );
    //   await Geolocator.openLocationSettings();
    //   if (!serviceEnabled) {
    //     print('Still not enabled....................................');
    //   }
    //   // openAppSettings();
    //   // await Permission.location.shouldShowRequestRationale;
    //   // return Future.error('Location services are disabled.');
    // }

    print('Passed await Geolocator.openLocationSettings();');
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        openAppSettings();
        // return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      openAppSettings();
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
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
