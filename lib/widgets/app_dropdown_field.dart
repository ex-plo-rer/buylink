import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';

class AppDropdownField extends StatelessWidget {
  final String title;
  final String? Function(String?)? validator;
  final double borderRadius;
  final String? hintText;
  final Function(dynamic)? onChanged;
  final Widget? prefixIcon;
  final Color? fillColor;
  final List<DropdownMenuItem> items;
  final Key? dKey;

  const AppDropdownField({
    Key? key,
    this.title = '',
    this.validator,
    this.borderRadius = 8,
    this.hintText,
    this.onChanged,
    this.prefixIcon,
    this.fillColor = AppColors.transparent,
    required this.items,
    this.dKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              // color: AppColors.getColorFromHex('3A4150'),
              fontSize: 12,
            ),
          ),
          const Spacing.tinyHeight(),

          DropdownButtonFormField(
            isExpanded: true,
            // value: addProductNotifier.categoryValue,
            key: dKey,
            hint: Text(hintText != null ? hintText! : ''),
            items: items,
            onChanged: onChanged,
            decoration: InputDecoration(
              isDense: true,
              fillColor: fillColor,
              filled: true,
              contentPadding: const EdgeInsets.all(16),
              // hintText: hintText,
              hintStyle: const TextStyle(fontSize: 14),
              prefixIcon: prefixIcon != null
                  ? UnconstrainedBox(
                  child: prefixIcon, alignment: Alignment.center)
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(color: AppColors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}