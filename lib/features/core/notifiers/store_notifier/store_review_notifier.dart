import 'package:buy_link/core/utilities/alertify.dart';
import 'package:buy_link/features/core/models/rating_button_model.dart';
import 'package:buy_link/features/core/models/reviews_model.dart';
import 'package:buy_link/repositories/core_repository.dart';
import 'package:buy_link/services/base/network_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/utilities/base_change_notifier.dart';
import '../../../../core/utilities/view_state.dart';
import '../../models/review_stats_model.dart';

/*Doing some really HARD JOB here lol*/

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

  List<ReviewsModel> _allReviews = [];

  List<ReviewsModel> _reviews = [];

  List<ReviewsModel> get reviews => _reviews;

  double _average = 0;

  double get average => double.parse(_average.toStringAsFixed(1));

  Color initialContainerColor = AppColors.transparent;
  Color initialTextColor = AppColors.grey6;
  Color selectedContainerColor = AppColors.shade1;
  Color selectedTextColor = AppColors.grey1;
  bool initialIsSelected = false;
  bool selectedIsSelected = true;

  late Color _containerColor0;
  late Color _textColor0;
  late bool _is0Selected;

  Color get containerColor0 => _containerColor0;

  Color get textColor0 => _textColor0;

  bool get is0Selected => _is0Selected;

  late Color _containerColor5;
  late Color _textColor5;
  late bool _is5Selected;

  Color get containerColor5 => _containerColor5;

  Color get textColor5 => _textColor5;

  bool get is5Selected => _is5Selected;

  late Color _containerColor4;
  late Color _textColor4;
  late bool _is4Selected;

  Color get containerColor4 => _containerColor4;

  Color get textColor4 => _textColor4;

  bool get is4Selected => _is4Selected;

  late Color _containerColor3;
  late Color _textColor3;
  late bool _is3Selected;

  Color get containerColor3 => _containerColor3;

  Color get textColor3 => _textColor3;

  bool get is3Selected => _is3Selected;

  late Color _containerColor2;
  late Color _textColor2;
  late bool _is2Selected;

  Color get containerColor2 => _containerColor2;

  Color get textColor2 => _textColor2;

  bool get is2Selected => _is2Selected;

  late Color _containerColor1;
  late Color _textColor1;
  late bool _is1Selected;

  Color get containerColor1 => _containerColor1;

  Color get textColor1 => _textColor1;

  bool get is1Selected => _is1Selected;

  void initColors() {
    _containerColor0 = selectedContainerColor;
    _textColor0 = selectedTextColor;
    _is0Selected = selectedIsSelected;
    _containerColor1 = initialContainerColor;
    _textColor1 = initialTextColor;
    _is1Selected = initialIsSelected;
    _containerColor2 = initialContainerColor;
    _textColor2 = initialTextColor;
    _is2Selected = initialIsSelected;
    _containerColor3 = initialContainerColor;
    _textColor3 = initialTextColor;
    _is3Selected = initialIsSelected;
    _containerColor4 = initialContainerColor;
    _textColor4 = initialTextColor;
    _is4Selected = initialIsSelected;
    _containerColor5 = initialContainerColor;
    _textColor5 = initialTextColor;
    _is5Selected = initialIsSelected;
  }

  void starTapped({required int star}) {
    if (star == 1) {
      _containerColor0 = initialContainerColor;
      _textColor0 = initialTextColor;
      _is0Selected = initialIsSelected;
      _containerColor1 = selectedContainerColor;
      _textColor1 = selectedTextColor;
      _is1Selected = selectedIsSelected;
      _containerColor2 = initialContainerColor;
      _textColor2 = initialTextColor;
      _is2Selected = initialIsSelected;
      _containerColor3 = initialContainerColor;
      _textColor3 = initialTextColor;
      _is3Selected = initialIsSelected;
      _containerColor4 = initialContainerColor;
      _textColor4 = initialTextColor;
      _is4Selected = initialIsSelected;
      _containerColor5 = initialContainerColor;
      _textColor5 = initialTextColor;
      _is5Selected = initialIsSelected;
      _reviews = _allReviews.where((review) => review.star == 1).toList();
    } else if (star == 2) {
      _containerColor0 = initialContainerColor;
      _textColor0 = initialTextColor;
      _is0Selected = initialIsSelected;
      _containerColor1 = initialContainerColor;
      _textColor1 = initialTextColor;
      _is1Selected = initialIsSelected;
      _containerColor2 = selectedContainerColor;
      _textColor2 = selectedTextColor;
      _is2Selected = selectedIsSelected;
      _containerColor3 = initialContainerColor;
      _textColor3 = initialTextColor;
      _is3Selected = initialIsSelected;
      _containerColor4 = initialContainerColor;
      _textColor4 = initialTextColor;
      _is4Selected = initialIsSelected;
      _containerColor5 = initialContainerColor;
      _textColor5 = initialTextColor;
      _is5Selected = initialIsSelected;
      _reviews = _allReviews.where((review) => review.star == 2).toList();
    } else if (star == 3) {
      _containerColor0 = initialContainerColor;
      _textColor0 = initialTextColor;
      _is0Selected = initialIsSelected;
      _containerColor1 = initialContainerColor;
      _textColor1 = initialTextColor;
      _is1Selected = initialIsSelected;
      _containerColor2 = initialContainerColor;
      _textColor2 = initialTextColor;
      _is2Selected = initialIsSelected;
      _containerColor3 = selectedContainerColor;
      _textColor3 = selectedTextColor;
      _is3Selected = selectedIsSelected;
      _containerColor4 = initialContainerColor;
      _textColor4 = initialTextColor;
      _is4Selected = initialIsSelected;
      _containerColor5 = initialContainerColor;
      _textColor5 = initialTextColor;
      _is5Selected = initialIsSelected;
      _reviews = _allReviews.where((review) => review.star == 3).toList();
    } else if (star == 4) {
      _containerColor0 = initialContainerColor;
      _textColor0 = initialTextColor;
      _is0Selected = initialIsSelected;
      _containerColor1 = initialContainerColor;
      _textColor1 = initialTextColor;
      _is1Selected = initialIsSelected;
      _containerColor2 = initialContainerColor;
      _textColor2 = initialTextColor;
      _is2Selected = initialIsSelected;
      _containerColor3 = initialContainerColor;
      _textColor3 = initialTextColor;
      _is3Selected = initialIsSelected;
      _containerColor4 = selectedContainerColor;
      _textColor4 = selectedTextColor;
      _is4Selected = selectedIsSelected;
      _containerColor5 = initialContainerColor;
      _textColor5 = initialTextColor;
      _is5Selected = initialIsSelected;
      _reviews = _allReviews.where((review) => review.star == 4).toList();
    } else if (star == 5) {
      _containerColor0 = initialContainerColor;
      _textColor0 = initialTextColor;
      _is0Selected = initialIsSelected;
      _containerColor1 = initialContainerColor;
      _textColor1 = initialTextColor;
      _is1Selected = initialIsSelected;
      _containerColor2 = initialContainerColor;
      _textColor2 = initialTextColor;
      _is2Selected = initialIsSelected;
      _containerColor3 = initialContainerColor;
      _textColor3 = initialTextColor;
      _is3Selected = initialIsSelected;
      _containerColor4 = initialContainerColor;
      _textColor4 = initialTextColor;
      _is4Selected = initialIsSelected;
      _containerColor5 = selectedContainerColor;
      _textColor5 = selectedTextColor;
      _is5Selected = selectedIsSelected;
      _reviews = _allReviews.where((review) => review.star == 5).toList();
    } else {
      _containerColor0 = selectedContainerColor;
      _textColor0 = selectedTextColor;
      _is0Selected = selectedIsSelected;
      _containerColor1 = initialContainerColor;
      _textColor1 = initialTextColor;
      _is1Selected = initialIsSelected;
      _containerColor2 = initialContainerColor;
      _textColor2 = initialTextColor;
      _is2Selected = initialIsSelected;
      _containerColor3 = initialContainerColor;
      _textColor3 = initialTextColor;
      _is3Selected = initialIsSelected;
      _containerColor4 = initialContainerColor;
      _textColor4 = initialTextColor;
      _is4Selected = initialIsSelected;
      _containerColor5 = initialContainerColor;
      _textColor5 = initialTextColor;
      _is5Selected = initialIsSelected;
      _reviews = _allReviews;
    }
    notifyListeners();
  }

  Future<void> fetchReviewStats({
    required int storeId,
  }) async {
    try {
      _reviewStatsLoading = true;
      setState(state: ViewState.loading);
      _reviewStats = await _reader(coreRepository).fetchReviewStats(
        storeId: storeId,
      );
      if (_reviewStats != null) {
        _average = ((1 * _reviewStats!.the1Star) +
                (2 * _reviewStats!.the2Star) +
                (3 * _reviewStats!.the3Star) +
                (4 * _reviewStats!.the4Star) +
                (5 * _reviewStats!.the5Star)) /
            _reviewStats!.total;
      }
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
    initColors();
    try {
      _reviewsLoading = true;
      setState(state: ViewState.loading);
      _allReviews = await _reader(coreRepository).fetchReviews(
        storeId: storeId,
      );
      _reviews = _allReviews;
      _reviewsLoading = false;
      setState(state: ViewState.idle);
    } on NetworkException catch (e) {
      _reviewsLoading = false;
      setState(state: ViewState.error);
      // Alertify(title: e.error!).error();
    } finally {
      // _reviewsLoading = false;
      // setState(state: ViewState.idle);
    }
  }
}

final storeReviewNotifierProvider =
    ChangeNotifierProvider.family.autoDispose<StoreReviewNotifier, int>(
  (ref, storeId) => StoreReviewNotifier(ref.read, storeId: storeId),
);
