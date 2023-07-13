import 'package:flutter/material.dart';
import 'package:signal/src/features/home/presentation/widgets/cards/tracker_card.dart';

class TrackerItem {
  const TrackerItem({
    required this.name,
    required this.description,
    required this.active,
  });

  final String name;
  final String description;
  final bool active;
}

const trackers = [
  TrackerItem(
    name: 'EMA Cross 50  200 + ADX (Long)',
    description: 'Distribution Bot',
    active: true,
  )
];

class TrackersListView extends StatelessWidget {
  const TrackersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        10,
        (index) => TrackerCard(
          item: trackers[0],
        ),
      ),
    );
  }
}
