import 'package:flutter/material.dart';
import 'package:milestones/models/milestone.dart';
import 'package:milestones/models/user.dart';
import 'package:milestones/services/auth.dart';
import 'package:milestones/services/database.dart';
import 'package:milestones/screens/home/widgets/milestones_draggable_scrollable_sheet.dart';
import 'package:milestones/screens/home/widgets/milestones_progress_widget.dart';
import 'package:milestones/widgets/milestones_scaffold.dart';
import 'package:provider/provider.dart';

// Constant
const int _totalMilestonesCount = 10;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DatabaseService db =
        DatabaseService(Provider.of<User?>(context)!.uid);

    return StreamBuilder<List<Milestone>>(
      stream: db.milestones,
      builder: (context, snapshot) {
        return MilestonesScaffold(
          onActionPressed: () async {
            await AuthService().signOut();
          },
          actionIcon: Icons.logout,
          actionLabel: 'Logout',
          child: Stack(
            children: [
              MilestonesProgressWidget(
                totalMilestonesCount: _totalMilestonesCount,
                currentMilestonesCount: snapshot.data?.length ?? 0,
              ),
              MilestonesDraggableScrollableSheet(
                  milestonesList: snapshot.data ?? [], databaseService: db),
            ],
          ),
        );
      },
    );
  }
}
