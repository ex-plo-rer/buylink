import 'package:buy_link/core/constants/strings.dart';
import 'package:buy_link/core/routes.dart';
import 'package:buy_link/features/authentication/notifiers/signup_notifier.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/app_check_box.dart';
import 'package:buy_link/widgets/app_linear_progress.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:buy_link/widgets/text_with_rich.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/colors.dart';
import '../../../widgets/otp_form.dart';
import '../notifiers/login_notifier.dart';

class SignupView extends ConsumerWidget {
  SignupView({Key? key}) : super(key: key);
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context, ref) {
    final signupNotifier = ref.watch(signupNotifierProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: signupNotifier.currentPage == 1
            ? null
            : IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_outlined,
                  color: AppColors.dark,
                ),
                onPressed: () {
                  signupNotifier.moveBackward();
                  print(signupNotifier.currentPage);
                  _pageController.animateToPage(
                    // array starts at 0 (lol)
                    signupNotifier.currentPage - 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                },
              ),
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: const Text(
          AppStrings.signup,
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
                  current: signupNotifier.currentPage,
                  total: signupNotifier.totalPage,
                  value: signupNotifier.currentPage / signupNotifier.totalPage,
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
                            firstText: 'What\'s your',
                            secondText: 'name?',
                            fontSize: 24,
                            secondColor: AppColors.primaryColor,
                          ),
                          const Spacing.height(12),
                          AppTextField(
                            title: '',
                            hintText: 'Steve Jobs',
                            suffixIcon: GestureDetector(
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
                        children: [
                          const TextWithRich(
                            firstText: 'What\'s your',
                            secondText: 'email?',
                            fontSize: 24,
                            secondColor: AppColors.primaryColor,
                          ),
                          const Spacing.height(12),
                          AppTextField(
                            title: '',
                            hintText: 'Example@gmail.com',
                            keyboardType: TextInputType.emailAddress,
                            suffixIcon: GestureDetector(
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
                          OtpForm(),
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
                            obscureText: signupNotifier.passwordVisible,
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () => signupNotifier.togglePassword(),
                                  child: Icon(
                                    signupNotifier.passwordVisible
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
                    ],
                  ),
                ),
                Column(
                  children: [
                    AppButton(
                      text:
                          signupNotifier.currentPage == signupNotifier.totalPage
                              ? AppStrings.signup
                              : AppStrings.next,
                      backgroundColor: AppColors.primaryColor,
                      onPressed: () {
                        signupNotifier.moveForward();
                        print(signupNotifier.currentPage);
                        signupNotifier.currentPage > signupNotifier.totalPage
                            ? ref
                                .read(navigationServiceProvider)
                                .navigateToNamed(Routes.dashboard)
                            : _pageController.animateToPage(
                                // array starts at 0 (lol)
                                signupNotifier.currentPage - 1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn,
                              );
                      },
                    ),
                    const Spacing.mediumHeight(),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'By clicking “sign up” you are agreeing to the',
                        style: TextStyle(color: AppColors.grey5),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Terms of Use and Privacy Policy',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
