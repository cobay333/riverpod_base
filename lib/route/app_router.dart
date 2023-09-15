import 'package:base_riverpod/feature/setting/setting_screen.dart';
import 'package:base_riverpod/route/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../feature/home/home_screen.dart';
import '../widgets/scaffold_with_nested_navigation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) { /// Use this for testing to change the initial
  /// location and quickly access some page
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'Home');
  final shellNavigatorSettingKey = GlobalKey<NavigatorState>(debugLabel: 'Setting');
  return GoRouter(
    initialLocation: RoutePaths.home,
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    errorBuilder: (context, state) => Container(),
    routes: [
      StatefulShellRoute.indexedStack(branches: [
        StatefulShellBranch(navigatorKey: shellNavigatorHomeKey,routes: [
          GoRoute(path: RoutePaths.home, pageBuilder: (context, state) {
            return const NoTransitionPage(child: HomeScreen());
          },
          routes: [])
        ]),
        StatefulShellBranch(navigatorKey: shellNavigatorSettingKey,routes: [
          GoRoute(path: RoutePaths.detail, pageBuilder: (context, state) {
            return const NoTransitionPage(child: SettingScreen());
          },routes: [])
        ]),
      ],
          builder: (context, state, navigationShell) {
            return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
          },
  )
    ],
  );
}