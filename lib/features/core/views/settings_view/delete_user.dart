import 'package:buy_link/core/utilities/extensions/strings.dart';
import 'package:buy_link/core/utilities/loader.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/svgs.dart';
import '../../../../core/routes.dart';
import '../../../../core/utilities/alertify.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_button_2.dart';
import '../../../../widgets/app_check_box.dart';
import '../../../../widgets/app_dialog.dart';
import '../../../../widgets/app_linear_progress.dart';
import '../../../../widgets/app_text_field.dart';
import '../../../../widgets/spacing.dart';
import '../../../../widgets/text_with_rich.dart';
import '../../notifiers/settings_notifier/delete_user_notifier.dart';
import '../../notifiers/user_provider.dart';
import '../../notifiers/settings_notifier/setting_notifier.dart';

class DeleteUser extends ConsumerWidget {
  DeleteUser({Key? key}) : super(key: key);

  final PageController _pageController = PageController();
  final _detailController = TextEditingController();
  final _detailFN = FocusNode();
  final _passwordFN = FocusNode();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final deleteUserNotifier = ref.watch(deleteUserNotifierProvider);
    final userProv = ref.watch(userProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: deleteUserNotifier.currentPage == 1
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back_ios_outlined,
                    color: AppColors.dark, size: 14),
                onPressed: () {
                  deleteUserNotifier.moveBackward();
                  print(deleteUserNotifier.currentPage);
                  _pageController.animateToPage(
                    // array starts at 0 (lol)
                    deleteUserNotifier.currentPage - 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                },
              ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: const Text(
          AppStrings.deleteaccount,
          style: TextStyle(
            color: AppColors.dark,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AbsorbPointer(
              absorbing: deleteUserNotifier.state.isLoading,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppLinearProgress(
                      current: deleteUserNotifier.currentPage,
                      total: deleteUserNotifier.totalPage,
                      value: deleteUserNotifier.currentPage /
                          deleteUserNotifier.totalPage,
                    ),
                    const Spacing.height(12),
                    SizedBox(
                      height: 500,
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Column(
                            children: <Widget>[
                              Text(
                                "Hi ${userProv.currentUser?.name.firstName() ?? 'User'}, can you please let us why you want to terminate your account",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.grey1,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacing.height(18),
                              AppCheckBox(
                                shape: const CircleBorder(),
                                onChanged: (value) {
                                  print(value);
                                  deleteUserNotifier.toggleCheckbox(
                                      value: value, index: 1);
                                },
                                checked: deleteUserNotifier.reason1,
                                text: 'I’m getting too much notifications',
                              ),
                              const Spacing.smallHeight(),
                              AppCheckBox(
                                shape: const CircleBorder(),
                                onChanged: (value) {
                                  deleteUserNotifier.toggleCheckbox(
                                      value: value, index: 2);
                                },
                                checked: deleteUserNotifier.reason2,
                                text: 'I opened another account',
                              ),
                              const Spacing.smallHeight(),
                              AppCheckBox(
                                shape: const CircleBorder(),
                                onChanged: (value) {
                                  deleteUserNotifier.toggleCheckbox(
                                      value: value, index: 3);
                                },
                                checked: deleteUserNotifier.reason3,
                                text: 'The app is buggy',
                              ),
                              const Spacing.smallHeight(),
                              AppCheckBox(
                                shape: const CircleBorder(),
                                onChanged: (value) {
                                  deleteUserNotifier.toggleCheckbox(
                                      value: value, index: 4);
                                },
                                checked: deleteUserNotifier.reason4,
                                text: 'I have a privacy concern',
                              ),
                              const Spacing.smallHeight(),
                              AppCheckBox(
                                shape: const CircleBorder(),
                                onChanged: (value) {
                                  deleteUserNotifier.toggleCheckbox(
                                      value: value, index: 5);
                                },
                                checked: deleteUserNotifier.reason5,
                                text: 'Others',
                              ),
                              const Spacing.height(18),
                              AppTextField(
                                style: TextStyle(
                                    color: AppColors.grey5,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                title: '',
                                hintText:
                                    'Kindly shed more light on the reason for termination(optional)',
                                focusNode: _detailFN,
                                controller: _detailController,
                                onChanged: deleteUserNotifier.onDetailChanged,
                                maxLines: 10,
                                hasBorder: false,
                                contentPadding: 16,
                                fillColor: AppColors.grey8,
                                suffixIcon: _detailController.text.isEmpty
                                    ? null
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () => deleteUserNotifier
                                                .togglePassword(),
                                            child: Icon(
                                              deleteUserNotifier.passwordVisible
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
                                              color: AppColors.dark,
                                            ),
                                          ),
                                          const Spacing.smallWidth(),
                                          GestureDetector(
                                            onTap: () {
                                              _detailController.clear();
                                            },
                                            child: const CircleAvatar(
                                              backgroundColor: AppColors.grey7,
                                              radius: 10,
                                              child: Icon(
                                                Icons.clear_rounded,
                                                color: AppColors.light,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                          Column(
                            children: const <Widget>[
                              Spacing.largeHeight(),
                              CircleAvatar(
                                child: Icon(
                                  Icons.delete_outline_rounded,
                                  color: AppColors.red,
                                  size: 30,
                                ),
                                backgroundColor: AppColors.redshade1,
                                radius: 30,
                              ),
                              Spacing.largeHeight(),
                              Text(
                                AppStrings.deleteUserNote2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey2,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextWithRich(
                                firstText: 'Delete',
                                secondText: 'account',
                                fontSize: 24,
                                secondColor: AppColors.primaryColor,
                              ),
                              const Spacing.height(12),
                              const Text(
                                "Enter your password, we just want to make sure its you",
                                style: TextStyle(
                                  color: AppColors.grey2,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              AppTextField(
                                style: TextStyle(
                                    color: AppColors.grey1,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                                title: '',
                                hintText: 'Password123',
                                keyboardType: TextInputType.emailAddress,
                                focusNode: _passwordFN,
                                controller: _passwordController,
                                onChanged: deleteUserNotifier.onPasswordChanged,
                                suffixIcon: _passwordController.text.isEmpty
                                    ? Icon(
                                        Icons.visibility_off_outlined,
                                        color: AppColors.grey6,
                                      )
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () => deleteUserNotifier
                                                .togglePassword(),
                                            child: Icon(
                                              deleteUserNotifier.passwordVisible
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
                                              color: AppColors.dark,
                                            ),
                                          ),
                                          const Spacing.smallWidth(),
                                          GestureDetector(
                                            onTap: () {
                                              _passwordController.clear();
                                            },
                                            child: const CircleAvatar(
                                              backgroundColor: AppColors.grey7,
                                              radius: 10,
                                              child: Icon(
                                                Icons.clear_rounded,
                                                color: AppColors.light,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                hasBorder: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    AppButton2(
                      prevIcon: AppSvgs.forward,
                      // isLoading: deleteUserNotifier.state.isLoading,
                      text: deleteUserNotifier.currentPage ==
                              deleteUserNotifier.totalPage
                          ? AppStrings.deleteUserNote4
                          : "Continue ",
                      backgroundColor: deleteUserNotifier.currentPage == 1 &&
                              (!deleteUserNotifier.reason1 &&
                                  !deleteUserNotifier.reason2 &&
                                  !deleteUserNotifier.reason3 &&
                                  !deleteUserNotifier.reason4 &&
                                  !deleteUserNotifier.reason5 &&
                                  _detailController.text.isEmpty)
                          ? AppColors.grey6
                          : deleteUserNotifier.currentPage ==
                                      deleteUserNotifier.totalPage &&
                                  _passwordController.text.isNotEmpty
                              ? Color(0xffF8EEEE)
                              : AppColors.primaryColor,
                      textColor: _passwordController.text.isNotEmpty
                          ? AppColors.red
                          : AppColors.light,
                      //backgroundColor: AppColors.primaryColor,
                      // onPressed: () => ref
                      //     .read(navigationServiceProvider)
                      //     .navigateToNamed(Routes.homeView),
                      onPressed: deleteUserNotifier.currentPage == 1 &&
                              (!deleteUserNotifier.reason1 &&
                                  !deleteUserNotifier.reason2 &&
                                  !deleteUserNotifier.reason3 &&
                                  !deleteUserNotifier.reason4 &&
                                  !deleteUserNotifier.reason5 &&
                                  _detailController.text.isEmpty)
                          ? null
                          : () async {
                              if (deleteUserNotifier.currentPage == 1) {
                                // deleteUserNotifier.deleteAccount();

                                //: deleteUserNotifier.currentPage == 2 ?
                                deleteUserNotifier.moveForward();
                                _pageController.animateToPage(
                                  // array starts at 0 (lol)
                                  deleteUserNotifier.currentPage - 1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn,
                                );
                              }
                              //else (deleteUserNotifier.currentPage == 2){
                              else if (deleteUserNotifier.currentPage == 2) {
                                deleteUserNotifier.moveForward();
                                _pageController.animateToPage(
                                  // array starts at 0 (lol)
                                  deleteUserNotifier.currentPage - 1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn,
                                );
                              } else if (deleteUserNotifier.currentPage == 3 &&
                                  _passwordController.text.isNotEmpty) {
                                Loader(context).showLoader(text: '');
                                await deleteUserNotifier.checkPassword(
                                  password: _passwordController.text,
                                );
                                if (deleteUserNotifier.passwordCorrect) {
                                  Loader(context).hideLoader();
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AppDialog(
                                        title:
                                            'Are you sure you want to delete your account?',
                                        text1: 'No',
                                        text2: 'Yes',
                                        onText2Pressed: () async {
                                          Loader(context)
                                              .showLoader(text: 'Please wait');
                                          await deleteUserNotifier
                                              .deleteAccount();
                                          if (deleteUserNotifier
                                              .accountDeleted) {
                                            ref
                                                .read(settingNotifierProvider)
                                                .logOut();
                                            ref
                                                .read(navigationServiceProvider)
                                                .navigateOffAllNamed(
                                                    Routes.login,
                                                    (p0) => false);
                                            Alertify(title: 'Account deleted')
                                                .success();
                                          } else {
                                            Loader(context).hideLoader();
                                            Alertify(title: 'An error occurred')
                                                .error();
                                          }
                                        },
                                      );
                                    },
                                  );
                                }
                              }
                            },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
