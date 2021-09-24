import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedGlassFilter extends StatelessWidget {
  const FrostedGlassFilter({
    Key? key,
    required this.child,
    this.sigmaX = 0,
    this.sigmaY = 0,
  }) : super(key: key);

  final Widget child;
  final double sigmaX;
  final double sigmaY;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: child,
      ),
    );
  }
}
