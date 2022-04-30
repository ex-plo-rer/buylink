import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../notifiers/settings_notifier/term_of_use_notifier.dart';

class TermOfUse extends ConsumerWidget {
  TermOfUse ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final termNotifier = ref.watch(termNotifierProvider);
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
    title: const Text("Terms of use",
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
     // RichText(text: "")
      // Text("User Prohibitions ", style: TextStyle(color: AppColors.grey1, fontSize: 14 , fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
      // Text("User Prohibitions ", style: TextStyle(color: AppColors.grey1, fontSize: 14 , fontWeight: FontWeight.bold),),
      // Text("Age Restriction ", style: TextStyle(color: AppColors.grey1, fontSize: 14 , fontWeight: FontWeight.bold),),
      // Text("User Prohibitions ", style: TextStyle(color: AppColors.grey1, fontSize: 14 , fontWeight: FontWeight.bold),),
      // Text("Service Interruptions and Updates  ", style: TextStyle(color: AppColors.grey1, fontSize: 14 , fontWeight: FontWeight.bold),),
      // Text("Survival", style: TextStyle(color: AppColors.grey1, fontSize: 14 , fontWeight: FontWeight.bold),),
      // Text("User Data and Legal Compliance ", style: TextStyle(color: AppColors.grey1, fontSize: 14 , fontWeight: FontWeight.bold),),
      // Text("Amendments ", style: TextStyle(color: AppColors.grey1, fontSize: 14 , fontWeight: FontWeight.bold),),




    ]))));}}