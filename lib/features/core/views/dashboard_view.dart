import 'package:buy_link/features/authentication/views/notification_view.dart';
import 'package:buy_link/features/core/views/home_view.dart';
import 'package:buy_link/features/core/views/settings_view/setting_view.dart';
import 'package:buy_link/features/core/views/store_views/store_empty_state.dart';
import 'package:buy_link/features/core/views/store_views/store_view.dart';
import 'package:buy_link/features/core/views/wishlist_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/svgs.dart';
import '../notifiers/dashboard_notifier.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({
    Key? key,
    this.index,
  }) : super(key: key);

  final int? index;

  @override
  Widget build(BuildContext context, ref) {
    final dashboardNotifier = ref.watch(dashboardChangeNotifier);
    return Scaffold(
      body: [
        const HomeView(),
        const WishlistView(),
        StoreEmptyStateView(),
        const NotificationView(),
        const SettingView(),
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
                  : AppSvgs.favorite,
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
            icon: SvgPicture.asset(
              dashboardNotifier.selectedIndex == 3
                  ? AppSvgs.bellFilled
                  : AppSvgs.bell,
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
    );
  }
}
