import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/core/routes.dart';
import 'package:buy_link/features/authentication/views/signup_view.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/text_with_rich.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../widgets/dot_build.dart';
import '../../../widgets/spacing.dart';
import '../notifiers/onboarding_notifier.dart';

class OnboardingView extends ConsumerWidget {
  OnboardingView({Key? key}) : super(key: key);
  int currentIndex = 0;

  static const _kCurve = Curves.ease;
  final PageController _pageController = PageController(initialPage: 0);
  static const _kDuration = Duration(milliseconds: 10);

  @override
  Widget build(BuildContext context, ref) {
    final onboardnotifier = ref.watch(onboardProv);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: onboardnotifier.currentPage == 0
            ? null
            : IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: AppColors.dark,
            size: 20,
          ),
          onPressed: () {
            onboardnotifier.moveBackward();
            print(onboardnotifier.currentPage);
            _pageController.animateToPage(
              // array starts at 0 (lol)
              onboardnotifier.currentPage - 1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
        ),
        elevation: 0,
        backgroundColor: AppColors.transparent,

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         // const Spacing.smallHeight(),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardnotifier.onBoardingProvContents.length,
              itemBuilder: (context, index) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    onboardnotifier.onBoardingProvContents[index].imgString,
                  ),
                  //const Spacing.empty(),
                  Padding(
                    padding: EdgeInsets.all(14),
                    child:
                  Text(
                    onboardnotifier.onBoardingProvContents[index].description,
                    style: const TextStyle(
                      color: AppColors.grey1,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
              onPageChanged: onboardnotifier.changePage,
            ),
          ),
          DotsIndicator(
            controller: _pageController,
            itemCount: onboardnotifier.onBoardingProvContents.length,
            onPageSelected: (int page) {
              onboardnotifier.changePage(page);
              print('Current page: $page');
              _pageController.animateToPage(
                page,
                duration: _kDuration,
                curve: _kCurve,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: AppButton(
              text: onboardnotifier.currentPage == 2
                  ? 'Get Started  >>'
                  : 'Continue  >>',
              backgroundColor: AppColors.primaryColor,
              onPressed: () {
                onboardnotifier.nextPage();
                onboardnotifier.currentPage > 2
                    ? onboardnotifier.exitOnboard()
                    : _pageController.animateToPage(
                        onboardnotifier.currentPage,
                        duration: _kDuration,
                        curve: _kCurve,
                      );
              },
            ),
          ),
          Visibility(
            visible: onboardnotifier.currentPage == 2,
            child: TextWithRich(
              firstText: 'Already have an account ? ',
              secondText: 'Log in',
              secondColor: AppColors.primaryColor,
              mainAxisAlignment: MainAxisAlignment.center,
              onTapText: () => ref
                  .read(navigationServiceProvider)
                  .navigateToNamed(Routes.login),
              fontSize: 14,
            ),
          ),
          const Spacing.largeHeight(),
        ],
      ),
    );
  }
}
