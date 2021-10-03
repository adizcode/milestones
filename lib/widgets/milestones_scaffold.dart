import 'package:flutter/material.dart';
import 'package:milestones/shared/constants.dart';
import 'package:sizer/sizer.dart';

import 'milestones_bar.dart';

class MilestonesScaffold extends StatelessWidget {
  const MilestonesScaffold({
    Key? key,
    required this.child,
    this.showMilestonesBar = true,
    this.onActionPressed,
    this.actionIcon,
    this.actionLabel,
  }) : super(key: key);

  final Widget child;
  final bool showMilestonesBar;
  final void Function()? onActionPressed;
  final IconData? actionIcon;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 100.h,
              width: 100.w,
              color: colorBackground,
              child: Center(
                child: child,
              ),
            ),
            if (showMilestonesBar)
              Align(
                alignment: const Alignment(0, -1),
                child: MilestonesBar(
                  onActionPressed: onActionPressed,
                  actionIcon: actionIcon,
                  actionLabel: actionLabel ?? '',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
