import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../core/constants/colors.dart';

class OTPInput extends StatelessWidget {
  const OTPInput({
    Key? key,
    this.pinLength = 4,
    required this.onChanged,
  }) : super(key: key);
  final int pinLength;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        child: PinCodeTextField(
          enableActiveFill: true,
          keyboardType: TextInputType.number,
          appContext: context,
          length: pinLength,
          cursorColor: AppColors.primaryColor,
          obscureText: false,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            activeColor: AppColors.primaryColor,
            inactiveColor: AppColors.grey6,
            disabledColor: AppColors.grey6,
            selectedColor: AppColors.primaryColor,
            inactiveFillColor: AppColors.transparent,
            activeFillColor: AppColors.transparent,
            selectedFillColor: AppColors.transparent,
            fieldHeight: 52,
            fieldWidth: 40,
            borderRadius: BorderRadius.circular(10),
          ),
          animationDuration: const Duration(milliseconds: 300),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
