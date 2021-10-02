import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MilestonesBackground extends StatelessWidget {
  const MilestonesBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.w,
      color: Colors.lightGreenAccent,
      child: Center(
        child: child,
      ),
    );
  }
}
