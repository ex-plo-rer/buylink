import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../widgets/spacing.dart';
import '../../notifiers/settings_notifier/privacy_policy_notifier.dart';

class PrivacyPolicy extends ConsumerWidget {
  PrivacyPolicy ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final privacyNotifier = ref.watch(privacyNotifierProvider);
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
          title: const Text("Privacy policy",
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
                    Spacing.mediumHeight(),
                ]))));}}