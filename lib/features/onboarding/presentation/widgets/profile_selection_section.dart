import 'package:flutter/material.dart';
import '../../../../core/widgets/glass_card.dart';

class ProfileSelectionSection extends StatelessWidget {
  final VoidCallback onProfileSelected;

  const ProfileSelectionSection({super.key, required this.onProfileSelected});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Who are you?",
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            "We tailor your experience based on your journey.",
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          _buildProfileCard(
            context,
            "Alzheimer Patient",
            "Focused on routine, family recognition, and critical daily safety reminders.",
            Icons.medical_services,
            const Color(0xFF4EDEA3),
            onProfileSelected,
          ),
          const SizedBox(height: 16),
          _buildProfileCard(
            context,
            "Student",
            "Optimized for rapid information retrieval, study schedules, and knowledge mapping.",
            Icons.school,
            const Color(0xFFE9C349),
            onProfileSelected,
          ),
          const SizedBox(height: 16),
          _buildProfileCard(
            context,
            "General User",
            "Versatile memory assistance for journaling life, events, and personal productivity.",
            Icons.person_pin,
            const Color(0xFFDAE2FD),
            onProfileSelected,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, String title, String description, IconData icon, Color color, VoidCallback onTap) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF171F33),
            ),
            child: Icon(icon, color: color, size: 40),
          ),
          const SizedBox(height: 16),
          Text(title, style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 24)),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF222A3D),
                foregroundColor: color,
              ),
              onPressed: onTap,
              child: const Text("Select Profile"),
            ),
          )
        ],
      ),
    );
  }
}
