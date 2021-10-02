import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

final textInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 3.w),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(2.w),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.blue, width: 2),
    borderRadius: BorderRadius.circular(2.w),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.pink),
    borderRadius: BorderRadius.circular(2.w),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.pink),
    borderRadius: BorderRadius.circular(2.w),
  ),
  errorStyle: const TextStyle(color: Colors.pink),
);
