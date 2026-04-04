import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/widgets/glass_card.dart';
import '../../../domain/entities/alzheimer_models.dart';

class AlzheimerAiCard extends StatelessWidget {
  final AlzheimerAiPrompt aiPrompt;

  const AlzheimerAiCard({
    super.key,
    required this.aiPrompt,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [AppColors.primary, Color(0xFF00A471)]),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.psychology, color: Color(0xFF003824)),
              ),
              const SizedBox(width: 16),
              Text("Memora AI", style: AppStyles.body24(context)),
            ],
          ),
          const SizedBox(height: 16),
          Text(aiPrompt.message,
              style: AppStyles.body16(context, color: AppColors.onSurfaceVariant)
                  .copyWith(fontStyle: FontStyle.italic, height: 1.5)),
          const SizedBox(height: 24),
          const Divider(color: AppColors.surfaceContainerHighest, thickness: 2),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: aiPrompt.suggestions
                .map((suggestion) => _buildSuggestionPill(context, suggestion))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionPill(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(text, style: AppStyles.body12(context, color: AppColors.primary)),
    );
  }
}
