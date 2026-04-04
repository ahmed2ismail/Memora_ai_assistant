import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../domain/entities/alzheimer_models.dart';

class AlzheimerDetailHero extends StatelessWidget {
  final IdentityRecognitionData identityData;

  const AlzheimerDetailHero({
    super.key,
    required this.identityData,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 380,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(identityData.imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 380,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.1),
                Colors.black.withValues(alpha: 0.6)
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 24,
          right: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "IDENTITY VERIFIED",
                  style: AppStyles.custom(
                    context,
                    color: Colors.white,
                    fontSize: 10,
                    weight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  identityData.instruction,
                  style:
                      AppStyles.headline(context, fontSize: 48, color: Colors.white),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.primary, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    "Home • Living Room",
                    style: AppStyles.body14(context, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
