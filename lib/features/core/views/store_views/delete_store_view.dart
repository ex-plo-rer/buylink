import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/core/routes.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_button_2.dart';
import '../../../../widgets/spacing.dart';
import '../../models/product_model.dart';
import '../../notifiers/store_notifier/delete_store_notifier.dart';

class DeleteStore extends ConsumerWidget {
  final Store store;
  DeleteStore({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final deleteStoreNotifier = ref.watch(deleteStoreNotifierProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined,
              color: AppColors.dark, size: 14),
          onPressed: () {
            ref.read(navigationServiceProvider).navigateBack();
          },
        ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: const Text(
          "Store Description",
          style: TextStyle(
            color: AppColors.dark,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              const Spacing.largeHeight(),
              CircleAvatar(
                radius: 38,
                child: SvgPicture.asset(
                  AppSvgs.trash,
                  color: AppColors.red,
                ),
                backgroundColor: AppColors.redshade1,
              ),
              const Spacing.largeHeight(),
              Text(
                "Deleting your store means all your data associated"
                " with buylink including but not limited to your personal data,"
                " store data, preferences, analytics e.t.c will be permanently erased.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
              const Spacing.height(12),
              const Spacing.largeHeight(),
              const Spacing.largeHeight(),
              const Spacing.largeHeight(),
              AppButton2(
                prevIcon: AppSvgs.forward,
                text: "Continue ",
                backgroundColor: AppColors.primaryColor,
                onPressed: () =>
                    ref.read(navigationServiceProvider).navigateToNamed(
                          Routes.deleteStoreVal,
                          arguments: store,
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
