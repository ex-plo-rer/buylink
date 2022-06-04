import 'dart:io';
import 'dart:typed_data';

import 'package:buy_link/widgets/back_arrow.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../../../../core/constants/colors.dart';
import 'dart:math' as math;

class PreviewImageScreen extends StatefulWidget {
  final String imagePath;

  PreviewImageScreen({required this.imagePath});

  @override
  _PreviewImageScreenState createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container (
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:

          Stack(
            children: <Widget>[
              Container(
                  height:MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child:
                  Image.file(File(widget.imagePath), fit: BoxFit.fill)),
              SizedBox(height: 10.0),
              Positioned(
                  bottom: 10,
                  right: 0,
                  left: 0,

                  child: Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child:Row(
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              ),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),

                              padding: EdgeInsets.fromLTRB(10, 12, 0, 0),
                              child: TextField(
                                textAlign: TextAlign.start,
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
                        ],
                      ))


              ),
              Positioned(
                  top: 20,
                  left: 0,
                  child: const BackArrow()
              )

            ],
          ),
        )
    );
  }

  Future<ByteData> getBytesFromFile() async {
    Uint8List bytes = File(widget.imagePath).readAsBytesSync() as Uint8List;
    return ByteData.view(bytes.buffer);
  }
}