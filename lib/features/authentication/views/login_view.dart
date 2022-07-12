import 'package:buy_link/core/constants/strings.dart';
import 'package:buy_link/core/routes.dart';
import 'package:buy_link/core/utilities/loader.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:buy_link/widgets/text_with_rich.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/colors.dart';
import '../notifiers/login_notifier.dart';

class LoginView extends ConsumerWidget {
  LoginView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  final _emailFN = FocusNode();
  final _passwordFN = FocusNode();

  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final loginNotifier = ref.watch(loginNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: const Text(
          AppStrings.login,
          style: TextStyle(
            color: AppColors.dark,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {
            ref
                .read(navigationServiceProvider)
                .navigateToNamed(Routes.onboarding);
          },
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            size: 14,
            color: AppColors.grey2,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: AbsorbPointer(
            absorbing: loginNotifier.state.isLoading,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacing.smallHeight(),
                  const TextWithRich(
                    firstText: 'Welcome',
                    secondText: 'Back!',
                    fontSize: 24,
                    firstColor: AppColors.primaryColor,
                  ),
                  const Text(
                    'Log in to access your buylink account',
                    style: TextStyle(
                      color: AppColors.grey2,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  const Spacing.largeHeight(),
                  AppTextField(
                    style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    title: 'Email Address',
                    hintText: 'example@email.com',
                    focusNode: _emailFN,
                    controller: _emailAddressController,
                    onChanged: loginNotifier.onEmailChanged,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const Spacing.mediumHeight(),
                  const Spacing.smallHeight(),
                  AppTextField(
                    style: const TextStyle(
                        color: AppColors.grey5,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    title: 'Password',
                    hintText: 'Enter your password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    focusNode: _passwordFN,
                    controller: _passwordController,
                    onChanged: loginNotifier.onPasswordChanged,
                    obscureText: !loginNotifier.passwordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        loginNotifier.passwordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.dark,
                      ),
                      onPressed: () => loginNotifier.togglePassword(),
                    ),
                  ),
                  const Spacing.mediumHeight(),
                  const Spacing.smallHeight(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => ref
                          .read(navigationServiceProvider)
                          .navigateToNamed(Routes.forgotPassword),
                      child: const Text(
                        "Forgotten your password?",
                        style: TextStyle(
                          color: AppColors.grey4,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const Spacing.height(50),
                  AppButton(
                      // isLoading: loginNotifier.state.isLoading,
                      text: AppStrings.login,
                      backgroundColor: _passwordController.text.isNotEmpty &&
                              _emailAddressController.text.isNotEmpty
                          ? AppColors.primaryColor
                          : AppColors.grey6,
                      onPressed: () async {
                        // ref
                        //     .read(navigationServiceProvider)
                        //     .navigateToNamed(Routes.dashboard);
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          Loader(context).showLoader(text: '');
                          await loginNotifier.loginUser(
                            email: _emailAddressController.text,
                            password: _passwordController.text,
                          );
                        }
                      }),
                  const Spacing.mediumHeight(),
                  Align(
                    alignment: Alignment.center,
                    child: TextWithRich(
                      firstText: 'Don’t have an account?',
                      secondText: 'Sign Up',
                      fontSize: 14,
                      firstColor: AppColors.grey2,
                      secondColor: AppColors.primaryColor,
                      //     fontWeight: FontWeight.w500,
                      mainAxisAlignment: MainAxisAlignment.center,
                      onTapText: () => ref
                          .read(navigationServiceProvider)
                          .navigateToNamed(Routes.signup),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
