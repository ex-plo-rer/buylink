import 'package:buy_link/core/constants/strings.dart';
import 'package:buy_link/core/routes.dart';
import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/app_dialog.dart';
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
          constraints: BoxConstraints(),
          onPressed: (){
          ref
              .read(navigationServiceProvider).navigateToNamed(Routes.onboarding);
        }, icon: Icon(Icons.arrow_back_ios_outlined, size: 14, color: AppColors.grey2,),),
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
                  Spacing.smallHeight(),
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
                    title: 'Email Address',
                    hintText: 'example@email.com',
                    focusNode: _emailFN,
                    controller: _emailAddressController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const Spacing.mediumHeight(),
                  Spacing.smallHeight(),
                  AppTextField(
                    title: 'Password',
                    hintText: 'Enter your password',
                    focusNode: _passwordFN,
                    controller: _passwordController,
                    obscureText: !loginNotifier.passwordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        loginNotifier.passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.dark,
                      ),
                      onPressed: () => loginNotifier.togglePassword(),
                    ),
                  ),
                  const Spacing.mediumHeight(),
                  Spacing.smallHeight(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: const Text("Forgotten your password?",
                        style: TextStyle(color: AppColors.grey4, fontSize: 14, fontWeight: FontWeight.w500),),
                      onPressed: () => ref
                          .read(navigationServiceProvider)
                          .navigateToNamed(Routes.forgotPassword),
                    ),
                  ),
                  const Spacing.height(50),
                  AppButton(
                      isLoading: loginNotifier.state.isLoading,
                      text: AppStrings.login,
                      backgroundColor: _passwordController.text.isNotEmpty &&
                          _emailAddressController.text.isNotEmpty ?
                      AppColors.primaryColor
                      : AppColors.grey6,
                      onPressed: () async {
                        // ref
                        //     .read(navigationServiceProvider)
                        //     .navigateToNamed(Routes.dashboard);
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
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
                      firstText: 'Don’t have an account ?',
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
