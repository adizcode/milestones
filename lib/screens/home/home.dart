import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milestones/models/milestone.dart';
import 'package:milestones/models/user.dart';
import 'package:milestones/screens/home/widgets/milestones_progress_widget.dart';
import 'package:milestones/services/auth.dart';
import 'package:milestones/services/database.dart';
import 'package:milestones/shared/constants.dart';
import 'package:milestones/shared/milestones_snackbar.dart';
import 'package:milestones/shared/validators.dart';
import 'package:milestones/widgets/frosted_glass_filter.dart';
import 'package:milestones/widgets/milestones_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  String _milestoneTask = '';

  PanelController panelController = PanelController();
  DatabaseService? db;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    db = DatabaseService(Provider.of<User?>(context)!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Milestone>>(
      initialData: const [],
      stream: db!.milestones,
      builder: (context, snapshot) {
        return MilestonesScaffold(
          onActionPressed: () async {
            await AuthService().signOut();
          },
          actionIcon: Icons.logout,
          actionLabel: 'Logout',
          child: AnimatedOpacity(
            opacity: isVisible ? 1 : 0,
            duration: fadeDuration,
            child: SlidingUpPanel(
              controller: panelController,
              panelBuilder: (scrollController) => milestonesWidgetBuilder(
                scrollController,
                snapshot.data ?? [],
              ),
              body: MilestonesProgressWidget(
                totalMilestonesCount: totalMilestonesCount,
                currentMilestonesCount: snapshot.data?.length ?? 0,
              ),
              collapsed: ElevatedButton(
                child: const Text('View Milestones'),
                onPressed: () => panelController.open(),
                style: ElevatedButton.styleFrom(
                  primary: colorPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius),
                    ),
                  ),
                  elevation: 0,
                  textStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              minHeight: 8.h,
              maxHeight: 85.h,
              parallaxEnabled: true,
              parallaxOffset: 1,
              backdropEnabled: true,
              backdropOpacity: 0.1,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
              ),
              color: colorPrimary,
              boxShadow: null,
            ),
          ),
        );
      },
    );
  }

  Widget milestonesItemBuilder(BuildContext context, Milestone milestone) {
    // Add Animated Padding
    return Dismissible(
      key: Key(milestone.id),
      onDismissed: (direction) async {
        // Delete milestone
        await db!.deleteMilestone(milestone.id);

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
                fontSize: 13.sp,
                color: colorPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              // Modify milestone
              showDialog(
                context: context,
                builder: (context) => milestonesDialogBuilder(
                  context,
                  milestone: milestone,
                ),
              );
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

  Widget milestonesWidgetBuilder(
      ScrollController scrollController, List<Milestone> milestones) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        child: Stack(
          children: [
            ListView.builder(
              controller: scrollController,
              itemCount: milestones.length,
              itemBuilder: (context, index) =>
                  milestonesItemBuilder(context, milestones[index]),
            ),
            Align(
              alignment: const Alignment(0, 0.95),
              child: FloatingActionButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => milestonesDialogBuilder(context),
                ),
                child: const Icon(Icons.add),
                backgroundColor: colorAccentLight,
              ),
            )
          ],
        ));
  }

  Widget milestonesDialogBuilder(BuildContext context, {Milestone? milestone}) {
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
                  initialValue: milestone?.task ?? _milestoneTask,
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
                      await db!.setMilestone(
                        {'task': _milestoneTask},
                        id: milestone?.id,
                      );

                      // Close dialog
                      Navigator.pop(context);

                      // Reset form field
                      _milestoneTask = '';
                    }
                  },
                  child: Text(
                    milestone == null ? 'Add Milestone' : 'Set Milestone',
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
