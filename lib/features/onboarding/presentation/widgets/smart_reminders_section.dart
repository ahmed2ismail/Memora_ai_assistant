import 'package:flutter/material.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/primary_button.dart';

class SmartRemindersSection extends StatelessWidget {
  final VoidCallback onNext;

  const SmartRemindersSection({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF2D3449).withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "INTELLIGENT",
              style: TextStyle(
                color: Color(0xFFE9C349),
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Smart reminders powered by AI",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 24),
          Text(
            "More than just alerts. Memora predicts when you need information most, surfacing memories and tasks before you even have to ask.",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 48),
          GlassCard(
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.psychology, color: Color(0xFFE9C349), size: 32),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Medication Check", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Based on your morning routine", style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                    const Text("JUST NOW", style: TextStyle(color: Color(0xFF4EDEA3), fontSize: 12)),
                  ],
                ),
              ],
            ),
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
}
