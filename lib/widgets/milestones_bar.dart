import 'package:flutter/material.dart';
import 'package:milestones/shared/constants.dart';
import 'package:sizer/sizer.dart';

class MilestonesBar extends StatefulWidget {
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
  State<MilestonesBar> createState() => _MilestonesBarState();
}

class _MilestonesBarState extends State<MilestonesBar> {

  bool isVisible = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 0), () {
        setState(() => isVisible = true);
      });
    });
  }

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
            AnimatedOpacity(
              opacity: isVisible ? 1 : 0,
              duration: fadeDuration,
              child: TextButton.icon(
                onPressed: widget.onActionPressed,
                icon: Icon(
                  widget.actionIcon,
                  size: 6.w,
                  color: colorPrimary,
                ),
                label: Text(
                  widget.actionLabel,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: colorPrimary,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
