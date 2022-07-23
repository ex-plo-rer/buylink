import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
import 'app_button.dart';

class AppEmptyStates extends StatelessWidget {
  const AppEmptyStates({
    Key? key,
    required this.imageString,
    required this.message1String,
    this.message2String,
    required this.buttonString,
    this.onButtonPressed,
    this.hasButton = false,
    this.hasIcon = true,
  }) : super(key: key);
  final String imageString;
  final String message1String;
  final String? message2String;
  final String buttonString;
  final bool hasButton;
  final bool hasIcon;
  final void Function()? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacing.empty(),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(imageString),
              const Spacing.mediumHeight(),
              Text(
                message1String,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacing.smallHeight(),
              Text(
                message2String ?? '',
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Visibility(
          visible: hasButton,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 44.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 132,
              child: AppButton(
                onPressed: onButtonPressed,
                hasIcon: hasIcon,
                icon: !hasIcon
                    ? null
                    : const Icon(
                        Icons.add,
                        color: AppColors.light,
                      ),
                text: buttonString,
                backgroundColor: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
