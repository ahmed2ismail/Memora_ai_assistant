import 'package:flutter/material.dart';

typedef AdaptiveBuilder = Widget Function(BuildContext context, BoxConstraints constraints);

class AdaptiveLayoutWidget extends StatelessWidget {
  final AdaptiveBuilder mobile;
  final AdaptiveBuilder? tablet;
  final AdaptiveBuilder? desktop;

  const AdaptiveLayoutWidget({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 900) {
          return (desktop ?? tablet ?? mobile)(context, constraints);
        } else if (constraints.maxWidth >= 600) {
          return (tablet ?? mobile)(context, constraints);
        } else {
          return mobile(context, constraints);
        }
      },
    );
  }
}
