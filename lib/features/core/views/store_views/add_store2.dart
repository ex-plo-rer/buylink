import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../widgets/app_button.dart';
import '../../../../widgets/spacing.dart';
import '../../notifiers/store_notifier/add_store2_notifier.dart';

class EmptyStoreView extends ConsumerWidget {
  EmptyStoreView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, ref) {
    final addstoreNotifier = ref.watch(addStore2NotifierProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body:
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Spacing.largeHeight(),

              Padding (
                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                child:
                Text ("My Stores", textAlign: TextAlign.start, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),),


              Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Spacing.largeHeight(),
                    Spacing.largeHeight(),
                    Spacing.largeHeight(),
                    Spacing.largeHeight(),
                    Spacing.largeHeight(),


                    Image.asset("assets/images/store_empty_state.png"),
                    Spacing.largeHeight(),

                    const Padding(
                        padding: EdgeInsets.fromLTRB(90, 0, 90, 0),
                        child: Text("No Store Added Yet", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          textAlign: TextAlign.center,)),

                    //Text ("No Store Added Yet"),

                    Spacing.smallHeight(),

                    const Padding(
                        padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
                        child: Text("Tap the button below to create your first store", style: TextStyle( fontSize: 16),
                          textAlign: TextAlign.center,)),

                    //Text("Tap the button below to create your first store"),

                    AppButton(text: "Create My First Store")

                  ]
              )
              )]));}}