import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String title;
  final String? Function(String?)? validator;
  final double borderRadius;
  final TextInputType? keyboardType;
  final String? hintText;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final bool hasBorder;
  final bool isSearch;
  final Color? fillColor;
  final bool hasPrefixIcon;
  final bool hasSuffixIcon;
  final int? maxLines;
  final bool? enabled;
  final void Function()? onTap;

  const AppTextField({
    Key? key,
    this.title = '',
    this.validator,
    this.borderRadius = 8,
    this.keyboardType,
    this.hintText,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.hasBorder = true,
    this.isSearch = false,
    this.fillColor = AppColors.transparent,
    this.hasPrefixIcon = false,
    this.hasSuffixIcon = true,
    this.maxLines = 1,
    this.enabled,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: hasBorder,
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.getColorFromHex('3A4150'),
                fontSize: 12,
              ),
            ),
          ),
          const Spacing.tinyHeight(),
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            validator: validator,
            obscureText: obscureText,
            onFieldSubmitted: onFieldSubmitted,
            onTap: onTap,
            maxLines: maxLines,
            enabled: enabled,
            decoration: InputDecoration(
              isDense: true,
              fillColor: fillColor,
              filled: true,
              contentPadding: EdgeInsets.all(
                hasBorder
                    ? 16
                    : isSearch
                        ? 16
                        : 0,
              ),
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 14),
              suffixIcon: hasSuffixIcon
                  ? UnconstrainedBox(
                      child: suffixIcon,
                      alignment:
                          hasBorder ? Alignment.center : Alignment.topRight,
                    )
                  : null,
              prefixIcon: hasPrefixIcon
                  ? UnconstrainedBox(
                      child: prefixIcon,
                      alignment: hasBorder
                          ? Alignment.center
                          : isSearch
                              ? Alignment.center
                              : Alignment.topCenter,
                    )
                  : null,
              border: hasBorder
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      borderSide: const BorderSide(),
                    )
                  : isSearch
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                          borderSide: BorderSide.none,
                        )
                      : InputBorder.none,
              errorBorder: hasBorder
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      borderSide: const BorderSide(color: AppColors.red),
                    )
                  : isSearch
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                          borderSide: BorderSide.none,
                        )
                      : InputBorder.none,
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
