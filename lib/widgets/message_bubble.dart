import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({
    Key? key,
    required this.currentUserId,
    required this.storeId,
    required this.senderId,
    required this.text,
    required this.timeStamp,
    required this.isImage,
    // required this.isUser,
  }) : super(key: key);

  dynamic currentUserId;
  dynamic storeId;
  dynamic senderId;
  final String text;
  final DateTime timeStamp;
  final bool isImage;
  // final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: storeId == null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(
                  alignment: currentUserId == senderId
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Padding(
                    padding: currentUserId == senderId
                        ? EdgeInsets.only(left: 100.0)
                        : EdgeInsets.only(right: 100.0),
                    child: Material(
                      elevation: 5,
                      color: currentUserId == senderId
                          ? AppColors.shade5
                          : AppColors.shade1,
                      borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(currentUserId == senderId ? 10 : 0),
                        topRight:
                            Radius.circular(currentUserId == senderId ? 0 : 10),
                        bottomLeft: const Radius.circular(10),
                        bottomRight: const Radius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 8,
                        ),
                        child: isImage
                            ? Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(text),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                // child: CachedNetworkImage(
                                //   imageUrl: text,
                                //   fit: BoxFit.fill,
                                // ),
                              )
                            : Text(
                                text,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: currentUserId == senderId
                                      ? AppColors.light
                                      : AppColors.shade5,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                const Spacing.smallHeight(),
                Align(
                  alignment: currentUserId == senderId
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Text(
                    DateFormat.jm().format(timeStamp),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.grey4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // const Spacing.smallHeight(),
                // Row(
                //   children: [
                // Text(
                //   '4:00 PM',
                //   style: TextStyle(
                //     fontSize: 12,
                //     color: AppColors.grey4,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                // Icon(
                //   Icons.check,
                //   size: 10,
                // ),
                //   ],
                // ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(
                  alignment: storeId == senderId
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Padding(
                    padding: storeId == senderId
                        ? EdgeInsets.only(left: 100.0)
                        : EdgeInsets.only(right: 100.0),
                    child: Material(
                      elevation: 5,
                      color: storeId == senderId
                          ? AppColors.shade5
                          : AppColors.shade1,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(storeId == senderId ? 10 : 0),
                        topRight: Radius.circular(storeId == senderId ? 0 : 10),
                        bottomLeft: const Radius.circular(10),
                        bottomRight: const Radius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 8,
                        ),
                        child: isImage
                            ? Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(text),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                // child: CachedNetworkImage(
                                //   imageUrl: text,
                                //   fit: BoxFit.fill,
                                // ),
                              )
                            : Text(
                                text,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: storeId == senderId
                                      ? AppColors.light
                                      : AppColors.shade5,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                const Spacing.smallHeight(),
                Align(
                  alignment: currentUserId == senderId
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Text(
                    DateFormat.jm().format(timeStamp),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.grey4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // const Spacing.smallHeight(),
                // Row(
                //   children: [
                // Text(
                //   '4:00 PM',
                //   style: TextStyle(
                //     fontSize: 12,
                //     color: AppColors.grey4,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                // Icon(
                //   Icons.check,
                //   size: 10,
                // ),
                //   ],
                // ),
              ],
            ),
    );
  }
}
