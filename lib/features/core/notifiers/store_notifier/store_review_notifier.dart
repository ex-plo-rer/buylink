import 'package:buy_link/core/utilities/alertify.dart';
import 'package:buy_link/features/core/models/reviews_model.dart';
import 'package:buy_link/repositories/core_repository.dart';
import 'package:buy_link/services/base/network_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../models/review_stats_model.dart';

class StoreReviewNotifier extends BaseChangeNotifier {
  final Reader _reader;
  final int storeId;

  StoreReviewNotifier(this._reader, {required this.storeId}) {
    fetchReviewStats(storeId: storeId);
    fetchReviews(storeId: storeId);
  }

  bool _reviewStatsLoading = false;
  bool get reviewStatsLoading => _reviewStatsLoading;

  ReviewStatsModel? _reviewStats;
  ReviewStatsModel? get reviewStats => _reviewStats;

  bool _reviewsLoading = false;
  bool get reviewsLoading => _reviewsLoading;

  List<ReviewsModel> _reviews = [];
  List<ReviewsModel> get reviews => _reviews;

  Future<void> fetchReviewStats({
    required int storeId,
  }) async {
    try {
      _reviewStatsLoading = true;
      setState(state: ViewState.loading);
      _reviewStats = await _reader(coreRepository).fetchReviewStats(
        storeId: storeId,
      );
      _reviewStatsLoading = false;
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      _reviewStatsLoading = false;
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {
      _reviewStatsLoading = false;
      setState(state: ViewState.idle);
    }
  }

  Future<void> fetchReviews({
    required int storeId,
  }) async {
    try {
      _reviewsLoading = true;
      setState(state: ViewState.loading);
      _reviews = await _reader(coreRepository).fetchReviews(
        storeId: storeId,
      );

      _reviewsLoading = false;
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      _reviewsLoading = false;
      setState(state: ViewState.error);
      Alertify(title: e.error!).error();
    } finally {
      _reviewsLoading = false;
      setState(state: ViewState.idle);
    }
  }
}

final storeReviewNotifierProvider =
    ChangeNotifierProvider.family<StoreReviewNotifier, int>(
  (ref, storeId) => StoreReviewNotifier(ref.read, storeId: storeId),
);
