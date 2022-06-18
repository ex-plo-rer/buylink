import 'dart:async';

import 'package:buy_link/features/core/models/category_model.dart';
import 'package:buy_link/features/core/models/product_attribute_model.dart';
import 'package:buy_link/features/core/models/store_quick_model.dart';
import 'package:buy_link/repositories/core_repository.dart';
import 'package:buy_link/repositories/store_repository.dart';
import 'package:buy_link/services/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../services/base/network_exception.dart';
import '../../models/product_model.dart';

class StoreDirectionNotifier extends BaseChangeNotifier {
  final Reader _reader;

  StoreDirectionNotifier(this._reader);

  double? _lat;

  double? get lat => _lat;
  double? _lon;

  double? get lon => _lon;

  void initLocation() {
    // Uses the initial location of when the app was lauched first.
    _lat = _reader(locationService).lat;
    _lon = _reader(locationService).lon;
    notifyListeners();
  }

  // Stream getLocationUpdate() {
  //   return Stream.periodic(
  //       const Duration(seconds: 1), (_) async => getLocationUpdte());
  //   // return Stream.periodic(const Duration(seconds: 5),
  //   //     (_) async => await _reader(locationService).getCurrentLocation());
  // }

  // StreamSubscription<Position> getLocationUpdte() {
  void getLocationUpdate() {
    print('Get location Updateeeeeeeeeeeeeeeeeeeeee c');
    initLocation();
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 0,
    );
    // StreamSubscription<Position> positionStream =
    Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position? position) {
        print('Get location Updateeeeeeeeeeeeeeeeeeeeee called');
        print(position == null
            ? 'positionStream Unknown'
            : 'positionStream : ${position.latitude.toString()}, ${position.longitude.toString()}');
        _lat = position?.latitude;
        _lon = position?.longitude;
        print('Get location Updateeeeeeeeeeeeeeeeeeeeee end');
        notifyListeners();
      },
    );
  }
}

final storeDirectionNotifierProvider =
    ChangeNotifierProvider<StoreDirectionNotifier>(
  (ref) => StoreDirectionNotifier(ref.read),
);
