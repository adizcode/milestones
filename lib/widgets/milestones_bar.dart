import 'package:flutter/material.dart';
import 'package:milestones/shared/constants.dart';
import 'package:sizer/sizer.dart';

class MilestonesBar extends StatelessWidget {
  const MilestonesBar({
    Key? key,
    required this.onActionPressed,
    required this.actionIcon,
    required this.actionLabel,
  }) : super(key: key);

  final void Function()? onActionPressed;
  final IconData? actionIcon;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.4),
      margin: EdgeInsets.zero,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 1.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Milestones',
              style: TextStyle(
                color: colorPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextButton.icon(
              onPressed: onActionPressed,
              icon: Icon(
                actionIcon,
                size: 6.w,
              ),
              label: Text(
                actionLabel,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
