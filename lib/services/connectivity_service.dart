import 'dart:async';

import 'package:buy_link/core/utilities/base_change_notifier.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart' as lll;
import 'package:permission_handler/permission_handler.dart';

class ConnectivityService extends BaseChangeNotifier {
  final Reader _reader;

  ConnectivityService(this._reader) {
    checkConnection();
  }

  bool _hasConnection = false;
  bool get hasConnection => _hasConnection;

  Future<void> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print('No internet connection:::::::::');
      _hasConnection = false;
      notifyListeners();
      return;
    } else {
      _hasConnection = true;
      notifyListeners();
    }
    // if (connectivityResult == ConnectivityResult.mobile) {
    //   ConnectivityResult.bluetooth;
    //   // I am connected to a mobile network.
    // } else if (connectivityResult == ConnectivityResult.wifi) {
    //   // I am connected to a wifi network.
    // }
  }
}

final locationService = ChangeNotifierProvider<ConnectivityService>(
    (ref) => ConnectivityService(ref.read));
