import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';

class GeneralDetailHeroMap extends StatelessWidget {
  final String reminder;

  const GeneralDetailHeroMap({
    super.key,
    required this.reminder,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 420,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://lh3.googleusercontent.com/aida-public/AG849m6sJ6-g_qK9HjZ9jY6j6-g_qK9HjZ9jY6j6-g_qK9HjZ9jY6j6-g_qK9HjZ9jY6j6-g_qK9HjZ9jY6j6-g_qK9HjZ9jY6j6-g_qK9HjZ9jY6j6-g_qK9HjZ9jY6j6-g_qK9HjZ9jY6j6-g_qK9HjZ9jY6j6-g_qK9Hj_qK9HjZ9jY6"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 420,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.1),
                Colors.black.withValues(alpha: 0.7)
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 48,
          left: 24,
          right: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "LOCATION REMINDER",
                  style: AppStyles.custom(context,
                      color: Colors.white, fontSize: 10, weight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  reminder,
                  style: AppStyles.headline(context, fontSize: 40, color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.directions_walk, color: Colors.white70, size: 16),
                  const SizedBox(width: 8),
                  Text("2 mins away • Supermarket",
                      style: AppStyles.body14(context, color: Colors.white70)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
