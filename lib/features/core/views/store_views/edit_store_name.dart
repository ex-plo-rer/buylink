import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_text_field.dart';
import '../../../../widgets/text_with_rich.dart';
import '../../notifiers/store_notifier/edit_store_name_notifier.dart';

class EditStoreName extends ConsumerWidget {
  EditStoreName ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final editStoreNameNotifier = ref.watch(editStoreNameNotifierProvider);
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
    title: const Text("Change Name",
    style: TextStyle(
    color: AppColors.dark,
    fontSize: 16,
    fontWeight: FontWeight.w500,),),
    centerTitle: true,
    ),
    body: SingleChildScrollView(
    child: Padding (
    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: Column(
    children: <Widget>[
    const TextWithRich(
    firstText: 'What\'s the name your',
    secondText: 'store?',
    fontSize: 24,
    secondColor: AppColors.primaryColor,
    ),
      Spacing.smallHeight(),

      AppTextField(
        title: '',
        hintText: 'Atinuke Stores',
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

      const Spacing.largeHeight(),
      const Spacing.largeHeight(),
      const Spacing.largeHeight(),
      const Spacing.largeHeight(),
      const Spacing.largeHeight(),
      const Spacing.largeHeight(),
      const Spacing.largeHeight(),

      AppButton(
          text: "Save",
          backgroundColor: AppColors.primaryColor,
          onPressed: () => ref

      ),

    ]


    )

    )));}}
