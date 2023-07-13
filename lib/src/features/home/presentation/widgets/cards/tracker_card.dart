import 'package:flutter/material.dart';
import 'package:signal/src/features/common/presentation/styles.dart';
import 'package:signal/src/features/home/domain/enums/enums.dart';
import 'package:signal/src/features/home/presentation/widgets/lists/trackers_list_view.dart';

const _kPadding = EdgeInsets.only(bottom: 15, right: 16, left: 16);

class TrackerCard extends StatelessWidget {
  const TrackerCard({
    required this.item,
    required this.type,
    super.key,
    this.elevation = 0,
  });

  final TrackerItem item;
  final Tracker type;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: elevation,
      color: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: Styles.defaultBorderRadius,
      ),
      margin: _kPadding,
      child: SizedBox(
        height: 70,
        child: Padding(
          padding: Styles.edgeInsetAll10,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      item.name,
                      style: textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      type == Tracker.groups
                          ? 'Signal group'
                          : item.description,
                      style: textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 20,
                child: _StatusTag(active: item.active),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusTag extends StatelessWidget {
  const _StatusTag({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: active
            ? const Color(0xFF94FFCD).withOpacity(0.1)
            : const Color(0xFF8B8B8B).withOpacity(0.1),
        borderRadius: Styles.formBorderRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 3,
            backgroundColor:
                active ? const Color(0xFF60FFB5) : const Color(0xFF8B8B8B),
          ),
          const SizedBox(width: 8),
          Text(
            active ? 'Active' : 'Inactive',
            style: style!.copyWith(
              color: active ? const Color(0xFF60FFB5) : const Color(0xFF8B8B8B),
            ),
          ),
        ],
      ),
    );
  }
}
