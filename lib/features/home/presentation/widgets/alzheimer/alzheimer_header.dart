import 'package:flutter/material.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../cubit/alzheimer/dashboard/alzheimer_dashboard_state.dart';

class AlzheimerHeader extends StatelessWidget {
  final AlzheimerDashboardLoaded state;

  const AlzheimerHeader({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            "Good morning, ${state.patientName}.",
            style: AppStyles.headline(context, fontSize: 36),
          ),
        ),
        const SizedBox(height: 8),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            state.dateAndWeather,
            style: AppStyles.body16(context),
          ),
        ),
      ],
    );
  }
}
