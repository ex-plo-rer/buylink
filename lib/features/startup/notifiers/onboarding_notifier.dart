import 'dart:ui';

import 'package:buy_link/core/constants/strings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/colors.dart';
import '../../../core/routes.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../services/local_storage_service.dart';
import '../../../services/navigation_service.dart';

class OnBoardContent {
  final String imgString;
  final String description;

  OnBoardContent(this.imgString, this.description);
}

class OnboardingNotifier extends BaseChangeNotifier {
  final Reader _reader;

  OnboardingNotifier(this._reader);

  int _currentPage = 0;
  int get currentPage => _currentPage;
  int _totalPage = 3;
  int get totalPage => _totalPage;
  static Color dotColor = AppColors.shade3;


  void moveForward() async {
    if (_currentPage < _totalPage + 1) {
      _currentPage += 1;
      print('_currentPage: $_currentPage');
    }
    notifyListeners();
  }

  void moveBackward() {
    if (_currentPage > 1) {
      _currentPage -= 1;
      print('_currentPage: $_currentPage');
    }
    notifyListeners();
  }



  void changePage(int page) {
    _currentPage = page;
    dotColor = AppColors.primaryColor;
    notifyListeners();
  }

  void nextPage() {
    if (_currentPage < 4) {
      _currentPage++;
      notifyListeners();
    }
  }

  void exitOnboard({required bool toSignUp}) {
    _reader(localStorageService)
        .writeSecureData(AppStrings.onboardedKey, 'true');
    toSignUp
        ? _reader(navigationServiceProvider)
        .navigateOffAllNamed(Routes.signup, (p0) => false)
        : _reader(navigationServiceProvider)
        .navigateOffAllNamed(Routes.login, (p0) => false);
  }

  List<OnBoardContent> onBoardingProvContents = [
    OnBoardContent("assets/images/walkthrough1.png",
        "\n Search for anything you want to buy"),
    OnBoardContent("assets/images/walkthrough2.png",
        "\n Locate stores around you that have what you want"),
    OnBoardContent("assets/images/walkthrough3.png",
        "Make your products & services instanly visible to everybody"),
  ];
}

final onboardProv =
ChangeNotifierProvider((ref) => OnboardingNotifier(ref.read));