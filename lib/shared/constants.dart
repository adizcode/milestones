import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// Colors
const colorPrimary = Color(0xFF08D9D6);
const colorBackground = Color(0xFFEAEAEA);
const colorAccent = Color(0xFFFF2E63);

// Properties
final borderRadius = 4.h;


final textInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 3.w),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: colorPrimary, width: 1),
    borderRadius: BorderRadius.circular(2.w),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: colorPrimary, width: 2),
    borderRadius: BorderRadius.circular(2.w),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: colorAccent),
    borderRadius: BorderRadius.circular(2.w),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: colorAccent),
    borderRadius: BorderRadius.circular(2.w),
  ),
  errorStyle: const TextStyle(color: colorAccent),
  labelStyle: const TextStyle(color: colorPrimary),
);
