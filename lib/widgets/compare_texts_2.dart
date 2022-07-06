import 'package:flutter/material.dart';

import 'compare_texts.dart';

class CompareTexts2 extends StatelessWidget {
  final String title;
  final String subTitle1;
  final String subTitle2;
  final bool haveProductToCompare;

  const CompareTexts2({
    Key? key,
    required this.title,
    required this.subTitle1,
    required this.subTitle2,
    this.haveProductToCompare = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.max,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: ((MediaQuery.of(context).size.width - 40) / 2) + 6,
              child: CompareTexts(
                title: title,
                subTitle: subTitle1,
              ),
            ),
            haveProductToCompare
                ? SizedBox(
                    width: ((MediaQuery.of(context).size.width - 40) / 2) - 6,
                    child: CompareTexts(
                      title: '',
                      subTitle: subTitle2,
                    ),
                  )
                : Container(),
          ],
        ),
        SizedBox(
          width: haveProductToCompare
              ? null
              : ((MediaQuery.of(context).size.width - 40) / 2) - 6,
          child: const Divider(thickness: 2),
        ),
      ],
    );
  }
}
