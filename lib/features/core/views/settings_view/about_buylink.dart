import 'package:buy_link/core/constants/svgs.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../services/navigation_service.dart';
import '../../notifiers/settings_notifier/about_buylink_notifier.dart';

class About extends ConsumerWidget {
  About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final aboutNotifier = ref.watch(aboutNotifierProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined,
                color: AppColors.dark, size: 14),
            onPressed: () {
              ref.read(navigationServiceProvider).navigateBack();
            },
          ),
          elevation: 0,
          backgroundColor: AppColors.transparent,
          title: const Text(
            "About Buylink",
            style: TextStyle(
              color: AppColors.dark,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: Column(children: <Widget>[
                  Image.asset("assets/images/buylink_logo.png"),
                  const Text(
                    "Buylink is an infrastructure that helps you shop easier and faster. "
                    "Buylink uses geolocation technology combined with a fairly complex search algorithm to "
                    "locate products you desire.",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey4),
                  ),
                  Spacing.mediumHeight(),
                  Row(children: <Widget>[
                    SvgPicture.asset(
                      AppSvgs.user,
                      width: 16,
                      height: 16,
                    ),
                    Spacing.smallWidth(),
                    const Text(
                      "As a customer:",
                      style: TextStyle(
                          color: AppColors.shade7,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ]),
                  Spacing.smallHeight(),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: AppColors.shade1),
                      child: Column(children: const <Widget>[
                        Text(
                            "Buylink helps you know if a product is available in your locale",
                            style: TextStyle(color: AppColors.primaryColor)),
                        Spacing.smallHeight(),
                        Text(
                            "With buylink, you can visit every store in your area without moving an inch",
                            style: TextStyle(color: AppColors.primaryColor)),
                        Spacing.smallHeight(),
                        Text(
                            "Buylink saves you the time of comparing prices of products from one store to another.",
                            style: TextStyle(color: AppColors.primaryColor))
                      ])),
                  Spacing.mediumHeight(),
                  Row(children: <Widget>[
                    SvgPicture.asset(
                      AppSvgs.shop,
                      width: 16,
                      height: 16,
                    ),
                    Spacing.smallWidth(),
                    const Text(
                      "As a store owner:",
                      style: TextStyle(
                          color: AppColors.shade7,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ]),
                  Spacing.smallHeight(),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: AppColors.shade1),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text("Buylink saves you the cost of advertising.",
                                //textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                )),
                            Spacing.smallHeight(),
                            Text(
                                "No matter how small or hidden your store may be, "
                                "your products will appear once it is searched for.",
                                style:
                                    TextStyle(color: AppColors.primaryColor)),
                            Spacing.smallHeight(),
                            Text(
                                "You don't have to be physically present at your store before making sales.",
                                style:
                                    TextStyle(color: AppColors.primaryColor)),
                            Spacing.smallHeight(),
                            Text(
                                "Your store or products can be noticed fast no matter how new you are.",
                                style: TextStyle(color: AppColors.primaryColor))
                          ])),
                  Spacing.largeHeight(),
                  const Text(
                    "Version 1.0.20",
                    style: TextStyle(
                        color: AppColors.grey4,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacing.mediumHeight(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          "Buylink is free for every one to use",
                          style: TextStyle(
                              color: AppColors.grey1,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.favorite,
                          color: AppColors.red,
                          size: 13,
                        )
                      ])
                ]))));
  }
}
