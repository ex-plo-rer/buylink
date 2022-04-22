import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String? title;
  final String? Function(String?)? validator;
  final double borderRadius;
  final TextInputType? keyboardType;
  final String? hintText;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final bool hasBorder;

  const AppTextField({
    Key? key,
    this.title,
    this.validator,
    this.borderRadius = 8,
    this.keyboardType,
    this.hintText,
    this.onChanged,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.hasBorder = true,
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
              title!,
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
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(hasBorder ? 16 : 0),
              hintText: hintText,
              suffixIcon: UnconstrainedBox(
                child: suffixIcon,
                alignment: hasBorder ? Alignment.center : Alignment.topRight,
              ),
              border: hasBorder
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      borderSide: const BorderSide(),
                    )
                  : InputBorder.none,
              errorBorder: hasBorder
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      borderSide: const BorderSide(color: AppColors.red),
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
