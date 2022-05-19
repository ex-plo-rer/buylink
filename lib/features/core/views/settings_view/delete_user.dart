import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
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


      ]


    ))));}}