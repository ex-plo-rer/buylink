import 'package:buy_link/services/navigation_service.dart';
import 'package:buy_link/widgets/app_circular_checkbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../widgets/app_button.dart';
import '../../notifiers/settings_notifier/delete_user_notifier.dart';
import '../../notifiers/user_provider.dart';

class DeleteUser extends ConsumerWidget {
  DeleteUser ({Key? key}) : super(key: key);
  final _nameController = TextEditingController();
  final _nameFN = FocusNode();

  @override
  Widget build(BuildContext context, ref) {
    final deleteUserNotifier = ref.watch(deleteUserNotifierProvider);
    final userProv = ref.watch(userProvider);
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
          title: const Text("Delete Account",
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

                      Text ("Hi ${userProv.currentUser?.name ?? 'User'}, can you please let us why you want to terminate your account", style: TextStyle(
                          fontSize: 14,
                          color: AppColors.grey1,
                          fontWeight: FontWeight.w500
                      ),),


                      // ListView(
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     //padding: const EdgeInsets.all(4),
                      //     children: <Widget>[
                      AppCCheckBox(onChanged: (){}, checked: false, text: 'I’m getting too much notifications',),
                      AppCCheckBox(onChanged: (){}, checked: false, text: 'I opened another account',),
                      AppCCheckBox(onChanged: (){}, checked: false, text: 'The app is buggy',),
                      AppCCheckBox(onChanged: (){}, checked: false, text: 'I have a privacy concern',),
                      AppCCheckBox(onChanged: (){}, checked: false, text: 'Others',),

                      Container(
                          height: 200,
                          color: AppColors.light,
                          padding: EdgeInsets.all(10.0),
                          child: new ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 200.0,
                              ),
                              child: new Scrollbar(
                                  child: new SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    reverse: true,
                                    child: SizedBox(
                                      height: 190.0,
                                      child: new TextField(
                                        maxLines: 100,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Kindly shed more light on the reason for termination(optional)',
                                        ),
                                      ),
                                    ),)))),

                      AppButton(
                          text: "Continue >>",
                          backgroundColor: AppColors.primaryColor,
                          // onPressed: () => ref
                          //     .read(navigationServiceProvider)
                          //     .navigateToNamed(Routes.homeView),
                          onPressed: () => ref
                        //   ref
                        // .read(navigationServiceProvider)
                        // .navigateToNamed(Routes.)
                      ),
                      //   ]),
                    ]


                ))));}}