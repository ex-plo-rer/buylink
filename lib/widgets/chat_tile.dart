import 'package:buy_link/core/utilities/extensions/strings.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    Key? key,
    // required this.isStore,
    required this.title,
    required this.imageUrl,
    required this.subtitle,
    required this.unreadCount,
    required this.time,
    required this.onTap,
  }) : super(key: key);

  // final bool isStore; // To specify where the widget is being used. This helps to know whether to display image or initials.
  final String? imageUrl;
  final String title;
  final String subtitle;
  final int unreadCount;
  final String time;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
      minVerticalPadding: 15,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      minLeadingWidth: 5,
      horizontalTitleGap: 5,
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.grey1,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: CircleAvatar(
        backgroundColor: AppColors.shade1,
        child: imageUrl == null ? Text(title.initials()) : null,
        backgroundImage:
            imageUrl == null ? null : CachedNetworkImageProvider(imageUrl!),
        radius: 28,
      ),
      subtitle: subtitle.startsWith('https://')
          ? const Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.image_outlined,
                color: AppColors.grey1,
                size: 12,
              ),
            )
          : Text(
              subtitle.characters
                  .replaceAll(Characters(''), Characters('\u{200B}'))
                  .toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.grey4,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
      trailing: unreadCount < 1
          ? const Spacing.empty()
          : Column(
              children: <Widget>[
                const SizedBox(height: 6),
                CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  child: Text(
                    unreadCount.toString(),
                    style: const TextStyle(fontSize: 12),
                  ),
                  radius: 10,
                ),
                Text(
                  time,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
      onTap: onTap,
    );
  }
}
