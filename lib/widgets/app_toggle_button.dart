import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/constants/colors.dart';
import '../features/core/notifiers/settings_notifier/settings_notification_notifier.dart';


class AppToggle extends ConsumerStatefulWidget {
  const AppToggle({
    Key? key,
    required this.state,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.setNotification

  }) : super(key: key);

  final bool state;
  final String type;
  final String title;
  final String subtitle;
  final Function() setNotification;


  @override
  _AppToggleState createState() => _AppToggleState();
}

class _AppToggleState extends ConsumerState<AppToggle> {

  bool? setNot;
  @override
  void initState (){
    setNot = widget.state;

  }
  @override
  Widget build(BuildContext context) {
    //final settingNotifier = ref.watch(settingNotificationNotifierProvider);
    return ListTile(title: Text( widget.title,
    style: TextStyle(color: AppColors.grey3, fontSize: 14, fontWeight: FontWeight.w600),),
    subtitle: Text(
    widget.subtitle,
    style: TextStyle(color: AppColors.grey5, fontSize: 12, fontWeight: FontWeight.w500),),
    trailing: Switch(
      value: widget.state,
      activeTrackColor: AppColors.shade1,
      activeColor: AppColors.primaryColor,
      inactiveThumbColor: AppColors.grey6,
      inactiveTrackColor: AppColors.grey8,
      onChanged: (bool value) {
        setState(() {
           value = setNot! ;
           widget.setNotification;

        });


      }
    )
    );
  }
}
