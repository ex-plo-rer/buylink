import 'package:buy_link/core/routes.dart';
import 'package:buy_link/core/utilities/extensions/strings.dart';
import 'package:buy_link/features/core/models/product_notification_model.dart';
import 'package:buy_link/services/navigation_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '../core/constants/colors.dart';

class NotificationTile extends ConsumerWidget {
  const NotificationTile({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductNotificationModel product;

  @override
  Widget build(BuildContext context, ref) {
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
              text: product.product,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  ref.read(navigationServiceProvider).navigateToNamed(
                        Routes.storeDirection,
                        arguments: product.store,
                      );
                },
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
        child: product.image.isEmpty ? Text(product.product.initials()) : null,
        backgroundImage: product.image.isEmpty
            ? null
            : CachedNetworkImageProvider(product.image),
        radius: 26,
      ),
      trailing: Text(
        DateFormat.jm().format(product.dateTime).toString(),
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
