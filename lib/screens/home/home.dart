import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milestones/models/milestone.dart';
import 'package:milestones/models/user.dart';
import 'package:milestones/screens/home/widgets/milestones_progress_widget.dart';
import 'package:milestones/services/auth.dart';
import 'package:milestones/services/database.dart';
import 'package:milestones/shared/constants.dart';
import 'package:milestones/shared/milestones_snackbar.dart';
import 'package:milestones/widgets/milestones_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// Constant
const int _totalMilestonesCount = 10;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final DatabaseService db;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    db = DatabaseService(Provider.of<User?>(context)!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Milestone>>(
      stream: db.milestones,
      builder: (context, snapshot) {
        return MilestonesScaffold(
          onActionPressed: () async {
            await AuthService().signOut();
          },
          actionIcon: Icons.logout,
          actionLabel: 'Logout',
          child: SlidingUpPanel(
            panelBuilder: (scrollController) => _milestonesWidgetBuilder(
              scrollController,
              snapshot.data ?? [],
            ),
            backdropEnabled: true,
            backdropOpacity: 0.1,
            body: MilestonesProgressWidget(
              totalMilestonesCount: _totalMilestonesCount,
              currentMilestonesCount: snapshot.data?.length ?? 0,
            ),
            minHeight: 12.h,
            maxHeight: 85.h,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius),
            ),
            color: colorPrimary.withOpacity(0.65),
            boxShadow: null,
          ),
        );
      },
    );
  }

  Widget _milestonesItemBuilder(BuildContext context, Milestone milestone) {
    // Add Animated Padding
    return Dismissible(
      key: Key(milestone.id),
      onDismissed: (direction) async {
        // Delete milestone
        await db.deleteMilestone(milestone.id);

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

  Widget _milestonesWidgetBuilder(
      ScrollController scrollController, List<Milestone> milestones) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: ListView.builder(
        controller: scrollController,
        itemCount: milestones.length,
        itemBuilder: (context, index) =>
            _milestonesItemBuilder(context, milestones[index]),
      ),
    );
  }
}
