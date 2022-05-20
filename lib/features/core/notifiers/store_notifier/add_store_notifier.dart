import 'dart:io';

import 'package:buy_link/repositories/store_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/alertify.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../../../services/base/network_exception.dart';

class AddStoreNotifier extends BaseChangeNotifier {
  final Reader _reader;

  AddStoreNotifier(this._reader);
  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _totalPage = 4;
  int get totalPage => _totalPage;

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
        lon: lon,
        lat: lat,
        storeLogo: storeLogo,
        storeImage: storeImage,
      );
      // TODO: Refresh or call fetchStore wherever this is being called...
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify().error();
    } finally {
      setState(state: ViewState.idle);
    }
  }
}

final addStoreNotifierProvider = ChangeNotifierProvider<AddStoreNotifier>(
  (ref) => AddStoreNotifier(ref.read),
);
