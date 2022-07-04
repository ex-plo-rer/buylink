import 'dart:async';

import 'package:buy_link/core/utilities/base_change_notifier.dart';
import 'package:buy_link/features/core/models/auto_complete_model.dart';
import 'package:buy_link/features/core/models/search_result_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../repositories/core_repository.dart';
import '../../../../repositories/store_repository.dart';
import '../../../../services/base/network_exception.dart';
import '../../../../services/location_service.dart';
import '../../../../services/navigation_service.dart';

class StoreLocationPickerNotifier extends BaseChangeNotifier {
  final Reader _reader;

  StoreLocationPickerNotifier(this._reader);

  double _storeLat = 0;
  double _storeLon = 0;

  double get storeLat => _storeLat;

  double get storeLon => _storeLon;

  Timer? timer;

  bool _showInstruction = true;

  bool get showInstruction => _showInstruction;

  void initLocation() {
    // // Uses the initial location of when the app was lauched first.
    _storeLat = _reader(locationService).lat!;
    _storeLon = _reader(locationService).lon!;
    notifyListeners();
  }

  void setStorePosition({
    required double lat,
    required double lon,
  }) {
    _storeLat = lat;
    _storeLon = lon;
    notifyListeners();
  }

  void startTimer() async {
    await Future.delayed(const Duration(seconds: 2));
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print(timer.tick);
      if (timer.tick == 10) {
        print(timer.tick);
        timer.cancel();
        _showInstruction = false;
        notifyListeners();
      }
    });
  }
}

final storeLocationPickerNotifierProvider =
    ChangeNotifierProvider<StoreLocationPickerNotifier>(
        (ref) => StoreLocationPickerNotifier(ref.read));
