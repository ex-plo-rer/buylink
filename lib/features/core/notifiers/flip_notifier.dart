import 'package:buy_link/core/constants/strings.dart';
import 'package:buy_link/features/core/models/product_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/routes.dart';
import '../../../core/utilities/alertify.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';
import '../../../repositories/core_repository.dart';
import '../../../services/base/network_exception.dart';
import '../../../services/local_storage_service.dart';
import '../../../services/navigation_service.dart';

class FlipNotifier extends BaseChangeNotifier {
  final Reader _reader;

  FlipNotifier(this._reader);

  bool _addingToCompare = false;

  bool get addingToCompare => _addingToCompare;
  bool _successfullyAdded = false;

  bool get successfullyAdded => _successfullyAdded;

  Future<void> addItemToCompare({
    required int productId,
  }) async {
    try {
      _addingToCompare = true;
      setState(state: ViewState.loading);
      _successfullyAdded =
          await _reader(coreRepository).addItemToCompare(productId: productId);
      _addingToCompare = false;
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      _addingToCompare = false;
      setState(state: ViewState.error);
      Alertify(title: e.error).error();
    } finally {
      //Do something...
    }
  }
}

final flipNotifierProvider = Provider<FlipNotifier>(
  (ref) => FlipNotifier(ref.read),
);
