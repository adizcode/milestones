import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milestones/models/milestone.dart';
import 'package:milestones/services/database.dart';
import 'package:milestones/shared/constants.dart';
import 'package:milestones/shared/milestones_snackbar.dart';
import 'package:milestones/shared/validators.dart';
import 'package:milestones/widgets/frosted_glass_filter.dart';
import 'package:sizer/sizer.dart';

class MilestonesDraggableScrollableSheet extends StatefulWidget {
  const MilestonesDraggableScrollableSheet(
      {Key? key, required this.milestonesList, required this.databaseService})
      : super(key: key);

  final List<Milestone> milestonesList;
  final DatabaseService databaseService;

  @override
  State<MilestonesDraggableScrollableSheet> createState() =>
      _MilestonesDraggableScrollableSheetState();
}

class _MilestonesDraggableScrollableSheetState
    extends State<MilestonesDraggableScrollableSheet> {
  static const double minExtent = 0.1;
  static const double maxExtent = 0.9;

  final _formKey = GlobalKey<FormState>();
  final _initialExtent = 0.1;
  bool _isExpanded = false;
  String _milestoneTask = '';

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableActuator(
      child: NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          _isExpanded = notification.extent > 0.7;

          // setState does not update initialChildSize
          // Understand keys and make the actuator work

          // initialExtent = maxExtent;
          // print(initialExtent);
          //
          // setState((){});
          // print('still here');
          // print(notification.initialExtent);

          return true;
        },
        child: DraggableScrollableSheet(
          initialChildSize: _initialExtent,
          minChildSize: minExtent,
          maxChildSize: maxExtent,
          builder: (context, scrollController) {
            return Stack(
              children: [
                FrostedGlassFilter(
                  child: _milestonesWidgetBuilder(
                      scrollController, widget.milestonesList.length),
                  sigmaX: 1,
                  sigmaY: 1,
                ),
                _milestonesFabBuilder(() {
                  // Use the Actuator to open the sheet if not already open, and then animate it
                  // DraggableScrollableActuator.reset(context);

                  // Only perform action if sheet is expanded
                  if (_isExpanded) {
                    showDialog(
                      context: context,
                      builder: _milestonesDialogBuilder,
                    );
                  } else {
                    showMilestonesSnackBar(
                      context: context,
                      text: 'Please drag the bottom sheet to open it',
                    );
                  }
                }),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _milestonesWidgetBuilder(
      ScrollController scrollController, int milestonesCount) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: ListView.builder(
          controller: scrollController,
          itemCount: milestonesCount,
          itemBuilder: _milestonesItemBuilder,
          physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }

  Widget _milestonesItemBuilder(BuildContext context, int index) {
    final milestone = widget.milestonesList[index];

    // Add Animated Padding
    return Dismissible(
      key: Key(milestone.id),
      onDismissed: (direction) async {
        // Delete milestone
        await widget.databaseService.deleteMilestone(milestone.id);

        showMilestonesSnackBar(
          context: context,
          text: 'Milestone deleted',
          padding: EdgeInsets.symmetric(vertical: 1.75.h),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 3.h),
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius / 4)),
          child: ListTile(
            title: Text(
              milestone.task,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: colorPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              // Modify milestone
            },
            onLongPress: () {
              // Select milestone
            },
          ),
        ),
      ),
      background: Padding(
        padding: EdgeInsets.symmetric(vertical: 3.h),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius / 4),
            color: colorAccent,
          ),
          child: Center(
            child: Text(
              'Remove',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _milestonesFabBuilder(Function()? onPressed) {
    return Align(
      alignment: const Alignment(0, 0.8),
      child: Padding(
        padding: EdgeInsets.all(2.5.w),
        child: SizedBox(
          height: 15.w,
          width: 15.w,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: onPressed,
              child: const Icon(Icons.add),
              backgroundColor: colorPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _milestonesDialogBuilder(BuildContext context) {
    return FrostedGlassFilter(
      sigmaX: 1,
      sigmaY: 1,
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius / 2),
        ),
        elevation: 2,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          height: 28.h,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  initialValue: _milestoneTask,
                  onChanged: (task) => _milestoneTask = task,
                  validator: emptyTextValidator,
                  decoration: textInputDecoration.copyWith(
                    labelText: 'What did you achieve?',
                    labelStyle: GoogleFonts.poppins(
                      color: colorPrimary,
                      fontSize: 12.sp,
                    ),
                  ),
                  cursorColor: colorPrimary,
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Validate form field
                    if (_formKey.currentState?.validate() ?? false) {
                      // Add milestone
                      await widget.databaseService.setMilestone(
                        {'task': _milestoneTask},
                      );

                      // Close dialog
                      Navigator.pop(context);

                      // Reset form field
                      _milestoneTask = '';
                    }
                  },
                  child: const Text(
                    'Add Milestone',
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromHeight(5.h),
                    primary: colorPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
