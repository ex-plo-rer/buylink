import 'package:buy_link/core/routes.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
import 'app_button.dart';

class AuthDialog extends StatelessWidget {
  const AuthDialog({
    Key? key,
    this.onNav = false,
  }) : super(key: key);
  final bool onNav;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!onNav)
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: AppColors.dark.withOpacity(0.5),
          ),
        AlertDialog(
          contentPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          backgroundColor: AppColors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 24.0,
          ),
          title: onNav
              ? null
              : Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const CircleAvatar(
                        backgroundColor: AppColors.light,
                        radius: 20,
                        child: Icon(
                          Icons.clear_rounded,
                          size: 28,
                          color: AppColors.grey3,
                        ),
                      ),
                    ),
                  ),
                ),
          content: Container(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
            decoration: BoxDecoration(
                color: AppColors.light,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Spacing.tinyHeight(),
                const Text(
                  'Oops! Authentication Needed',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.grey1,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacing.largeHeight(),
                const Text(
                  'Kindly login to continue. This is because your data will be modified to complete this action.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.grey5,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacing.largeHeight(),
                AppButton(
                  text: 'Sign me in',
                  backgroundColor: AppColors.primaryColor,
                  textColor: AppColors.light,
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.login,
                    (route) => false,
                  ),
                ),
              ],
            ),
          ),
          // actionsAlignment: MainAxisAlignment.spaceAround,
          // actions: <Widget>[
          //   AppButton(
          //     text: 'Sign me in',
          //     backgroundColor: AppColors.primaryColor,
          //     textColor: AppColors.light,
          //     onPressed: () => Navigator.pushNamedAndRemoveUntil(
          //       context,
          //       Routes.login,
          //       (route) => false,
          //     ),
          //   ),
          // ],
        ),
      ],
    );
  }
}

/*Container(
      color: AppColors.light,
      // width: MediaQuery.of(context).size.width - 32,
      // height: MediaQuery.of(context).size.height / 3,
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width - 32,
        vertical: MediaQuery.of(context).size.height / 3,
      ),
      child: Column(
        children: const [
          Spacing.tinyHeight(),
          Text(
            'Oops! Authentication Needed',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.grey1,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacing.largeHeight(),
          Text(
            'Kindly login to continue. This is because your data will be modified to complete this action.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.grey5,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacing.largeHeight(),
        ],
      ),
    );*/
