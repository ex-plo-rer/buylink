import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class AppToggle extends StatelessWidget {
  AppToggle({
    Key? key,
    required this.state,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.onChanged,
  }) : super(key: key);
  final bool state;
  final String type;
  final String title;
  final String subtitle;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    //final settingNotifier = ref.watch(settingNotificationNotifierProvider);
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.grey3,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: AppColors.grey5,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Switch(
        value: state,
        activeTrackColor: AppColors.shade1,
        activeColor: AppColors.primaryColor,
        inactiveThumbColor: AppColors.grey6,
        inactiveTrackColor: AppColors.grey8,
        onChanged: onChanged,
      ),
    );
  }
}
