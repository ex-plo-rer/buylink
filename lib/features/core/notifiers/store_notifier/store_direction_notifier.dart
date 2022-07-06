import 'package:buy_link/services/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class StoreDirectionNotifier extends BaseChangeNotifier {
  final Reader _reader;

  StoreDirectionNotifier(this._reader);

  double? _userLat;
  double? get userLat => _userLat;

  double? _userLon;
  double? get userLon => _userLon;

  void initLocation() {
    // Uses the initial location of when the app was lauched first.
    _userLat = _reader(locationService).lat;
    _userLon = _reader(locationService).lon;
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
        _userLat = position?.latitude;
        _userLon = position?.longitude;
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
