import 'package:buy_link/features/core/views/home_view.dart';
import 'package:buy_link/features/core/views/notification_view/notification_view.dart';
import 'package:buy_link/features/core/views/settings_view/setting_view.dart';
import 'package:buy_link/features/core/views/store_views/store_view.dart';
import 'package:buy_link/features/core/views/wishlist_view.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/svgs.dart';
import '../../../widgets/auth_dialog.dart';
import '../notifiers/dashboard_notifier.dart';
import '../notifiers/user_provider.dart';

class DashboardView extends ConsumerWidget {
  DashboardView({
    Key? key,
    this.index,
    this.fromLoginOrSignup = false,
  }) : super(key: key);

  bool fromLoginOrSignup;
  final int? index;

  @override
  Widget build(BuildContext context, ref) {
    final dashboardNotifier = ref.watch(dashboardChangeNotifier);
    return WillPopScope(
      onWillPop: () async {
        // if (dashboardNotifier.selectedIndex == 0) return true;
        if (dashboardNotifier.navigationQueue.isEmpty) return true;
        // dashboardNotifier.selectedIndex = dashboardNotifier.navigationQueue.last;
        dashboardNotifier.willPopM();
        return false;
      },
      child: Scaffold(
        body: [
          HomeView(fromLoginOrSignup: fromLoginOrSignup),
          ref.watch(userProvider).currentUser == null
              ? const AuthDialog(onNav: true)
              : const WishlistView(),
          ref.watch(userProvider).currentUser == null
              ? const AuthDialog(onNav: true)
              : const StoreView(),
          ref.watch(userProvider).currentUser == null
              ? const AuthDialog(onNav: true)
              : const NotificationView(),
          ref.watch(userProvider).currentUser == null
              ? const AuthDialog(onNav: true)
              : const SettingView(),
        ][dashboardNotifier.selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: dashboardNotifier.selectedIndex,
          onTap: dashboardNotifier.onBottomNavTapped,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.grey5,
          elevation: 7,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            color: AppColors.primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            color: AppColors.grey5,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(dashboardNotifier.selectedIndex == 0
                  ? AppSvgs.homeFilled
                  : AppSvgs.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                dashboardNotifier.selectedIndex == 1
                    ? AppSvgs.favBFilled
                    : AppSvgs.favorite2,
              ),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                dashboardNotifier.selectedIndex == 2
                    ? AppSvgs.storeFilled
                    : AppSvgs.store,
              ),
              label: 'My Stores',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  SvgPicture.asset(
                    dashboardNotifier.selectedIndex == 3
                        ? AppSvgs.bellFilled
                        : AppSvgs.bell,
                  ),
                  dashboardNotifier.checkMsg == null
                      ? const Spacing.empty()
                      : !dashboardNotifier.checkMsg!.unread
                          ? const Spacing.empty()
                          : const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: CircleAvatar(
                                backgroundColor: AppColors.red,
                                radius: 4,
                              ),
                            )
                ],
              ),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                dashboardNotifier.selectedIndex == 4
                    ? AppSvgs.settingsFilled
                    : AppSvgs.settings,
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
