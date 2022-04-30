import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../notifiers/settings_notifier/settings_notification_notifier.dart';

class SettingNotification extends ConsumerWidget {
  SettingNotification ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final settingNotNotifier = ref.watch(settingNotificationNotifierProvider);
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
    title: const Text("Notification",
    style: TextStyle(
    color: AppColors.dark,
    fontSize: 16,
    fontWeight: FontWeight.w500,),),
    centerTitle: true,
    ),
    body: SingleChildScrollView(
    child: Padding (
    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    child: Column(children: <Widget>[

      Spacing.mediumHeight(),
      ListTile (title: Text("Push notifications", style: TextStyle(color: AppColors.grey3),),
          subtitle: Text("Notifies you of events even when you’re not in the app", style: TextStyle(color: AppColors.grey5),),
      trailing: IconButton (icon:Icon(Icons.toggle_off_outlined, color:AppColors.shade5), onPressed: () {  },)
      ),

      Container (
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child:    Divider(color: AppColors.grey7),),

      ListTile (title: Text("Product alert notifications",  style: TextStyle(color: AppColors.grey3)),
          subtitle: Text("Notifies you of your favorite products in range.", style: TextStyle(color: AppColors.grey3),),
          trailing: IconButton (icon:Icon(Icons.toggle_off_outlined, color:AppColors.shade5), onPressed: () {  },)
      ),

      Container (
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child:    Divider(color: AppColors.grey7),),

      ListTile (title: Text("Chat notifications",  style: TextStyle(color: AppColors.grey3)),
          subtitle: Text("Notifies you of messages in your inbox", style: TextStyle(color: AppColors.grey3),),
          trailing: IconButton (icon:Icon(Icons.toggle_off_outlined, color:AppColors.shade5), onPressed: () {  },)
      ),

      Container (
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child:    Divider(color: AppColors.grey7),),

      ListTile (title: Text("Email Notifications",  style: TextStyle(color: AppColors.grey3)),
          subtitle: Text("Notifies you of important occurrences from Buylink", style: TextStyle(color: AppColors.grey3),),
          trailing: IconButton (icon:Icon(Icons.toggle_off_outlined, color:AppColors.shade5), onPressed: () {  },)
      ),


    ]))));}}
