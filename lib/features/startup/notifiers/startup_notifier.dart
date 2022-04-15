import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/strings.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/view_state.dart';
import '../../../services/base/network_exception.dart';

class StartupNotifier extends BaseChangeNotifier {
  final Reader _reader;
  String? isOnboarded;
  String? lastPlace;
  // UserModel? user;

  StartupNotifier(this._reader) {
    // decideNavigation();
  }

  // Future<void> decideNavigation() async {
  //   print('decideNavigation called');
  //   // Check if user is onboarded...
  //   // isOnboarded = await _reader(localStorageService)
  //   //     .readSecureData(AppStrings.onboardedKey);
  //
  //   // Initialize the user and the auth token
  //   // for usage across the app...
  //   await _reader(userProvider).setUser();
  //   await _reader(userProvider).setToken();
  //   user = _reader(userProvider).currentUser;
  //   // user = await _reader(userProvider).getUser();
  //   lastPlace = await _reader(localStorageService)
  //       .readSecureData(AppStrings.lastPlaceKey);
  //   // _reader(userProvider);
  //
  //   await Future.delayed(const Duration(seconds: 2));
  //   print('Last place is $lastPlace');
  //
  //   if (isOnboarded == null || isOnboarded != 'true') {
  //     _reader(navigationServiceProvider)
  //         .navigateOffAllNamed(Routes.onboardingView, (route) => false);
  //   } else {
  //     if (user == null) {
  //       print('User is null');
  //       _reader(navigationServiceProvider)
  //           .navigateOffAllNamed(Routes.modeView, (route) => false);
  //     } else {
  //       if (user!.isSubscribed) {
  //         if (lastPlace == Mode.author.name) {
  //           _reader(navigationServiceProvider).navigateOffAllNamed(
  //               Routes.dashboardViewAuthor, (route) => false);
  //         } else if (lastPlace == Mode.reader.name) {
  //           _reader(navigationServiceProvider)
  //               .navigateOffAllNamed(Routes.dashboardView, (route) => false);
  //         } else {
  //           print('User is not null but last place is null');
  //           _reader(navigationServiceProvider)
  //               .navigateOffAllNamed(Routes.modeView, (route) => false);
  //         }
  //       } else {
  //         print('User is not subscribed');
  //         _reader(navigationServiceProvider).navigateOffAllNamed(
  //             Routes.subscriptionListView, (route) => false);
  //       }
  //     }
  //   }
  // }

  // Future<void> getUser() async {
  //   try {
  //     setState(state: ViewState.loading);
  //     await _reader(profileRepository).getUser();
  //     setState(state: ViewState.idle);
  //   } on NetworkException catch (e) {
  //     setState(state: ViewState.error);
  //     // _reader(snackbarService).showErrorSnackBar(e.error!);
  //   } finally {
  //     setState(state: ViewState.idle);
  //   }
  // }
}

final startUpNotifierProvider =
    ChangeNotifierProvider<StartupNotifier>((ref) => StartupNotifier(ref.read));
