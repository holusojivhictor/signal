import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:signal/src/features/common/application/bloc.dart';
import 'package:signal/src/features/common/presentation/colors.dart';
import 'package:signal/src/features/common/presentation/navigation_bar/navigation_bar.dart';
import 'package:signal/src/features/common/presentation/styles.dart';
import 'package:signal/src/features/home/application/home_bloc.dart';
import 'package:signal/src/utils/utils.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({required this.shell, super.key});

  final StatefulNavigationShell shell;

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  DateTime? backButtonPressTime;
  bool _didChangeDependencies = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didChangeDependencies) return;
    _didChangeDependencies = true;
    context.read<HomeBloc>().add(HomeInit());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleWillPop,
      child: Scaffold(
        body: widget.shell,
        bottomNavigationBar: AnimatedNavigationBar(
          iconSize: 22,
          shape: Styles.navBarShape,
          currentIndex: widget.shell.currentIndex,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.grey3,
          backgroundColor: AppColors.secondaryShade.withOpacity(0.6),
          onItemSelected: _goBranch,
          items: const [
            NavigationBarItem(
              icon: Icon(
                Icons.pie_chart_outline_rounded,
                color: AppColors.grey4,
              ),
              activeIcon: Icon(Icons.pie_chart_rounded),
              title: 'Home',
            ),
            NavigationBarItem(
              icon: Icon(
                Icons.add_chart_outlined,
                color: AppColors.grey4,
              ),
              activeIcon: Icon(Icons.add_chart_rounded),
              title: 'Track',
            ),
            NavigationBarItem(
              icon: Icon(
                Icons.settings_outlined,
                color: AppColors.grey4,
              ),
              activeIcon: Icon(Icons.settings_rounded),
              title: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  void _goBranch(int index) {
    widget.shell.goBranch(
      index,
      initialLocation: index == widget.shell.currentIndex,
    );
  }

  Future<bool> handleWillPop() async {
    if (widget.shell.currentIndex != 0) {
      _goBranch(0);
      return false;
    }

    final settings = context.read<SettingsBloc>();
    if (!settings.doubleBackToClose) {
      return true;
    }

    final now = DateTime.now();
    final mustWait = backButtonPressTime == null ||
        now.difference(backButtonPressTime!) > ToastUtils.toastDuration;

    if (mustWait) {
      backButtonPressTime = now;
      final fToast = ToastUtils.of(context);
      ToastUtils.showInfoToast(fToast, 'Press once again to exit');
      return false;
    }

    return true;
  }
}
