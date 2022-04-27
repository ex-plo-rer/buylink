import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/material.dart';

class ReviewTextField extends StatelessWidget {
  final String title;
  final String? Function(String?)? validator;
  final double borderRadius;
  final TextInputType? keyboardType;
  final String? hintText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final Color? fillColor;
  final int? maxLine;
  final int? noOfChar;

  const ReviewTextField({
    Key? key,
    this.title = '',
    this.validator,
    this.borderRadius = 8,
    this.keyboardType,
    this.hintText,
    this.onChanged,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.fillColor = AppColors.grey8,
    this.maxLine = 3,
    this.noOfChar,
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
              color: AppColors.dark,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacing.tinyHeight(),
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            validator: validator,
            onFieldSubmitted: onFieldSubmitted,
            maxLines: maxLine,
            decoration: InputDecoration(
              isDense: true,
              fillColor: fillColor,
              filled: true,
              contentPadding: const EdgeInsets.all(16),
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: onChanged,
          ),
          Text(
            '$noOfChar characters left',
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.grey5,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
