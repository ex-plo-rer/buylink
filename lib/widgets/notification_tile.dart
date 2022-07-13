import 'package:buy_link/core/utilities/extensions/strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/constants/colors.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    Key? key,
    required this.productName,
    required this.productImage,
    required this.dateTime,
  }) : super(key: key);
  final String productName;
  final String productImage;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
      title: RichText(
        //textAlign: TextAlign.,
        text: TextSpan(
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            const TextSpan(
              text: "A store selling ",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppColors.grey5),
            ),
            TextSpan(
              text: productName,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
            const TextSpan(
                text: " is around your present location.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColors.grey5))
          ],
        ),
      ),
      leading: CircleAvatar(
        backgroundColor: AppColors.shade3,
        child: productImage.isEmpty ? Text(productName.initials()) : null,
        backgroundImage: productImage.isEmpty
            ? null
            : CachedNetworkImageProvider(productImage),
        radius: 26,
      ),
      trailing: Text(
        DateFormat.jm().format(dateTime).toString(),
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
