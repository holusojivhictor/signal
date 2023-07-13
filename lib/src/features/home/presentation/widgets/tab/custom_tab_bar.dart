import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signal/src/features/common/domain/constants.dart';
import 'package:signal/src/features/common/presentation/styles.dart';
import 'package:signal/src/features/home/domain/enums/enums.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({required this.tabController, super.key});

  final TabController tabController;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    widget.tabController.addListener(() {
      setState(() {
        currentIndex = widget.tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: TabBar(
        controller: widget.tabController,
        padding: Styles.edgeInsetVertical16,
        indicator: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: Styles.stadiumBorder,
        ),
        dividerColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
        onTap: (_) {
          HapticFeedback.selectionClick();
        },
        tabs: <Widget>[
          for (var i = 0; i < Tracker.values.length; i++)
            Tab(
              height: 40,
              key: ValueKey<Tracker>(Tracker.values.elementAt(i)),
              child: AnimatedContainer(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                duration: Constants.kAnimationDuration,
                child: Text(
                  Tracker.values.elementAt(i).label,
                  key: ValueKey<String>(
                    '${Tracker.values.elementAt(i).label}-${currentIndex == i}',
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
