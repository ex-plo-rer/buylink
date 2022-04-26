import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/features/authentication/views/signup_view.dart';
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
    var onboardnotifier = ref.watch(onboardProv);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //   appBar: AppBar(
      //     backgroundColor: Colors.white,
      //   leading: onboardnotifier.currentPage == 1
      //   ? null
      //       : IconButton(
      // icon: const Icon(
      // Icons.arrow_back_ios_outlined,
      //   color: AppColors.dark,
      // ), onPressed: () {  },)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacing.largeHeight(),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardnotifier.onBoardingProvContents.length,
              itemBuilder: (context, index) =>
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Icon(Icons.arrow_back_ios_outlined),
                      //const Spacing.largeHeight(),
                      Image.asset(onboardnotifier
                          .onBoardingProvContents[index].imgString),
                      const Spacing.empty(),

                      Padding(
                        padding: EdgeInsets.all(20),
                        child:

                        Text(
                          onboardnotifier
                              .onBoardingProvContents[index].description,
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),),
                      DotsIndicator(
                        controller: _pageController,
                        itemCount:
                        onboardnotifier.onBoardingProvContents.length,
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

                      Container(
                          decoration: BoxDecoration (borderRadius: BorderRadius.circular(10), color: AppColors.primaryColor ),
                          height: 60,
                          margin: EdgeInsets.all(30),
                          width: double.infinity,
                          //color: HexColor("#4267B2"),
                          child: FlatButton(
                            child: Text(
                                currentIndex == onboardnotifier.onBoardingProvContents.length - 1 ? "Get Started >>": " Continue >>"),
                            onPressed: (){
                              if(currentIndex == onboardnotifier.onBoardingProvContents.length - 1){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupView()),
                                );
                              }
                            },
                            textColor: Colors.white,

                          )),
                    ],
                  ),
              onPageChanged: onboardnotifier.changePage,
            ),
          ),
        ],

      ),

    );
  }


}