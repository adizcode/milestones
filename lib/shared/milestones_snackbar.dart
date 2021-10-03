import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'constants.dart';

void showMilestonesSnackBar({
  required BuildContext context,
  required String text,
  EdgeInsetsGeometry? padding,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 12.sp),
        textAlign: TextAlign.center,
      ),
      backgroundColor: colorPrimary,
      behavior: SnackBarBehavior.fixed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: 4.w,
            vertical: 3.5.h,
          ),
    ),
  );
}
