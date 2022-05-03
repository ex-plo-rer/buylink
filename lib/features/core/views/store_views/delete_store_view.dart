import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/spacing.dart';
import '../../../../widgets/text_with_rich.dart';
import '../../notifiers/store_notifier/delete_store_notifier.dart';
import 'delete_store_validation.dart';

class DeleteStore extends ConsumerWidget {
  DeleteStore ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final deleteStoreNotifier = ref.watch(deleteStoreNotifierProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading:  IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: AppColors.dark,
            ),
            onPressed: () {
            },
          ),
          elevation: 0,
          backgroundColor: AppColors.transparent,
          title: const Text("Store Description",
            style: TextStyle(
              color: AppColors.dark,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding (
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),

              child: Column(

                children: [
                  const Spacing.largeHeight(),
                  CircleAvatar(
                    radius: 38,
                    child:Icon(Icons.delete_outline_rounded, size: 28, color: AppColors.red),
                    backgroundColor: AppColors.redshade1,),
                  const Spacing.largeHeight(),

                  Text ("Deleting your store means all your data associated"
                      " with buylink including but not limited to your personal data,"
                      " store data, preferences, analytics e.t.c will be permanently erased.",
                    textAlign: TextAlign.center, style: TextStyle(fontSize:15 ),),
                  const Spacing.height(12),
                  const Spacing.largeHeight(),
                  const Spacing.largeHeight(),
                  const Spacing.largeHeight(),

                  AppButton(
                      text: "Continue >>",
                      backgroundColor: AppColors.primaryColor,
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> DeleteStoreVal()))

                  ),

                ],
              ),)



        ));}}