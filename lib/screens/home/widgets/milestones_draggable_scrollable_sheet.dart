import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milestones/models/milestone.dart';
import 'package:milestones/services/database.dart';
import 'package:milestones/shared/constants.dart';
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
  static const double maxExtent = 1;

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
                  sigmaX: 5,
                  sigmaY: 5,
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Drag the sheet to expand it'),
                      ),
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
          topLeft: Radius.circular(8.w),
          topRight: Radius.circular(8.w),
        ),
      ),
      child: ListView.builder(
        controller: scrollController,
        itemCount: milestonesCount,
        itemBuilder: _milestonesItemBuilder,
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

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Milestone dismissed'),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.w)),
          child: ListTile(
            title: Text(
              milestone.task,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
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
    );
  }

  Widget _milestonesFabBuilder(Function()? onPressed) {
    return Align(
      alignment: const Alignment(0, 0.8),
      child: Padding(
        padding: EdgeInsets.all(2.5.w),
        child: SizedBox(
          height: 17.w,
          width: 17.w,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: onPressed,
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }

  Widget _milestonesDialogBuilder(BuildContext context) {
    return FrostedGlassFilter(
      sigmaX: 5,
      sigmaY: 5,
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.w),
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
                      labelText: 'What did you achieve?'),
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
