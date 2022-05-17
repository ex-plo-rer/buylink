import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

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
}

final addStoreNotifierProvider = ChangeNotifierProvider<AddStoreNotifier>(
  (ref) => AddStoreNotifier(ref.read),
);
