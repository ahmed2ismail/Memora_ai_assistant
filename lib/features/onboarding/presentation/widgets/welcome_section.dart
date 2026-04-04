import 'package:flutter/material.dart';
import '../../../../core/widgets/primary_button.dart';

class WelcomeSection extends StatelessWidget {
  final VoidCallback onNext;

  const WelcomeSection({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF4EDEA3), Color(0xFF00A471)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4EDEA3).withValues(alpha: 0.3),
                    blurRadius: 80,
                    spreadRadius: 20,
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.auto_awesome,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 60),
            Text(
              "Remember everything\neffortlessly.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 24),
            Text(
              "Your digital sanctuary for memories, powered by an AI that understands the rhythm of your life.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 48),
            PrimaryButton(
              text: "Begin Your Journey",
              onPressed: onNext,
            ),
          ],
        ),
      ),
    );
  }
}
