import 'package:buy_link/features/core/views/message_view/user_profile_view.dart';
import 'package:buy_link/features/core/views/settings_view/change_name.dart';
import 'package:buy_link/widgets/app_text_field.dart';
import 'package:buy_link/widgets/message_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

import '../../../../core/constants/colors.dart';
import '../../../../core/routes.dart';
import '../../../../services/navigation_service.dart';
import '../../../../widgets/spacing.dart';
import '../../notifiers/message_notifier/message_notifier.dart';
import 'camera_screen.dart';

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

        body:  Padding (
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Stack (
                children: <Widget> [
                  Column(children: <Widget>[
                    messageList(),
                    Row (children : <Widget>[
                      Align (
                          alignment: Alignment.topLeft,
                          child:
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.grey10,
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),

                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            //alignment: Alignment.topLeft,
                            width: 280.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[

                                // Button send image
                                // Edit text
                                Flexible(
                                  child: Container(
                                    child: TextField(
                                      onSubmitted: (value) {
                                        //onSendMessage(textEditingController.text, TypeMessage.text);
                                      },
                                      style: TextStyle(color: AppColors.dark, fontSize: 15),
                                      // controller: textEditingController,
                                      decoration: InputDecoration.collapsed(
                                        hintText: 'Type something....',
                                        hintStyle: TextStyle(color: AppColors.dark),
                                      ),
                                      //focusNode: focusNode,
                                    ),
                                  ),
                                ),

                                IconButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  constraints: BoxConstraints(),
                                  icon: Icon(Icons.camera_alt_outlined, color: AppColors.grey5),
                                  onPressed: () =>  {
                                    ref
                                        .read(navigationServiceProvider)
                                        .navigateToNamed(Routes.cameraScreen)
                                  },//onSendMessage(textEditingController.text, TypeMessage.text),
                                  color:AppColors.dark,
                                ),
                                IconButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                                  constraints: BoxConstraints(),
                                  icon: Transform.rotate(
                                      angle: 45 * math.pi /-180,child:Icon(Icons.attachment,
                                      color: AppColors.grey5)),
                                  onPressed: () =>  {
                                    messageNotifier.pickFile()
                                  },//onSendMessage(textEditingController.text, TypeMessage.text),
                                  color:AppColors.dark,
                                ),

                                // Button send message

                              ],
                            ),
                            //width: double.infinity,
                            height: 50,
                            // decoration: BoxDecoration(
                            //border: Border(top: BorderSide(color: AppColors.dark, width: 0.5)), color: Colors.white),
                          )
                      ),
                      Spacing.smallWidth(),

                      Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child:
                          Transform.rotate(
                            angle: 45 * math.pi /-180,child:IconButton(
                            icon: Icon(Icons.send, color: Colors.white, size: 18,),
                            onPressed: () =>  {},//onSendMessage(textEditingController.text, TypeMessage.text),
                            color:AppColors.dark,
                          ),
                          ))
                    ])


                  ])
                ])
        ));}
}