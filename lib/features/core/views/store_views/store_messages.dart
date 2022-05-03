import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../message_view/message_view.dart';

class StoreMessagesView extends ConsumerWidget {
  const StoreMessagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: AppColors.dark, //change your color here
          ),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
            ),
          ),
          elevation: 0,
          backgroundColor: AppColors.transparent,
          title: Text(
            "Messages",
            style: TextStyle(
              color: AppColors.dark,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(4),
                          children: <Widget>[
                            GestureDetector(
                                onTap: () {},
                                child: ListTile(
                                  title: Text(
                                    "Emmanuel",
                                    style: TextStyle(
                                        fontSize: 13, fontWeight: FontWeight.bold),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundColor: AppColors.shade1,
                                    child: const Text('DE'),
                                    radius: 24,
                                  ),
                                  subtitle: Text("Good evening i wanted to ask if you... "),
                                  trailing: Column(children: <Widget>[
                                    SizedBox(height: 6),
                                    CircleAvatar(
                                      backgroundColor: AppColors.primaryColor,
                                      child:
                                      const Text('1', style: TextStyle(fontSize: 12)),
                                      radius: 10,
                                    ),
                                    Text("6 Nov", style: TextStyle(fontSize: 12)),
                                  ]),
                                  onTap: (){

                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> MessageView()));
                                  },

                                ))
                          ])


                    );}}