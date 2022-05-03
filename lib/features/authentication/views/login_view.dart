import 'package:buy_link/core/constants/strings.dart';
import 'package:buy_link/core/routes.dart';
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
  const LoginView({Key? key}) : super(key: key);

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
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              const AppTextField(
                title: 'Email Address',
                hintText: 'example@email.com',
              ),
              const Spacing.largeHeight(),
              AppTextField(
                title: 'Password',
                hintText: 'Enter your password',
                obscureText: loginNotifier.passwordVisible,
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
              const Spacing.largeHeight(),
              // const Align(
              //   alignment: Alignment.centerRight,
              //       child: TextWithRich(
              //   firstText: 'Don’t have an account ?',
              //   secondText: 'Sign Up',
              //   secondColor: AppColors.primaryColor,
              //   fontSize: 14,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   onTapText: () => ref
              //       .read(navigationServiceProvider)
              //       .navigateToNamed(Routes.forgotpassword),
              // ),
              //

              // child: Text(
              //   'Forgotten your password?',
              //   style: TextStyle(
              //     color: AppColors.grey2,
              //     fontWeight: FontWeight.w500,
              //     fontSize: 14,
              //   ),
              // ),
              // ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: const Text("Forgotten your password?"),
                  onPressed: () => ref
                      .read(navigationServiceProvider)
                      .navigateToNamed(Routes.forgotpassword),
                ),
              ),
              const Spacing.height(52),
              AppButton(
                text: AppStrings.login,
                backgroundColor: AppColors.primaryColor,
                // onPressed: () => ref
                //     .read(navigationServiceProvider)
                //     .navigateToNamed(Routes.homeView),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AppDialog(
                      title: 'Are you sure you want to delete your\naccount?',
                      text1: 'No',
                      onText1Pressed: () => Navigator.pop(context),
                      text2: 'Yes',
                      onText2Pressed: () => Navigator.pop(context),
                    ),
                  );
                },
              ),
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
    );
  }
}
