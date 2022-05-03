import 'package:buy_link/features/core/views/message_view/user_profile_view.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../notifiers/message_notifier/message_notifier.dart';

class MessageView extends ConsumerWidget {
  MessageView ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final messageNotifier = ref.watch(messageViewNotifierProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 70,
          title: Container (
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child:ListTile(
                title: Text("Atinuke Stores", style: TextStyle(color: Colors.white),),
                leading: CircleAvatar(child:Image.asset("assets/images/user_avatar.png")),
                //leading: (Image.asset('assets/images/round_image.png')),
                subtitle: Text ("Online 3hr ago", style: TextStyle(color: Colors.white, fontSize: 12)),

              )),
          actions: <Widget>[
            //IconButton
            IconButton(
              icon: Icon(Icons.info_outline),
              tooltip: 'Setting Icon',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> UserProfile()));
              },
            ), //IconButton
          ], //<Widget>[]
          backgroundColor: AppColors.shade7,
          elevation: 50.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined, size: 16,),
            tooltip: 'Menu Icon',
            onPressed: () {},
          ),
          //IconButton
        ),

        body: SingleChildScrollView(
            child: Padding (
                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: Column(children: <Widget>[


                ]))));}}