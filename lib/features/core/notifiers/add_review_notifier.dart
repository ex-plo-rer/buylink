import 'package:buy_link/core/utilities/alertify.dart';
import 'package:buy_link/repositories/core_repository.dart';
import 'package:buy_link/services/base/network_exception.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';

class AddReviewNotifier extends BaseChangeNotifier {
  final Reader _reader;

  AddReviewNotifier(this._reader);

  int _titleCharacters = 100;
  int get titleCharacters => _titleCharacters;
  int _commentCharacters = 300;
  int get commentCharacters => _commentCharacters;

  double _rating = 0;
  double get rating => _rating;

  void onRatingUpdate(double rating) {
    _rating = rating;
    notifyListeners();
  }

  void onTitleChanged(String text) {
    print(text);
    _titleCharacters = 100 - text.length;
    notifyListeners();
  }

  void onCommentChanged(String text) {
    print(text);
    _commentCharacters = 300 - text.length;
    notifyListeners();
  }

  void watchChar(bool isTitle) {
    if (isTitle) {}
  }

  Future<void> addReview({
    required int storeId,
    required double star,
    String? title,
    String? body,
  }) async {
    try {
      setState(state: ViewState.loading);
      await _reader(coreRepository).addReview(
        storeId: storeId,
        star: star,
        title: title,
        body: body,
      );
      Alertify(title: 'Store Reviewed!!! Thanks').success();
      _reader(navigationServiceProvider).navigateBack();
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {
      setState(state: ViewState.idle);
    }
  }
}

final addReviewNotifierProvider = ChangeNotifierProvider<AddReviewNotifier>(
  (ref) => AddReviewNotifier(ref.read),
);
