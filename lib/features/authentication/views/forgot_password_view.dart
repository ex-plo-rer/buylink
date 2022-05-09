import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/widgets/otp_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../core/routes.dart';
import '../../../core/utilities/alertify.dart';
import '../../../services/local_storage_service.dart';
import '../../../services/navigation_service.dart';
import '../../../services/snackbar_service.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_check_box.dart';
import '../../../widgets/app_linear_progress.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/otp_form.dart';
import '../../../widgets/spacing.dart';
import '../../../widgets/text_with_rich.dart';
import '../notifiers/forgot_password_notifier.dart';

class ForgotPasswordView extends ConsumerWidget {
  ForgotPasswordView({Key? key}) : super(key: key);
  final PageController _pageController = PageController();

  final _emailFN = FocusNode();
  final _passwordFN = FocusNode();

  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _otp;

  @override
  Widget build(BuildContext context, ref) {
    final forgotPasswordNotifier = ref.watch(forgotPasswordNotifierProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: forgotPasswordNotifier.currentPage == 1
            ? null
            : IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_outlined,
                  color: AppColors.dark,
                ),
                onPressed: () {
                  forgotPasswordNotifier.moveBackward();
                  print(forgotPasswordNotifier.currentPage);
                  _pageController.animateToPage(
                    // array starts at 0 (lol)
                    forgotPasswordNotifier.currentPage - 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                },
              ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: const Text(
          'Forgot Password',
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
                  current: forgotPasswordNotifier.currentPage,
                  total: forgotPasswordNotifier.totalPage,
                  value: forgotPasswordNotifier.currentPage /
                      forgotPasswordNotifier.totalPage,
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
                            firstText: 'Forgotten',
                            secondText: 'your password?',
                            fontSize: 24,
                            firstColor: AppColors.primaryColor,
                          ),
                          const Spacing.height(12),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Enter the email you registered your buylink account with',
                              style: TextStyle(
                                  color: AppColors.grey5, fontSize: 12),
                            ),
                          ),
                          AppTextField(
                            title: '',
                            hintText: 'Example@gmail.com',
                            keyboardType: TextInputType.emailAddress,
                            focusNode: _emailFN,
                            controller: _emailAddressController,
                            onChanged: forgotPasswordNotifier.onEmailChanged,
                            suffixIcon: _emailAddressController.text.isEmpty
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
                            firstText: 'Check',
                            secondText: 'your email',
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
                            hintText: 'Example123',
                            obscureText:
                                !forgotPasswordNotifier.passwordVisible,
                            controller: _passwordController,
                            focusNode: _passwordFN,
                            onChanged: forgotPasswordNotifier.onPasswordChanged,
                            suffixIcon: _passwordController.text.isEmpty
                                ? null
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () => forgotPasswordNotifier
                                            .togglePassword(),
                                        child: Icon(
                                          forgotPasswordNotifier.passwordVisible
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
                            checked: _passwordController.text.length > 7,
                            onChanged: () {},
                          ),
                          const Spacing.smallHeight(),
                          const Spacing.tinyHeight(),
                          AppCheckBox(
                            text: 'At least a Number',
                            checked: _passwordController.text
                                .contains(RegExp(r'[0-9]')),
                            onChanged: () {},
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                AppButton(
                  isLoading: forgotPasswordNotifier.state.isLoading,
                  text: forgotPasswordNotifier.currentPage ==
                          forgotPasswordNotifier.totalPage
                      ? 'Change Password'
                      : AppStrings.next,
                  backgroundColor: AppColors.primaryColor,
                  onPressed: forgotPasswordNotifier.currentPage == 1 &&
                          _emailAddressController.text.isEmpty
                      ? null
                      : forgotPasswordNotifier.currentPage == 3 &&
                              _passwordController.text.isEmpty
                          ? null
                          : () async {
                              if (forgotPasswordNotifier.currentPage == 1) {
                                await forgotPasswordNotifier.checkEmail(
                                  reason: 'forgot password',
                                  email: _emailAddressController.text,
                                );
                                forgotPasswordNotifier.moveForward();
                                _pageController.animateToPage(
                                  // array starts at 0 (lol)
                                  forgotPasswordNotifier.currentPage - 1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn,
                                );
                              } else if (forgotPasswordNotifier.currentPage ==
                                  2) {
                                // TODO: Delete the otp after the process is successful
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
                                } else if (otp == _otp) {
                                  Alertify(title: 'OTP verified');
                                  await forgotPasswordNotifier.delay(sec: 2);
                                  forgotPasswordNotifier.moveForward();
                                  _pageController.animateToPage(
                                    // array starts at 0 (lol)
                                    forgotPasswordNotifier.currentPage - 1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn,
                                  );
                                }
                              } else if (forgotPasswordNotifier.currentPage ==
                                  3) {
                                await forgotPasswordNotifier.changePassword(
                                  email: _emailAddressController.text,
                                  password: _passwordController.text,
                                );
                                forgotPasswordNotifier.moveForward();
                                _pageController.animateToPage(
                                  // array starts at 0 (lol)
                                  forgotPasswordNotifier.currentPage - 1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn,
                                );
                              } else {
                                forgotPasswordNotifier.moveForward();
                                print(forgotPasswordNotifier.currentPage);
                                forgotPasswordNotifier.currentPage >
                                        forgotPasswordNotifier.totalPage
                                    ? ref
                                        .read(navigationServiceProvider)
                                        .navigateOffAllNamed(
                                            Routes.login, (p0) => false)
                                    : _pageController.animateToPage(
                                        // array starts at 0 (lol)
                                        forgotPasswordNotifier.currentPage - 1,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeIn,
                                      );
                              }
                            },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
