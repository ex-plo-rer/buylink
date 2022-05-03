import 'package:buy_link/features/core/views/settings_view/change_name.dart';
import 'package:buy_link/features/core/views/settings_view/privacy_policy.dart';
import 'package:buy_link/features/core/views/settings_view/settings_notification.dart';
import 'package:buy_link/features/core/views/settings_view/term_of_use.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../../widgets/spacing.dart';
import '../../notifiers/settings_notifier/setting_notifier.dart';
import 'about_buylink.dart';
import 'change_email.dart';
import 'change_password.dart';

class SettingView extends ConsumerWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final settingNotifier = ref.watch(settingNotifierProvider);
    return Scaffold(

        body: SingleChildScrollView(
            child: Column(
                children: <Widget>[SizedBox(height: 50,),


                  SizedBox(height: 10,),

                  Container (
                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child:
                    Row(
                        children: <Widget>[
                          SizedBox(width: 20),
                          Text("Settings", style: TextStyle(fontSize: 24),),
                        ]
                    ),),
                  SizedBox(height: 10,),
                  Center(
                      child: CircleAvatar(
                        backgroundColor: AppColors.shade3,
                        child: const Text('DE', style: TextStyle(color: Colors.white)),
                        radius: 40,
                      )
                  ),
                  Spacing.smallHeight(),
                  Text("Deji", style: TextStyle(fontWeight: FontWeight.bold)),
                  Spacing.smallHeight(),
                  Text("aob@gmail.com"),
                  SizedBox(height: 30,),
                  Container (
                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    alignment: Alignment.topLeft,
                    child: Text("Account Settings", style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.start),),

                  Container(
                      margin: EdgeInsets.all(20),

                      height: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20,),
                        color: AppColors.shade1,
                      ),


                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),

                        padding: const EdgeInsets.all(4),
                        children: <Widget>[
                          ListTile(title: Text("Change Username", style: TextStyle(color: AppColors.shade6,)),
                            leading: Icon(Icons.person, color: AppColors.shade5,),
                            trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.shade5,),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> EditUserName()));
                            },
                          ),

                          Container (
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child:
                            const Divider(color: AppColors.shade4,),),
                          ListTile(title: Text("Change Email Address", style: const TextStyle(color: AppColors.shade6,),),
                            leading: Icon(Icons.email_outlined, color: AppColors.shade5,),
                            trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.shade5),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangeEmail()));
                            },
                          ),
                          Container (
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Divider(color:  AppColors.shade4,),),
                          ListTile(title: Text("Change Password", style: TextStyle(color: AppColors.shade6,)),
                              leading: Icon(Icons.vpn_key_rounded, color: AppColors.shade5,),
                              trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.shade5,),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangePassword()));}

                          ),
                          Container (
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child:    Divider(color: AppColors.shade4),),
                          ListTile(title: Text("Delete Account", style: TextStyle(color: AppColors.shade6,)),
                              leading: Icon(Icons.delete, color: AppColors.shade5),
                              trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.shade5))
                        ],
                      )),
                  SizedBox(height: 10,),


                  Container(

                      margin: EdgeInsets.all(20),
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20,),
                        color: AppColors.shade1,
                      ),


                      child: ListView(

                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(4),
                        children: <Widget>[


                          ListTile(title: Text("Notification", style: TextStyle(color: AppColors.shade6)),
                              leading: Icon(Icons.notifications_none,color: AppColors.shade5),
                              trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.shade5),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>  SettingNotification()));}
                          )
                        ],
                      )),

                  const Spacing.mediumHeight(),
                  Container (
                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    alignment: Alignment.topLeft,
                    child: Text("Help", style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.start),),
                  const Spacing.mediumHeight(),
                  Container(
                      margin: EdgeInsets.all(20),
                      height: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20,),
                        color: AppColors.shade1,
                      ),
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(4),
                        children: <Widget>[
                          ListTile(title: Text("Customer Support", style: TextStyle(color: AppColors.shade6,)),
                              leading: Icon(Icons.headset_mic_outlined, color: AppColors.shade5,),
                              trailing: Icon(Icons.keyboard_arrow_right,color: AppColors.shade5,)),
                          Container (
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child:
                            Divider(color: AppColors.shade4,),),
                          ListTile(title: Text("Privacy policy", style: TextStyle(color: AppColors.shade6,),),
                              leading: Icon(Icons.lock_outline_rounded, color: AppColors.shade5,),
                              trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.shade5),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyPolicy()));}
                          ),
                          Container (
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Divider(color:  AppColors.shade4),),
                          ListTile(title: Text("Terms of use", style: TextStyle(color: AppColors.shade6,)),
                              leading: Icon(Icons.insert_drive_file_outlined, color: AppColors.shade5),
                              trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.shade5),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>  TermOfUse()));}
                          ),
                          Container (
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child:    Divider(color: AppColors.shade4 ),),
                          ListTile(title: Text("About Buylink", style: TextStyle(color: AppColors.shade6,)),
                              leading: Icon(Icons.info_outline_rounded, color: AppColors.shade5),
                              trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.shade5),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>  About()));})
                        ],
                      )),

                  Container(
                      height: 60,
                      margin: EdgeInsets.all(20),
                      width: double.infinity,

                      decoration: BoxDecoration( borderRadius: BorderRadius.circular(16,),

                        color: AppColors.redshade1,
                      ),
                      child: FlatButton(

                        child:
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.power_settings_new_outlined, color: AppColors.red),
                              const Spacing.smallWidth(),
                              Text("Log Out", style: TextStyle(color: AppColors.red, fontSize: 16)),
                            ]),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20.0)), //this right here
                                  child: Container(
                                    height: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          TextField(
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'What do you want to remember?'),
                                          ),

                                          Row (
                                            children: <Widget>[
                                              SizedBox(
                                                width: 100.0,
                                                child: FlatButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    "Save",
                                                    style: TextStyle(color: Colors.blueAccent),
                                                  ),
                                                  //color: const Color(0xFF1BC0C5),
                                                ),
                                              ),
                                              SizedBox(width: 20,),

                                              SizedBox(width: 20,),
                                              SizedBox(
                                                width: 100.0,
                                                child: FlatButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    "Save",
                                                    style: TextStyle(color: Colors.blueAccent),
                                                  ),
                                                  // color: const Color(0xFF1BC0C5),
                                                ),
                                              )


                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },

                        textColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),)),

                ])

        )

    );

  }}