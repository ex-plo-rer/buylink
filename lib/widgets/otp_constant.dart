import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: 20),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    // borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Colors.black),
  );
}
