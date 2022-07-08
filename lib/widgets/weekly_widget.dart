import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class WeeklyWidget extends StatelessWidget {
  const WeeklyWidget({
    Key? key,
    required this.category,
    required this.itemCount,
    required this.itemBuilder,
  }) : super(key: key);
  final String category;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Text(
                  category,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: AppColors.grey4,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ListView.separated(
                // scrollDirection: Axis.horizontal,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: itemCount,
                itemBuilder: itemBuilder,
                separatorBuilder: (BuildContext context, int index) =>
                    const Spacing.smallHeight(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
