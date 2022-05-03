import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';

class StoreReviewNotifier extends BaseChangeNotifier {
  final Reader _reader;

  StoreReviewNotifier(this._reader) {
  }


}

final storeReviewNotifierProvider =
ChangeNotifierProvider<StoreReviewNotifier>((ref) => StoreReviewNotifier(ref.read));
