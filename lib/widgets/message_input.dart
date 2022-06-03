import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../features/core/views/message_view/camera_screen.dart';

Widget messageInput() {
  return

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

          },//onSendMessage(textEditingController.text, TypeMessage.text),
          color:AppColors.dark,
        ),
        IconButton(
          padding: EdgeInsets.fromLTRB(0, 0, 2, 0),
          constraints: BoxConstraints(),
          icon: Transform.rotate(
        angle: 45 * math.pi /-180,child:Icon(Icons.attachment,
              color: AppColors.grey5)),
          onPressed: () =>  {},//onSendMessage(textEditingController.text, TypeMessage.text),
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
  ]);



}
