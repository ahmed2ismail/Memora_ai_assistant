import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/main_navigation/presentation/pages/main_scaffold.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/home/presentation/pages/alzheimer_dashboard_page.dart';
import '../../features/home/presentation/pages/alzheimer_detail_page.dart';
import '../../features/home/presentation/pages/general_detail_page.dart';
import '../../features/home/presentation/pages/student_detail_page.dart';
import '../../features/ai_assistant/presentation/pages/ai_assistant_page.dart';
import '../../features/settings/presentation/pages/settings_pricing_page.dart';

// --- Navigator Keys ---
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorDashboard = GlobalKey<NavigatorState>(debugLabel: 'shell_dashboard');
final GlobalKey<NavigatorState> _shellNavigatorSearch = GlobalKey<NavigatorState>(debugLabel: 'shell_search');
final GlobalKey<NavigatorState> _shellNavigatorBrain = GlobalKey<NavigatorState>(debugLabel: 'shell_brain');
final GlobalKey<NavigatorState> _shellNavigatorJournals = GlobalKey<NavigatorState>(debugLabel: 'shell_journals');
final GlobalKey<NavigatorState> _shellNavigatorProfile = GlobalKey<NavigatorState>(debugLabel: 'shell_profile');

// Fix: Prevents the web URL / emulator history from overriding programmatic
// navigation, ensuring every restart begins at the declared initialLocation.
// ignore: deprecated_member_use
final bool _initImperativeAPIs = GoRouter.optionURLReflectsImperativeAPIs = true;

GoRouter buildAppRouter() {
  // Consuming _initImperativeAPIs to avoid lint warnings on the side-effectful assignment.
  assert(_initImperativeAPIs);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/', // Always boot from the Onboarding screen
    debugLogDiagnostics: true, // Log every navigation transition to console

    // Failsafe redirect: if the router ever resolves a null/empty path,
    // forcibly redirect to '/' so the Onboarding screen is shown.
    redirect: (context, state) {
      final path = state.fullPath;
      if (path == null || path.isEmpty) return '/';
      return null;
    },

    routes: [
      // --- Root: Onboarding ---
      GoRoute(
        path: '/',
        builder: (context, state) => const OnboardingPage(),
      ),

      // --- Shell: Main App Navigation ---
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
                builder: (context, state) => const AlzheimerDashboardPage(),
                routes: [
                  GoRoute(
                    path: 'details/:id',
                    builder: (context, state) {
                      final detailId = state.pathParameters['id'] ?? 'today';
                      return GeneralDetailPage(id: detailId);
                    },
                  ),
                  GoRoute(
                    path: 'student-details/:id',
                    builder: (context, state) {
                      final detailId = state.pathParameters['id'] ?? 'today';
                      return StudentDetailPage(id: detailId);
                    },
                  ),
                  GoRoute(
                    path: 'alzheimer-details/:id',
                    builder: (context, state) {
                      final detailId = state.pathParameters['id'] ?? 'today';
                      return AlzheimerDetailPage(id: detailId);
                    },
                  ),
                ],
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
                builder: (context, state) => const AiAssistantPage(),
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
                builder: (context, state) => const SettingsPricingPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
