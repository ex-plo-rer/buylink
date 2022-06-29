import 'package:buy_link/core/constants/colors.dart';
import 'package:buy_link/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants/svgs.dart';

class SpecialTextField extends StatelessWidget {
  final double height;
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
  final void Function()? onTap;
  final String sub;
  final String tit;

  const SpecialTextField({
    Key? key,
    this.height = 52,
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
    this.onTap,
    required this.sub,
    required this.tit,
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
            style: TextStyle(
              color: AppColors.getColorFromHex('3A4150'),
              fontSize: 12,
            ),
          ),
          const Spacing.tinyHeight(),
          Container(
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('$tit'),
                ),
                TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  keyboardType: keyboardType,
                  validator: validator,
                  obscureText: obscureText,
                  onFieldSubmitted: onFieldSubmitted,
                  onTap: onTap,
                  maxLines: maxLines,
                  decoration: InputDecoration(
                    isDense: true,
                    // contentPadding: const EdgeInsets.all(16),
                    hintText: hintText,
                    hintStyle: const TextStyle(fontSize: 14),
                    prefixIconConstraints:
                        const BoxConstraints(minWidth: 0, minHeight: 20),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                        height: 12,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppSvgs.naira, height: 13, width: 13,color:
                          //  controller!.text.isEmpty?
                            AppColors.grey5
                            //AppColors.primaryColor,
                            ),
                            Spacing.tinyWidth(),
                            Container(
                              height: 25,
                              width: 2,
                              color: Colors.grey,
                            ),
                            const Text(' '),
                          ],
                        ),
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: onChanged,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
