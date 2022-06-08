import 'package:buy_link/core/utilities/view_state.dart';
import 'package:buy_link/widgets/app_toggle_button.dart';
import 'package:buy_link/widgets/circular_progress.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../notifiers/settings_notifier/settings_notification_notifier.dart';

class SettingNotification extends ConsumerStatefulWidget {
  SettingNotification ({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SettingNotificationClass(); }

  class SettingNotificationClass extends ConsumerState<SettingNotification> {
    @override
    Widget build(BuildContext context) {

      final settingNotifier = ref.watch(settingNotificationNotifierProvider);

      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
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
              child:
              settingNotifier.state.isLoading? const CircularProgress():
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(children: <Widget>[
                    Spacing.mediumHeight(),
                    AppToggle(state: settingNotifier.notifications?.push_alert ?? false , type: "push",
                        title: "Push notifications", subtitle: "Notifies you of events even when you’re not in the app",
                        setNotification: () async {
                      settingNotifier.onNotChanged(text: "push" , fetchState:
                      settingNotifier.notifications?.push_alert?? false );
                      await settingNotifier.setNotification();


                        }),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Divider(color: AppColors.grey6),),

                    AppToggle(state: settingNotifier.notifications?.product_alert ?? false, type: "product",
                        title: "Product alert notifications", subtitle: "Notifies you of your favorite products in range.", setNotification:(){}),

                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Divider(color: AppColors.grey6),),

                    AppToggle(state: settingNotifier.notifications?.chat_alert ?? false, type: "chat",
                        title: "Chat notifications", subtitle: "Notifies you of messages in your inbox", setNotification: (){}),

                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Divider(color: AppColors.grey6),),

                    AppToggle(state: settingNotifier.notifications?.email_alert ?? false, type: "email",
                        title: "Email Notifications", subtitle: "Notifies you of important occurrences from Buylink", setNotification: (){}),

                  ]))));
    }

  }


