import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../notifiers/message_notifier/user_profile.dart';

class UserProfile extends ConsumerWidget {
  UserProfile ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final userNotifier = ref.watch(userProfileNotifierProvider);
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
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding (
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(children: <Widget>[

                  SizedBox(height: 10),
                  CircleAvatar(
                    radius: 40,
                    child:Image.asset('assets/images/user_avatar.png', ),
                  ),
                  Spacing.smallHeight(),

                  Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text ("Atinuke Stores"),
                        Icon(Icons.star_rate_outlined),
                        Text("4.6"),
                      ]
                  ),
                  //
                  Text ("Online 3hr ago"),
                  Spacing.mediumHeight(),

                  Container (
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      color: AppColors.shade2,
                      child:
                  TextButton (
                     //style: ButtonStyle( backgroundColor: Colors.),
                      onPressed: () {  },
                      child: Text(
                          "View Store"
                      )
                  )),
                  Spacing.largeHeight(),
                  ListTile(title: Text ("Notifications"), trailing: Icon(Icons.toggle_off_outlined),),
                  Divider(color: AppColors.grey6),
                  ListTile(title: TextButton (onPressed: () {
                  }, child:  Align(
                      alignment: Alignment.topLeft,child: Text ("Block Atinuke Stores", style:
                  TextStyle(color: AppColors.red), )))),
                  Divider(color: AppColors.grey6),
                  ListTile(title:
                  Align(
                      alignment: Alignment.topLeft,child:TextButton( onPressed: () {
                  },

                    child: Text ("Delete Conversation", style: TextStyle(color: AppColors.red),),))),

                ],
                )
            )));}}