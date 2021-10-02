import 'package:flutter/material.dart';
import 'package:milestones/widgets/milestones_bar.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  final void Function() toggleView;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100.h,
          width: 100.w,
          color: Colors.lightGreenAccent,
        ),
        Align(
          alignment: const Alignment(0, -1),
          child: MilestonesBar(
            onActionPressed: toggleView,
            actionIcon: Icons.login,
            actionLabel: 'Login',
          ),
        )
      ],
    );
  }
}
