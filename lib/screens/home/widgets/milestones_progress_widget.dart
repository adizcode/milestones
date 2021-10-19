import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:milestones/shared/constants.dart';
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
    return Center(
      child: Padding(
        padding: EdgeInsets.all(4.5.w),
        child: _milestonesProgressIndicatorBuilder(),
      ),
    );
  }

  Widget _milestonesProgressIndicatorBuilder() {
    const Color selectedColor = colorPrimary;
    final Color unselectedColor = Colors.grey[200]!;

    return StepProgressIndicator(
      totalSteps: totalMilestonesCount,
      currentStep: currentMilestonesCount,
      size: 8.w,
      selectedColor: selectedColor,
      unselectedColor: unselectedColor,
      customStep: (index, color, _) {
        return Material(
          borderRadius: BorderRadius.circular(0.5.w),
          color: color,
          child: color == selectedColor
              ? InkWell(
                  onTap: () {},
                  splashColor: colorPrimaryLight,
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                )
              : InkWell(
                  onTap: () {},
                  splashColor: Colors.white,
                  child: const Icon(
                    Icons.remove,
                    color: selectedColor,
                  ),
                ),
        );
      },
    );
  }
}
