import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/widgets/glass_card.dart';
import '../../../domain/entities/student_models.dart';
import '../../cubit/student/detail/student_detail_cubit.dart';

class StudentQuickActionCard extends StatelessWidget {
  final QuickActionItem item;

  const StudentQuickActionCard({
    super.key,
    required this.item,
  });

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'event': return Icons.event;
      case 'note': return Icons.note_add;
      case 'forum': return Icons.forum;
      case 'map': return Icons.map;
      default: return Icons.star;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<StudentDetailCubit>().triggerAction("OPENING ${item.label.toUpperCase()}...");
      },
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_getIcon(item.iconName), color: AppColors.primary, size: 20),
            const SizedBox(width: 12),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(item.label, style: AppStyles.body14(context, weight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
