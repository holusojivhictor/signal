import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:signal/src/config/injection.dart';
import 'package:signal/src/features/auth/application/auth_bloc.dart';
import 'package:signal/src/features/auth/presentation/login_page.dart';
import 'package:signal/src/features/common/presentation/splash/animated_splash.dart';
import 'package:signal/src/features/home/presentation/home_page.dart';
import 'package:signal/src/routing/go_router_refresh_stream.dart';
import 'package:signal/src/routing/mobile_scaffold.dart';

enum AppRoute {
  splash('/splash'),
  login('/login'),
  home('/'),
  track('/track'),
  settings('/settings');

  const AppRoute(this.path);

  final String path;
}

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final _homeKey = GlobalKey<NavigatorState>(debugLabel: 'home');

  static final _trackKey = GlobalKey<NavigatorState>(debugLabel: 'track');

  static final _settingsKey = GlobalKey<NavigatorState>(debugLabel: 'settings');

  static final GoRouter _router = GoRouter(
    initialLocation: AppRoute.splash.path,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    refreshListenable: GoRouterRefreshStream(getIt<AuthBloc>().stream),
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const AnimatedSplash(),
        ),
        redirect: (context, state) {
          final loggedIn = getIt<AuthBloc>().state.isLoggedIn;
          final loaded = getIt<AuthBloc>().state.status == AuthStatus.loaded;
          if (loaded && !loggedIn) {
            return AppRoute.login.path;
          } else if (loggedIn) {
            return AppRoute.home.path;
          }
          return null;
        },
      ),
      GoRoute(
        path: AppRoute.login.path,
        name: AppRoute.login.name,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const LoginPage(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MobileScaffold(shell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeKey,
            routes: [
              GoRoute(
                path: AppRoute.home.path,
                name: AppRoute.home.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const HomePage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _trackKey,
            routes: [
              GoRoute(
                path: AppRoute.track.path,
                name: AppRoute.track.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const Placeholder(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _settingsKey,
            routes: [
              GoRoute(
                path: AppRoute.settings.path,
                name: AppRoute.settings.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const Placeholder(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _router;
}
