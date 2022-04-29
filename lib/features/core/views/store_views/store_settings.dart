import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../widgets/spacing.dart';
import '../../notifiers/store_notifier/store_settings_notifier.dart';

class StoreSetting extends ConsumerWidget {
  StoreSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final storeNotifier = ref.watch(storeSettingNotifierProvider);
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
          title: const Text("Store Settings",
            style: TextStyle(
              color: AppColors.dark,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(

            child:Column(
              children: [
                Spacing.mediumHeight(),
                const ListTile(title: Text("Store Name", style: TextStyle(color: AppColors.grey3,)),
                    leading: CircleAvatar(child:Icon(Icons.storefront_outlined, size: 18, color: AppColors.grey2), backgroundColor: AppColors.grey8,),
                    trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.grey5,)),
                Container (
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child:
                  Divider(color: AppColors.grey7,),),
                ListTile(title: Text("Store Description", style: TextStyle(color: AppColors.grey3,),),
                    leading: CircleAvatar(child:Icon(Icons.vpn_key_rounded, size: 18, color: AppColors.grey2), backgroundColor: AppColors.grey8,),
                    trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.grey5,)),
                Container (
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Divider(color:  AppColors.grey7,),),
                ListTile(title: Text("Store Location", style: TextStyle(color: AppColors.grey3,)),
                    leading: CircleAvatar(child:Icon(Icons.location_city, size: 18, color: AppColors.grey2), backgroundColor: AppColors.grey8,),
                    trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.grey5,)),
                Container (
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child:    Divider(color: AppColors.grey7),),
                ListTile(title: const Text("Delete Account", style: TextStyle(color: AppColors.grey3,)),
                    leading: CircleAvatar(child:Icon(Icons.delete, size: 18, color: AppColors.grey2), backgroundColor: AppColors.grey8,),
                    trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.grey5))
              ],
            )

        ));}}