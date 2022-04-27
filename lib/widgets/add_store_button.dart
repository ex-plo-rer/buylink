import 'package:buy_link/core/constants/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddStoreContainer extends ConsumerWidget {
  final void Function()? onTapped;

  const AddStoreContainer({
    Key? key,
    this.onTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(20),
    dashPattern: [10, 10],
    color: Colors.grey,
    strokeWidth: 2,
    child: Column (
      children:<Widget>[
        CircleAvatar(
          backgroundColor: AppColors.shade1,
          radius: 10,
          child: Icon(
            Icons.add,
            color: AppColors.light,
            size: 15,
          ),
        ),
        Text("Add a new store", style: TextStyle(color: AppColors.shade4))
      ]
    )

    );

  }}