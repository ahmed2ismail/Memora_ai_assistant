import 'package:flutter/material.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/primary_button.dart';

class PersonalizedFeatureSection extends StatelessWidget {
  final VoidCallback onNext;

  const PersonalizedFeatureSection({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildFeatureCard("Faces", Icons.face, const Color(0xFF4EDEA3)),
              _buildFeatureCard("Journals", Icons.history_edu, const Color(0xFFE9C349)),
              _buildFeatureCard("Health", Icons.favorite, const Color(0xFFE9C349)),
              _buildFeatureCard("Secure Sync", Icons.cloud, const Color(0xFF4EDEA3)),
            ],
          ),
          const SizedBox(height: 48),
          Text(
            "Personalized for\nyour lifestyle",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 16),
          Text(
            "Whether you are capturing lectures, managing health challenges, or documenting your family history, Memora adapts its interface and algorithms to your unique cognitive needs.",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 48),
          Center(
            child: PrimaryButton(
              text: "Continue",
              onPressed: onNext,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(String title, IconData icon, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
