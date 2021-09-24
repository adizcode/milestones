import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:milestones/services/auth.dart';
import 'package:sizer/sizer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class MilestonesProgressWidget extends StatelessWidget {
  const MilestonesProgressWidget(
      {Key? key,
      required this.totalMilestonesCount,
      required this.currentMilestonesCount})
      : super(key: key);

  final int totalMilestonesCount;
  final int currentMilestonesCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100.h,
          width: 100.w,
          color: Colors.lightGreenAccent,
          child: Padding(
            padding: EdgeInsets.all(4.5.w),
            child: _milestonesProgressIndicatorBuilder(),
          ),
        ),
        Align(
          alignment: const Alignment(0, -1),
          child: Card(
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
                      color: Colors.blue,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      await AuthService().signOut();
                    },
                    icon: Icon(
                      Icons.logout,
                      size: 6.w,
                    ),
                    label: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _milestonesProgressIndicatorBuilder() {
    const Color selectedColor = Colors.blue;
    final Color unselectedColor = Colors.grey[200]!;

    return StepProgressIndicator(
      totalSteps: totalMilestonesCount,
      currentStep: currentMilestonesCount,
      size: 8.w,
      selectedColor: selectedColor,
      unselectedColor: unselectedColor,
      customStep: (index, color, _) {
        return Container(
          color: color,
          child: color == selectedColor
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.remove,
                ),
        );
      },
    );
  }
}
