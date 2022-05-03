import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../notifiers/settings_notifier/about_buylink_notifier.dart';

class About extends ConsumerWidget {
  About ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final aboutNotifier = ref.watch(aboutNotifierProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
        leading:  IconButton(
        icon: const Icon(
        Icons.arrow_back_ios_outlined,
        color: AppColors.dark,
    ),
    onPressed: () {},),
    elevation: 0,
    backgroundColor: AppColors.transparent,
    title: const Text("About Buylink",
    style: TextStyle(
    color: AppColors.dark,
    fontSize: 16,
    fontWeight: FontWeight.w500,),),
    centerTitle: true,
    ),
    body: SingleChildScrollView(
    child: Padding (
    padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
    child: Column(children: <Widget>[

      Image.asset("assets/images/buylink_logo.png"),

      Text ("Buylink is an infrastructure that helps you shop easier and faster. "
          "Buylink uses geolocation technology combined with a fairly complex search algorithm to locate products you desire."),
      Spacing.mediumHeight(),

      Row (children: <Widget>[
        Icon(Icons.person_outline, color: AppColors.shade7,),
        Spacing.smallWidth(),
        Text ("As a customer:", style: TextStyle(color: AppColors.shade7),),
          ]),
      Spacing.smallHeight(),
      Container (
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: AppColors.shade1),
        child: Text ("Buylink helps you know if a product is available in your locale."
            "With buylink, you can visit every store in your area without moving an inch."
            "Buylink saves you the time of comparing prices of products from one store to another.", style: TextStyle (color: AppColors.primaryColor))
      ),
      Spacing.mediumHeight(),
      Row (children: <Widget>[
        Icon(Icons.storefront, color: AppColors.shade7,),
        Spacing.smallWidth(),
        Text ("As a store owner:", style: TextStyle(color: AppColors.shade7),),
      ]),
      Spacing.smallHeight(),
      Container (
        padding: EdgeInsets.all (10),
          decoration: BoxDecoration(color: AppColors.shade1 ),
          child: Text ("Buylink helps you know if a product is available in your locale."
              "With buylink, you can visit every store in your area without moving an inch."
              "Buylink saves you the time of comparing prices of products from one store to another.", style: TextStyle (color: AppColors.primaryColor))
      ),

      Spacing.largeHeight(),

      Text ("Version 1.0.20"),
      Spacing.mediumHeight(),

      Row (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
      Text ("Buylink is free for every one to use",), Icon(Icons.favorite,color: AppColors.red, )])

    ]))));}}