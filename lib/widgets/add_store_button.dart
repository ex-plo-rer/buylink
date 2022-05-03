import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/widgets/spacing.dart';
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
    return GestureDetector(
      onTap: onTapped,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
          child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(20),
              dashPattern: [18, 10],
              color: AppColors.primaryColor,
              strokeWidth: 2,
              child: SizedBox(
                  height: 190,
                  width: 156,
                  child: Column(children: const <Widget>[
                    Spacing.largeHeight(),
                    Spacing.largeHeight(),
                    CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      radius: 16,
                      child: Icon(
                        Icons.add,
                        color: AppColors.light,
                        size: 20,
                      ),
                    ),
                    Text("Add a new store",
                        style: TextStyle(
                            color: AppColors.primaryColor, fontSize: 16))
                  ])))
      ),
    );
  }
}
