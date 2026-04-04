import 'package:flutter/material.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

class MemoraApp extends StatefulWidget {
  const MemoraApp({super.key});

  @override
  State<MemoraApp> createState() => _MemoraAppState();
}

class _MemoraAppState extends State<MemoraApp> {
  // The router is created once per State lifecycle — not per widget build.
  // This means it resets correctly on Hot Restart (State is recreated)
  // but stays stable during normal widget rebuilds (no unnecessary recreation).
  late final _router = buildAppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Memora AI Assistant',
      theme: AppTheme.darkTheme,
      routerConfig: _router,
    );
  }
}
