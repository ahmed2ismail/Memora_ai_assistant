import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/widgets/glass_card.dart';

class AlzheimerSafeZoneMap extends StatelessWidget {
  const AlzheimerSafeZoneMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Safe Zone Monitoring",
          style: AppStyles.custom(context, fontSize: 18, weight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GlassCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  image: const DecorationImage(
                    image: NetworkImage(
                        "https://lh3.googleusercontent.com/aida-public/AB6AXuAWvq7SKhn4n6SbYJ0j1-rzjYqjJKDReiA3PqTTsxrXG1L7eG4kCC-gZ5vMRp1IIP6-ihZbIviNthYuVH8S6w3NJz7l8Lx7rZkT_GCrkndGGHkFJRogHjZo6g8Wf7fV9LQZwq3gatrZW5tbEJwYMFJhg0sqtYfpgpMhuAMwwjv_O-MPaIrnOiElGAl3a27V2YN0YpUGPtvdt3nBfWtUO1FBGmmlgW_zEEj-zc4y4_ffSmCc4bvF6btxSeTYphr0fj94Yl5h8Nh-aDNr"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person_pin_circle, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    const Icon(Icons.verified_user, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Status: Secured",
                              style: AppStyles.body14(context, weight: FontWeight.bold)),
                          Text("Patient is currently within the living room zone.",
                              style: AppStyles.body12(context)),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
