import 'package:buy_link/core/utilities/loader.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/utilities/alertify.dart';
import '../../../../services/local_storage_service.dart';
import '../../../../services/navigation_service.dart';
import '../../../../services/snackbar_service.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_linear_progress.dart';
import '../../../../widgets/app_text_field.dart';
import '../../../../widgets/otp_form.dart';
import '../../../../widgets/otp_input.dart';
import '../../../../widgets/spacing.dart';
import '../../../../widgets/text_with_rich.dart';
import '../../notifiers/settings_notifier/change_email_notifier.dart';

class ChangeEmail extends ConsumerWidget {
  ChangeEmail({Key? key}) : super(key: key);
  final PageController _pageController = PageController();
  final _newEmailController = TextEditingController();
  final _newEmailFN = FocusNode();

  String? _otp;

  @override
  Widget build(BuildContext context, ref) {
    final changeEmailNotifier = ref.watch(editUserEmailNotifierProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: changeEmailNotifier.currentPage == 1
            ? null
            : IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_outlined,
                  color: AppColors.dark,
                ),
                onPressed: () {
                  changeEmailNotifier.moveBackward();
                  print(changeEmailNotifier.currentPage);
                  _pageController.animateToPage(
                    // array starts at 0 (lol)
                    changeEmailNotifier.currentPage - 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                },
              ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: Text(
          "Change Email Address",
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
          AbsorbPointer(
            absorbing: changeEmailNotifier.state.isLoading,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppLinearProgress(
                    current: changeEmailNotifier.currentPage,
                    total: changeEmailNotifier.totalPage,
                    value: changeEmailNotifier.currentPage /
                        changeEmailNotifier.totalPage,
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
                              firstText: 'Change ',
                              secondText: 'email address',
                              fontSize: 24,
                              firstColor: AppColors.primaryColor,
                            ),
                            const Spacing.height(12),
                            AppTextField(
                              style: TextStyle(
                                  color: AppColors.grey1,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                              title: '',
                              hintText: 'Example@gmail.com',
                              keyboardType: TextInputType.emailAddress,
                              focusNode: _newEmailFN,
                              controller: _newEmailController,
                              onChanged: changeEmailNotifier.onEmailChanged,
                              suffixIcon: _newEmailController.text.isEmpty
                                  ? null
                                  : GestureDetector(
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
                              hasBorder: false,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextWithRich(
                              firstText: 'Verify',
                              secondText: 'new email address',
                              fontSize: 24,
                              firstColor: AppColors.primaryColor,
                            ),
                            const Spacing.height(12),
                            const Text(
                              'Please fill in the 4 digit code we sent to your email to verify your account',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.grey2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacing.height(52),
                            OTPInput(
                              onChanged: (val) {
                                _otp = val;
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      AppButton(
                        // isLoading: changeEmailNotifier.state.isLoading,
                        text: changeEmailNotifier.currentPage ==
                                changeEmailNotifier.totalPage
                            ? AppStrings.changeEmail
                            : AppStrings.next,
                        backgroundColor: changeEmailNotifier.currentPage == 1 &&
                                _newEmailController.text.isEmpty
                            ? AppColors.grey6
                            : AppColors.primaryColor,
                        // onPressed: changeEmailNotifier.currentPage == 1 ?_nameController.text.isEmpty: changeEmailNotifier.currentPage == 2? _emailAddressController.text.isEmpty: changeEmailNotifier.currentPage == 4? _passwordController.text.isEmpty
                        onPressed: changeEmailNotifier.currentPage == 1 &&
                                _newEmailController.text.isEmpty
                            ? null
                            : () async {
                                if (changeEmailNotifier.currentPage == 1) {
                                  Loader(context).showLoader(text: '');
                                  await changeEmailNotifier.checkEmail(
                                    reason: 'change email',
                                    email: _newEmailController.text,
                                  );
                                  Loader(context).hideLoader();
                                  changeEmailNotifier.moveForward();
                                  _pageController.animateToPage(
                                    // array starts at 0 (lol)
                                    changeEmailNotifier.currentPage - 1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn,
                                  );
                                } else if (changeEmailNotifier.currentPage ==
                                    2) {
                                  String? otp = await ref
                                      .read(localStorageService)
                                      .readSecureData(AppStrings.otpEmailKey);
                                  if (_otp == null) {
                                    ref.read(snackbarService).showErrorSnackBar(
                                          'Kindly enter otp.',
                                        );
                                    return;
                                  } else if (_otp!.length != 4) {
                                    ref.read(snackbarService).showErrorSnackBar(
                                          'Kindly make sure the OTP is complete.',
                                        );
                                    return;
                                  } else if (otp != _otp) {
                                    Alertify(title: 'Incorrect OTP entered')
                                        .error();
                                    return;
                                  } else {
                                    Loader(context).showLoader(text: '');
                                    await changeEmailNotifier.changeEmail(
                                      email: _newEmailController.text,
                                    );
                                    Alertify(title: 'New email saved')
                                        .success();
                                  }
                                }
                              },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
