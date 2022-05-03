import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_text_field.dart';
import '../../../../widgets/spacing.dart';
import '../../../../widgets/text_with_rich.dart';
import '../../notifiers/store_notifier/delete_store_validation_notifier.dart';

class DeleteStoreVal extends ConsumerWidget {
  DeleteStoreVal ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final deleteStoreValNotifier = ref.watch(deleteStoreValNotifierProvider);
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
                        firstText: 'Delete',
                        secondText: 'store',
                        fontSize: 24,
                        firstColor: AppColors.primaryColor,
                      ),
                      Spacing.smallHeight(),
                      Align (
                          alignment: Alignment.topLeft,
                          child:

                      Text("Enter your password, we just want to make sure its you", style: TextStyle(fontSize: 12),textAlign: TextAlign.start,)),

                      AppTextField(
                        title: '',
                        hintText: 'Password123',
                        suffixIcon: GestureDetector(
                          onTap: () {},
                          child: Icon(
                              Icons.visibility_off_outlined,
                              color: AppColors.grey6,
                              size: 20,

                          ),
                        ),
                        hasBorder: false,
                      ),

                      const Spacing.largeHeight(),
                      const Spacing.largeHeight(),
                      const Spacing.largeHeight(),
                      const Spacing.largeHeight(),
                      const Spacing.largeHeight(),
                      AppButton(
                          text: "I want to delete my account",
                          backgroundColor: AppColors.primaryColor,
                          onPressed: () => ref

                      ),

                    ]


                )

            )));}}
