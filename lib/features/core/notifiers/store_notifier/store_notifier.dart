import 'package:buy_link/core/utilities/alertify.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/features/core/models/my_store_model.dart';
import 'package:buy_link/repositories/store_repository.dart';
import 'package:buy_link/services/base/network_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class StoreNotifier extends BaseChangeNotifier {
  final Reader _reader;

  StoreNotifier(this._reader) {
    fetchMyStores();
  }

  List<MyStoreModel> _myStores = [];
  List<MyStoreModel> get myStores => _myStores;

  Future<void> fetchMyStores() async {
    try {
      setState(state: ViewState.loading);
      _myStores = await _reader(storeRepository).fetchMyStores();
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify().error();
    } finally {
      setState(state: ViewState.idle);
    }
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

final storeNotifierProvider =
    ChangeNotifierProvider<StoreNotifier>((ref) => StoreNotifier(ref.read));
