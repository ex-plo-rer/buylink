import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_check_box.dart';
import '../../../../widgets/app_linear_progress.dart';
import '../../../../widgets/app_text_field.dart';
import '../../../../widgets/otp_form.dart';
import '../../../../widgets/spacing.dart';
import '../../../../widgets/text_with_rich.dart';
import '../../notifiers/settings_notifier/change_password_notifier.dart';

class ChangePassword extends ConsumerWidget {
  ChangePassword({Key? key}) : super(key: key);
  final PageController _pageController = PageController();

  final _oldPasswordController = TextEditingController();
  final _oldPasswordFN = FocusNode();
  final _newPasswordController = TextEditingController();
  final _newPasswordFN = FocusNode();

  @override
  Widget build(BuildContext context, ref) {
    final changePasswordNotifier = ref.watch(editUserPasswordNotifierProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: changePasswordNotifier.currentPage == 1
            ? null
            : IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: AppColors.dark,
          ),
          onPressed: () {
            changePasswordNotifier.moveBackward();
            print(changePasswordNotifier.currentPage);
            _pageController.animateToPage(
              // array starts at 0 (lol)
              changePasswordNotifier.currentPage - 1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
        ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title:  Text( "Change Email Address",
          style: TextStyle(
            color: AppColors.dark,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppLinearProgress(
                        current: changePasswordNotifier.currentPage,
                        total: changePasswordNotifier.totalPage,
                        value: changePasswordNotifier.currentPage / changePasswordNotifier.totalPage,
                      ),
                      const Spacing.height(12),
                      SizedBox(
                          height: 400,
                          child: PageView(
                              controller: _pageController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                Column(
                                  children: [
                                    const TextWithRich(
                                      firstText: 'Change',
                                      secondText: 'password',
                                      fontSize: 24,
                                      firstColor: AppColors.primaryColor,
                                    ),
                                    Align (
                                        alignment: Alignment.topLeft,
                                        child:

                                        Text(
                                            'Enter your old password ', textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.grey2,
                                              fontWeight: FontWeight.w500,
                                            ))),
                                    AppTextField(
                                      title: '',
                                      hintText: 'Ayodeji123',
                                      controller: _oldPasswordController ,
                                      focusNode: _oldPasswordFN,
                                      suffixIcon: GestureDetector(
                                        onTap: () {

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
                                      hasBorder: false,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const TextWithRich(
                                      firstText: 'Create your',
                                      secondText: 'password',
                                      fontSize: 24,
                                      secondColor: AppColors.primaryColor,
                                    ),
                                    const Spacing.height(12),
                                    AppTextField(
                                      title: '',
                                      controller: _newPasswordController,
                                      focusNode: _newPasswordFN,
                                      hintText: 'Example123',
                                      obscureText: changePasswordNotifier.passwordVisible,
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            //onTap: () => changePasswordNotifier.togglePassword(),
                                            child: Icon(
                                              changePasswordNotifier.passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: AppColors.dark,
                                            ),
                                          ),
                                          const Spacing.smallWidth(),
                                          GestureDetector(
                                            onTap: () {},
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
                                    const Spacing.largeHeight(),
                                    const Spacing.largeHeight(),
                                    AppCheckBox(
                                      text: 'Minimum of 8 characters',
                                      checked: false,
                                      onChanged: () {},
                                    ),
                                    const Spacing.smallHeight(),
                                    const Spacing.tinyHeight(),
                                    AppCheckBox(
                                      text: 'At least a Number',
                                      checked: false,
                                      onChanged: () {},
                                    )
                                  ],
                                ),

                              ])),
                      AppButton(
                        text:
                        changePasswordNotifier.currentPage == changePasswordNotifier.totalPage
                            ? AppStrings.changePassword
                            : AppStrings.next,
                        backgroundColor: AppColors.primaryColor,
                        onPressed: () {


                          changePasswordNotifier.moveForward();
                          print(changePasswordNotifier.currentPage);
                          _pageController.animateToPage(
                            // array starts at 0 (lol)
                            changePasswordNotifier.currentPage - 1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                      ),

                    ])

            ),
          ]),

    );}}