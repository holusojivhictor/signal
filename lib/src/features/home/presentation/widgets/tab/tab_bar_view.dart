import 'package:flutter/material.dart';
import 'package:signal/src/features/home/domain/enums/enums.dart';
import 'package:signal/src/features/home/presentation/widgets/lists/trackers_list_view.dart';

class CustomTabBarView extends StatelessWidget {
  const CustomTabBarView({required this.tabController, super.key});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: TabBarView(
        controller: tabController,
        children: <Widget>[
          for (final type in Tracker.values)
            TrackersListView(
              key: ValueKey<Tracker>(type),
            ),
        ],
      ),
    );
  }
}
