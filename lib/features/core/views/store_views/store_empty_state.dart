import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/routes.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StoreEmptyStateView extends ConsumerWidget {
  const StoreEmptyStateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: const Text(
          "My Stores",
          style: TextStyle(
            color: AppColors.grey1,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        // centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacing.empty(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/store_empty_state.png"),
                const Text(
                  "No Store Added Yet",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacing.smallHeight(),
                const Text(
                  "Tap the button below to create your first store",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 44.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 132,
              child: AppButton(
                onPressed: () => ref
                    .read(navigationServiceProvider)
                    .navigateToNamed(Routes.addstoreView),
                hasIcon: true,
                icon: const Icon(
                  Icons.add,
                  color: AppColors.light,
                ),
                text: "Create My First Store",
                backgroundColor: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
