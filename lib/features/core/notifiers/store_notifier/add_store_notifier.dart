import 'dart:io';

import 'package:buy_link/repositories/store_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../services/base/network_exception.dart';
import '../../../../services/location_service.dart';

class AddStoreNotifier extends BaseChangeNotifier {
  final Reader _reader;

  AddStoreNotifier(this._reader);

  int _currentPage = 1;

  int get currentPage => _currentPage;

  int _totalPage = 4;

  int get totalPage => _totalPage;

  double _storeLat = 0;
  double _storeLon = 0;

  double get storeLat => _storeLat;

  double get storeLon => _storeLon;

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

  void moveBackward() {
    if (_currentPage > 1) {
      _currentPage -= 1;
      print('_currentPage: $_currentPage');
    }
    notifyListeners();
  }

  void moveForward() async {
    if (_currentPage < _totalPage) {
      _currentPage += 1;
      print('_currentPage: $_currentPage');
    }
    notifyListeners();
  }

  String? imageFile;
  String? logoFile;

  void setImageFile({
    required String imageFile,
    required bool isImage,
  }) {
    if (isImage) {
      this.imageFile = imageFile;
    } else {
      logoFile = imageFile;
    }
    print('this.imageFile: ${this.imageFile}');
    print('this.logoFile: $logoFile');
    notifyListeners();
  }

  void onNameChanged(String text) {
    notifyListeners();
  }

  void onDescriptionChanged(String text) {
    notifyListeners();
  }

  Future<void> createStore({
    required String storeName,
    required String storeDescription,
    required double lon,
    required double lat,
    required String storeLogo,
    required String storeImage,
  }) async {
    try {
      setState(state: ViewState.loading);
      await _reader(storeRepository).createStore(
        storeName: storeName,
        storeDescription: storeDescription,
        lon: _storeLon,
        lat: _storeLat,
        storeLogo: storeLogo,
        storeImage: storeImage,
      );
      // TODO: Refresh or call fetchStore wherever this is being called...
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify().error();
    } finally {
      //setState(state: ViewState.idle);
    }
  }
}

final addStoreNotifierProvider = ChangeNotifierProvider<AddStoreNotifier>(
  (ref) => AddStoreNotifier(ref.read),
);
