import 'package:buy_link/widgets/app_button.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../notifiers/store_notifier/empty_state_notifier.dart';

class EmptyStateView extends ConsumerWidget {
  EmptyStateView({Key? key}) : super(key: key);
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context, ref) {
    final addstoreNotifier = ref.watch(emptyStateNotifierProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
    body: Column(
      children: <Widget>[

        Text ("My Stores"),

        Spacing.largeHeight(),

        Image.asset("assets/images/store_empty_stste.png"),

        Text ("No Store Added Yet"),

        Text("Tap the button below to create your first store"),

        AppButton(text: "Create My First Store")

      ]
    )
    );}}