import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/main_navigation/presentation/pages/main_scaffold.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/home/presentation/pages/student_dashboard_page.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorDashboard = GlobalKey<NavigatorState>(debugLabel: 'shell_dashboard');
final GlobalKey<NavigatorState> _shellNavigatorSearch = GlobalKey<NavigatorState>(debugLabel: 'shell_search');
final GlobalKey<NavigatorState> _shellNavigatorBrain = GlobalKey<NavigatorState>(debugLabel: 'shell_brain');
final GlobalKey<NavigatorState> _shellNavigatorJournals = GlobalKey<NavigatorState>(debugLabel: 'shell_journals');
final GlobalKey<NavigatorState> _shellNavigatorProfile = GlobalKey<NavigatorState>(debugLabel: 'shell_profile');

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const OnboardingPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScaffold(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorDashboard,
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const StudentDashboardPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSearch,
          routes: [
            GoRoute(
              path: '/search',
              builder: (context, state) => const Scaffold(body: Center(child: Text("Search Space"))),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBrain,
          routes: [
            GoRoute(
              path: '/brain',
              builder: (context, state) => const Scaffold(body: Center(child: Text("Core AI Brain"))),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorJournals,
          routes: [
            GoRoute(
              path: '/journals',
              builder: (context, state) => const Scaffold(body: Center(child: Text("Journals History"))),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProfile,
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const Scaffold(body: Center(child: Text("User Profile"))),
            ),
          ],
        ),
      ],
    ),
  ],
);
