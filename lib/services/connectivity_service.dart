import 'dart:async';

import 'package:buy_link/core/utilities/base_change_notifier.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart' as lll;
import 'package:permission_handler/permission_handler.dart';

class LocationService extends BaseChangeNotifier {
  final Reader _reader;

  LocationService(this._reader) {
    // getCurrentLocation();
  }

  double? _lat;

  double? get lat => _lat;
  double? _lon;

  double? get lon => _lon;
  late bool serviceEnabled;
  late bool _serviceEnabled;

  lll.Location location = lll.Location();

  void updateLocationAfterLeavingMap({
    required double newLat,
    required double newLon,
  }) {
    print('Old lat: $_lat, Old lon: $_lon');
    _lat = newLat;
    _lon = newLon;
    print('Updated lat: $_lat, Updated lon: $_lon');
  }

  String getDistance({
    required double endLat,
    required double endLon,
  }) {
    print('Get distance called');
    double distance = Geolocator.distanceBetween(_lat!, _lon!, endLat, endLon);
    notifyListeners();
    return (distance / 1000).toStringAsFixed(1);
  }

  String getDist({
    required double endLat,
    required double endLon,
  }) {
    double distance = Geolocator.distanceBetween(_lat!, _lon!, endLat, endLon);

    return (distance / 1000).toStringAsFixed(1);
    // return (distance).toString();
  }

  Future<void> getCurrentLocation() async {
    print('Get current location called...................');
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

    _lat = position.latitude;
    _lon = position.longitude;

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );
    // StreamSubscription<Position> positionStream =
    Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position? position) {
        print(position == null
            ? 'positionStream Unknown'
            : 'positionStream : ${position.latitude.toString()}, ${position.longitude.toString()}');

        _lat = position?.latitude;
        _lon = position?.longitude;
        print('lat : $_lat, lon : $_lon.');
        notifyListeners();
      },
    );

    print('lat : $_lat, lon : $_lon.');
    print('Get current location left...................');
    notifyListeners();
    // return position;
  }
}

final locationService =
    ChangeNotifierProvider<LocationService>((ref) => LocationService(ref.read));
